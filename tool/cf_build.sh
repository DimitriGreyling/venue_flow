#!/usr/bin/env bash
set -euo pipefail

# Enable verbose logs in Cloudflare by setting DEBUG=1 in Pages env vars
if [ "${DEBUG:-}" = "1" ]; then
  set -x
fi

FLUTTER_VERSION="${FLUTTER_VERSION:-3.41.9}"
FLUTTER_CHANNEL="${FLUTTER_CHANNEL:-stable}"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FLUTTER_DIR="${ROOT_DIR}/.flutter"

cd "${ROOT_DIR}"

echo "Using Flutter ${FLUTTER_VERSION} (${FLUTTER_CHANNEL})"
echo "Repo: ${ROOT_DIR}"
ls -la

version_ge() {
  # usage: version_ge <current> <required>
  [ "$(printf '%s\n' "$1" "$2" | sort -V | head -n1)" = "$2" ]
}

# Download Flutter SDK (Linux) into .flutter/
needs_download="0"
installed_flutter_version=""

if [ ! -x "${FLUTTER_DIR}/bin/flutter" ]; then
  needs_download="1"
else
  installed_flutter_version="$(${FLUTTER_DIR}/bin/flutter --version --machine 2>/dev/null | sed -n 's/.*"frameworkVersion":"\([^"]*\)".*/\1/p')"
  if [ -z "${installed_flutter_version}" ] || [ "${installed_flutter_version}" != "${FLUTTER_VERSION}" ]; then
    echo "Installed Flutter (${installed_flutter_version:-unknown}) does not match requested ${FLUTTER_VERSION}."
    needs_download="1"
  fi
fi

if [ "${needs_download}" = "1" ]; then
  echo "Downloading Flutter SDK..."

  rm -rf "${FLUTTER_DIR}" "${ROOT_DIR}/flutter"

  ARCHIVE="flutter_linux_${FLUTTER_VERSION}-${FLUTTER_CHANNEL}.tar.xz"
  URL="https://storage.googleapis.com/flutter_infra_release/releases/${FLUTTER_CHANNEL}/linux/${ARCHIVE}"

  curl -fsSL "${URL}" -o "${ARCHIVE}"
  tar xf "${ARCHIVE}" -C "${ROOT_DIR}"
  rm -f "${ARCHIVE}"

  mv "${ROOT_DIR}/flutter" "${FLUTTER_DIR}"
fi

FLUTTER_BIN="${FLUTTER_DIR}/bin/flutter"

echo "Flutter at: ${FLUTTER_BIN}"
"${FLUTTER_BIN}" --version

CURRENT_DART_VERSION="$(${FLUTTER_BIN} dart --version 2>&1 | sed -n 's/.*version: \([0-9][0-9.]*\).*/\1/p')"
REQUIRED_DART_VERSION="$(grep -E '^[[:space:]]*sdk:[[:space:]]*\^?[0-9]+\.[0-9]+\.[0-9]+' "${ROOT_DIR}/pubspec.yaml" | head -n1 | sed -E 's/.*\^?([0-9]+\.[0-9]+\.[0-9]+).*/\1/')"

if [ -n "${CURRENT_DART_VERSION}" ] && [ -n "${REQUIRED_DART_VERSION}" ]; then
  if ! version_ge "${CURRENT_DART_VERSION}" "${REQUIRED_DART_VERSION}"; then
    echo "ERROR: Flutter bundle has Dart ${CURRENT_DART_VERSION}, but pubspec requires >= ${REQUIRED_DART_VERSION}."
    echo "Set FLUTTER_VERSION in Cloudflare to a newer release or lower pubspec sdk constraint."
    exit 1
  fi
fi

# Reduce noise in Cloudflare logs
"${FLUTTER_BIN}" config --no-analytics --no-cli-animations > /dev/null || true
"${FLUTTER_BIN}" config --enable-web > /dev/null || true

# ---- .env handling ----
# Cloudflare Pages MUST provide these env vars, unless you commit .env to the repo.
supabase_url="${SUPABASE_URL-}"
supabase_anon="${SUPABASE_ANON_KEY-}"

echo "SUPABASE_URL present? $([ -n "${supabase_url}" ] && echo yes || echo no)"
echo "SUPABASE_ANON_KEY present? $([ -n "${supabase_anon}" ] && echo yes || echo no)"
echo "SUPABASE_ANON_KEY length: ${#supabase_anon}"

if [ -n "${supabase_url}" ] && [ -n "${supabase_anon}" ]; then
  echo "Generating .env from Cloudflare environment variables..."
  cat > "${ROOT_DIR}/.env" <<EOF
SUPABASE_URL=${supabase_url}
SUPABASE_ANON_KEY=${supabase_anon}
EOF
else
  # If you choose to commit .env (public values for web), this will allow builds to proceed.
  if [ -f "${ROOT_DIR}/.env" ]; then
    echo "Using existing .env from repo."
  else
    echo "ERROR: Missing SUPABASE_URL / SUPABASE_ANON_KEY in Cloudflare Pages build environment."
    echo "Fix: Cloudflare Pages Project -> Settings -> Environment variables"
    echo "Add BOTH variables in the correct environment (Production/Preview) and redeploy."
    exit 1
  fi
fi

# Build
"${FLUTTER_BIN}" pub get
"${FLUTTER_BIN}" build web --release --web-renderer canvaskit

# if you do not need offline/PWA behavior, disable the Flutter service worker.
# This is the simplest way to guarantee users see the latest deployment.
# Change the build command in cf_build.sh from:
# "${FLUTTER_BIN}" build web --release --web-renderer canvaskit --pwa-strategy=none

echo "Build complete. Output:"
ls -la "${ROOT_DIR}/build/web" | head -n 60