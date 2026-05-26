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
  # returns 0 if current >= required
  local current="$1"
  local required="$2"

  IFS='.' read -r c1 c2 c3 <<< "$current"
  IFS='.' read -r r1 r2 r3 <<< "$required"

  c1=${c1:-0}; c2=${c2:-0}; c3=${c3:-0}
  r1=${r1:-0}; r2=${r2:-0}; r3=${r3:-0}

  if [ "$c1" -gt "$r1" ]; then return 0; fi
  if [ "$c1" -lt "$r1" ]; then return 1; fi

  if [ "$c2" -gt "$r2" ]; then return 0; fi
  if [ "$c2" -lt "$r2" ]; then return 1; fi

  if [ "$c3" -ge "$r3" ]; then return 0; fi
  return 1
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

  if ! mv "${ROOT_DIR}/flutter" "${FLUTTER_DIR}"; then
    echo "Direct move failed (likely Windows/Git Bash permissions). Falling back to copy..."
    mkdir -p "${FLUTTER_DIR}"
    cp -a "${ROOT_DIR}/flutter/." "${FLUTTER_DIR}/"
    rm -rf "${ROOT_DIR}/flutter"
  fi
fi

FLUTTER_BIN="${FLUTTER_DIR}/bin/flutter"
DART_BIN="${FLUTTER_DIR}/bin/dart"

echo "Flutter at: ${FLUTTER_BIN}"
"${FLUTTER_BIN}" --version

CURRENT_DART_VERSION="$(${DART_BIN} --version 2>&1 | sed -n 's/.*version: \([0-9][0-9.]*\).*/\1/p' || true)"
REQUIRED_DART_VERSION="$(grep -E '^[[:space:]]*sdk:[[:space:]]*\^?[0-9]+\.[0-9]+\.[0-9]+' "${ROOT_DIR}/pubspec.yaml" | head -n1 | sed -E 's/.*\^?([0-9]+\.[0-9]+\.[0-9]+).*/\1/' || true)"

echo "Detected Dart in Flutter bundle: ${CURRENT_DART_VERSION:-unknown}"
echo "Required minimum Dart from pubspec: ${REQUIRED_DART_VERSION:-unknown}"

if [ -n "${CURRENT_DART_VERSION}" ] && [ -n "${REQUIRED_DART_VERSION}" ]; then
  if ! version_ge "${CURRENT_DART_VERSION}" "${REQUIRED_DART_VERSION}"; then
    echo "ERROR: Flutter bundle has Dart ${CURRENT_DART_VERSION}, but pubspec requires >= ${REQUIRED_DART_VERSION}."
    echo "Set FLUTTER_VERSION in Cloudflare to a newer release or lower pubspec sdk constraint."
    exit 1
  fi
else
  echo "WARNING: Skipping Dart SDK compatibility check because one or both versions could not be parsed."
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

WEB_BUILD_HELP="$(${FLUTTER_BIN} build web -h 2>&1 || true)"
if echo "${WEB_BUILD_HELP}" | grep -q -- "--web-renderer"; then
  echo "Building web with explicit renderer flag..."
  "${FLUTTER_BIN}" build web --release --web-renderer canvaskit
else
  echo "Building web with default renderer (current Flutter CLI does not support --web-renderer)..."
  "${FLUTTER_BIN}" build web --release
fi

# if you do not need offline/PWA behavior, disable the Flutter service worker.
# This is the simplest way to guarantee users see the latest deployment.
# Change the build command in cf_build.sh from:
# "${FLUTTER_BIN}" build web --release --web-renderer canvaskit --pwa-strategy=none

echo "Build complete. Output:"
ls -la "${ROOT_DIR}/build/web" | head -n 60