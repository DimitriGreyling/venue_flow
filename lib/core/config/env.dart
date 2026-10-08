class Env {
  /// Set with:
  /// flutter run --dart-define=API_BASE_URL=https://localhost:5001/api
  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:5000/api',
  );
}