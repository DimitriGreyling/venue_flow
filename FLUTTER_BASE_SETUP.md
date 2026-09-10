# Flutter Base Setup Plan

This is the recommended base setup for VenueFlow before adding more features.

## 1. Core foundation to keep

- `flutter_riverpod` for state management and dependency injection
- `go_router` for navigation and auth redirects
- `dio` for HTTP
- `flutter_secure_storage` for session persistence
- `freezed` + `json_serializable` for models
- Material 3 theme with Inter typography

## 2. App architecture

Keep the current feature-first layout:

```text
lib/
  app/
    app.dart
    router.dart
    theme/
  core/
    config/
    network/
    storage/
    error/
    result/
  features/
    <feature>/
      domain/
      data/
      application/
      presentation/
```

## 3. Priority implementation order

### Phase 1: auth/session base

1. Keep `features/login/domain/auth_session.dart` as the session model.
2. Add `/auth/me` session bootstrap to `features/login/data/auth_repository.dart`.
3. Make `features/login/application/auth_controller.dart` the startup session source of truth.
4. Keep session persistence isolated in `core/storage/secure_storage.dart`.

### Phase 2: routing and app shell

1. Make `/sign-in` the public route.
2. Protect all authenticated routes with `go_router` redirects.
3. Add an authenticated shell route for shared layout.
4. Keep `app/app.dart` as the single `MaterialApp.router` entry.

### Phase 3: shared infrastructure

1. Keep `core/config/env.dart` as the only API base URL source.
2. Keep `core/network/dio_provider.dart` as the single Dio configuration point.
3. Keep `core/network/api_client.dart` for normalized API error mapping.
4. Use `core/error/failure.dart` and `core/result/result.dart` as shared app primitives.

### Phase 4: UI system

1. Finish `app/theme/app_theme.dart`.
2. Keep `app/theme/app_colors.dart` as the design token source.
3. Keep `app/theme/app_text_theme.dart` for typography.

### Phase 5: feature template

For every new feature:

1. `domain`: entity + repository contract
2. `data`: DTOs + datasource + repository implementation
3. `application`: Riverpod controller/notifier
4. `presentation`: screen/widgets only

## 4. First feature order

Recommended order after auth:

1. `dashboard`
2. `venues`
3. `customers`
4. `bookings`

## 5. Files to touch first

1. `lib/app/router.dart`
2. `lib/app/app.dart`
3. `lib/main.dart`
4. `lib/core/network/api_client.dart`
5. `lib/core/network/dio_provider.dart`
6. `lib/features/login/application/auth_controller.dart`
7. `lib/features/login/data/auth_repository.dart`
8. `lib/app/theme/app_theme.dart`

## 6. Notes

- Do not duplicate error or exception types across layers.
- Do not call Dio directly from presentation widgets.
- Do not hardcode backend URLs in features.
- Keep routing and session state aligned.
