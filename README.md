# VenueFlow Frontend

Frontend application for VenueFlow, built with **Flutter** and **Riverpod**, following a clean, feature-first architecture.

## Tech Stack

- **Flutter** (Web/Desktop/Mobile capable)
- **Riverpod** for state management and dependency injection
- **Dio** for HTTP communication
- **go_router** for navigation
- **Flutter Secure Storage** for token persistence
- **Material 3** theming with custom design tokens

---

## Project Goals

- Scalable architecture for multi-tenant venue management
- Clean separation of concerns (presentation, application, domain, data)
- Consistent API communication and error handling
- Reusable UI primitives based on `DESIGN.md`

---

## Getting Started

## 1) Prerequisites

- Flutter SDK installed
- Backend API running locally (VenueFlow API)

## 2) Install dependencies

```bash
flutter pub get
```

## 3) Run the app

### Chrome (example)
```bash
flutter run -d chrome --web-port 3000 --dart-define=API_BASE_URL=http://localhost:5034/api
```

### Android Emulator
```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:5034/api
```

### Physical Device
```bash
flutter run --dart-define=API_BASE_URL=http://<YOUR_LAN_IP>:5034/api
```

---

## Environment Configuration

The app uses compile-time environment variables:

- `API_BASE_URL`

Defined in:
- `lib/core/config/env.dart`

Example:
```dart
static const apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:5034/api',
);
```

---

## Authentication Flow

1. User logs in via `/auth/login`
2. JWT token is stored in secure storage
3. Dio interceptor injects `Authorization: Bearer <token>`
4. App fetches `/auth/me` to establish session and tenant context
5. Router guards redirect users based on authentication state

---

## Multi-Tenancy (Frontend Perspective)

- Frontend does **not** send or manage `TenantId` for normal CRUD payloads.
- Tenant scope is enforced by backend using JWT `tenant_id` claim.
- Frontend reads `tenant_id` from `/auth/me` for display/context only.

---

## Folder Structure (High-Level)

```text
lib/
  app/
    app.dart
    router.dart
    shell/
    theme/
  core/
    config/
    network/
    storage/
    error/
    result/
    common/
  features/
    auth/
    dashboard/
    customers/
    venues/
    bookings/
    tenant/
  shared/
    widgets/
```

See `ARCHITECTURE.md` for full details.

---

## Common Scripts

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
```

---

## Troubleshooting

## Font asset errors
If you see:
`unable to locate asset entry in pubspec.yaml`

- Ensure font files exist under `assets/fonts/`
- Ensure names in `pubspec.yaml` exactly match real filenames

## Backend connection fails
- Check API is running
- Verify correct `API_BASE_URL`
- For Android emulator, use `10.0.2.2` (not localhost)

## 401 Unauthorized
- Token may be missing/expired
- Re-login and verify `/auth/me` works

---

## Current Status

- Base architecture scaffolded
- Theme system integrated from `DESIGN.md`
- Customers vertical slice in progress (list/create/edit/delete/paging)
- Next: Venues and Bookings modules

---

## Contributing

1. Create a feature branch
2. Follow architecture and folder conventions
3. Keep business logic out of UI widgets
4. Add/update docs if behavior changes