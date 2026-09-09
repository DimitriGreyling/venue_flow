# VenueFlow Frontend How-To Guide

This guide explains how the VenueFlow frontend is structured, how to set it up locally, how to extend it, and how the app architecture is meant to work.

---

## 1. Project overview

This project is a Flutter frontend for VenueFlow, built with:

- Flutter
- Riverpod for state management
- Dio for HTTP communication
- GoRouter for navigation
- Material 3 theming
- Secure storage ready for auth/session handling

The project follows a feature-first architecture with a clean separation between:

- presentation layer
- application layer
- domain layer
- data layer

---

## 2. Prerequisites

Before starting, make sure you have the following installed:

- Flutter SDK 3.7+
- A backend API running locally or on a reachable host
- A browser or mobile emulator for running the app

---

## 3. Local setup

From the project root:

```bash
cd C:\Development\Venue_Flow\venue_flow
flutter pub get
```

Run the app in the browser:

```bash
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:5034/api
```

Run on Android emulator:

```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:5034/api
```

Run on physical device:

```bash
flutter run --dart-define=API_BASE_URL=http://<YOUR_LAN_IP>:5034/api
```

---

## 4. Project structure

```text
lib/
  main.dart
  app/
    app.dart
    router.dart
    theme/
      app_theme.dart
      app_colors.dart
      app_text_theme.dart
  core/
    config/
      env.dart
    network/
      dio_provider.dart
      api_client.dart
    error/
      failure.dart
    result/
      result.dart
  features/
    dashboard/
      application/
        dashboard_controller.dart
      data/
        dashboard_repository.dart
      domain/
        dashboard_summary.dart
      presentation/
        dashboard_screen.dart
```

---

## 5. How the app boots

The app startup flow is:

1. `main.dart` runs the app inside `ProviderScope`
2. `VenueFlowApp` creates `MaterialApp.router`
3. `AppRouter` defines the route configuration
4. The initial route loads the dashboard screen

This is the entry point for the frontend app lifecycle.

---

## 6. Routing

Routes are declared in:

- `lib/app/router.dart`

Current setup:

- `/` redirects to `/dashboard`
- `/dashboard` loads the dashboard screen

Add new routes by creating a new `GoRoute` in the `routes` array.

Example:

```dart
GoRoute(
  path: '/customers',
  builder: (_, __) => const CustomersScreen(),
),
```

---

## 7. Theme system

The design tokens live in:

- `lib/app/theme/app_colors.dart`
- `lib/app/theme/app_text_theme.dart`
- `lib/app/theme/app_theme.dart`

These files define:

- colors
- typography
- spacing-related theme defaults
- Material 3 design configuration

The app currently follows the `Modern Venue Intelligence` brand palette and typography specification.

---

## 8. API layer

The network configuration is in:

- `lib/core/config/env.dart`
- `lib/core/network/dio_provider.dart`
- `lib/core/network/api_client.dart`

### `Env`
Defines the environment variable:

```dart
static const apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:5034/api',
);
```

### `dioProvider`
Creates the shared Dio instance and sets default headers/timeouts.

### `ApiClient`
Wraps Dio operations and returns parsed JSON or raises a structured API exception.

This keeps raw network code away from UI logic.

---

## 9. State management pattern

The project uses Riverpod in a feature-oriented way.

### Example flow

- UI screen watches a provider
- provider/controller reads repository
- repository calls API
- data is mapped into domain models
- UI renders loading, success, or error states

The dashboard example is in:

- `lib/features/dashboard/application/dashboard_controller.dart`
- `lib/features/dashboard/data/dashboard_repository.dart`
- `lib/features/dashboard/domain/dashboard_summary.dart`
- `lib/features/dashboard/presentation/dashboard_screen.dart`

This is the recommended pattern for all future features.

---

## 10. Feature architecture pattern

Each feature should follow this structure:

```text
features/your_feature/
  domain/
    your_model.dart
    your_repository.dart
  data/
    your_dto.dart
    your_api_datasource.dart
    your_repository_impl.dart
  application/
    your_controller.dart
  presentation/
    your_screen.dart
    your_form.dart
```

### responsibilities

#### Domain layer
- entities and repository contracts
- no Flutter or Dio dependencies

#### Data layer
- DTO conversion
- API datasource calls
- repository implementation

#### Application layer
- Riverpod providers/controllers
- loading, data, and error state handling

#### Presentation layer
- widgets and screens
- no direct Dio calls
- no business logic in widgets

---

## 11. How to add a new screen

1. Create the feature folder
2. Add domain model/entity
3. Add repository contract and implementation
4. Add a Riverpod controller/provider
5. Build the screen widget
6. Register the route in `lib/app/router.dart`

Example:

```dart
class ExampleScreen extends ConsumerWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example')),
      body: const Center(child: Text('Hello')),
    );
  }
}
```

---

## 12. How to add an API request

Use the existing repository pattern.

Example idea:

```dart
Future<List<Customer>> fetchCustomers() async {
  final data = await _apiClient.getJson('/customers');
  return data['items'].map<Customer>((json) => Customer.fromJson(json)).toList();
}
```

Then call that from a controller or notifier.

The important rule: keep API logic out of the UI layer.

---

## 13. Error handling

The project includes a base failure model:

- `lib/core/error/failure.dart`

A result pattern is also scaffolded in:

- `lib/core/result/result.dart`

Recommended pattern:

- API exceptions map to app-level failures
- UI shows readable user messages
- raw stack traces stay out of presentation layer

---

## 14. Current dashboard example

The dashboard screen demonstrates the intended frontend pattern:

- data fetched from a repository
- state managed by a Riverpod controller
- UI renders loading, success, and error states
- design system colors and typography are applied

The current dashboard is a real starting point for future modules like:

- venues
- bookings
- customers
- tenant overview
- operations analytics

---

## 15. Common commands

Install dependencies:

```bash
flutter pub get
```

Analyze the project:

```bash
flutter analyze
```

Run the app:

```bash
flutter run
```

Run tests:

```bash
flutter test
```

---

## 16. Troubleshooting

### Font asset issues
If you see asset-not-found or font-not-loaded errors:

- confirm the font files exist under `assets/fonts/`
- confirm names match `pubspec.yaml`

### API connection fails
- verify the backend is running
- verify the URL in `API_BASE_URL`
- use `10.0.2.2` for Android emulator instead of `localhost`

### 401 or 403 errors
- token may be missing or expired
- auth flow may not have run yet
- verify backend auth contract

---

## 17. Recommended next steps

The next logical features for this app are:

1. login/auth flow
2. secure token storage
3. venues module
4. bookings module
5. customers module
6. tenant context handling
7. shared table and form components

---

## 18. Summary

This codebase is intentionally set up as a scalable Flutter frontend starter for VenueFlow.

The main ideas are:

- clean layering
- Riverpod-based state management
- API calls through a shared Dio client
- design-driven UI with a modern venue operations theme
- clear structure for future modules

If you keep the architecture consistent as the app grows, the frontend will stay easy to maintain and extend.
