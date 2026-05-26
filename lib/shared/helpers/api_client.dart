import 'package:dio/dio.dart';
import 'package:venue_flow_app/constants/api_contract.dart';

class ApiClient {
  late final Dio dio;
  String? _authToken;
  Future<String?> Function()? _onRefreshToken;
  Future<void> Function()? _onUnauthorized;
  Future<String?>? _activeRefresh;

  ApiClient() {
    dio = Dio(BaseOptions(
      // baseUrl: ApiEndpoints.productionUrl,
      baseUrl: ApiEndpoints.localUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),

      // IMPORTANT for web
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    ));

    _setupInterceptors();
  }

  void _setupInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final requiresAuth = options.extra['requiresAuth'] != false;
          if (requiresAuth && _authToken != null && _authToken!.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $_authToken';
          }
          return handler.next(options);
        },
        onError: (e, handler) async {
          if (_shouldRefreshToken(e)) {
            final refreshedToken = await _refreshAccessToken();

            if (refreshedToken != null && refreshedToken.isNotEmpty) {
              final retried = await _retryRequest(e.requestOptions, refreshedToken);
              if (retried != null) {
                return handler.resolve(retried);
              }
            }

            if (_onUnauthorized != null) {
              await _onUnauthorized!.call();
            }
          }

          final body = e.response?.data;
          String message = _extractMessage(body);

          if (message.isEmpty) {
            message = _fallbackByType(e);
          }

          handler.reject(
            DioException(
              requestOptions: e.requestOptions,
              response: e.response,
              type: e.type,
              error: message,
            ),
          );
        },
      ),
    );
  }

  void configureAuthHandlers({
    Future<String?> Function()? onRefreshToken,
    Future<void> Function()? onUnauthorized,
  }) {
    _onRefreshToken = onRefreshToken;
    _onUnauthorized = onUnauthorized;
  }

  void setAuthToken(String token) {
    _authToken = token;
  }

  void clearAuthToken() {
    _authToken = null;
  }

  bool _shouldRefreshToken(DioException error) {
    final statusCode = error.response?.statusCode;
    if (statusCode != 401 || _onRefreshToken == null) {
      return false;
    }

    if (error.requestOptions.extra['skipAuthRefresh'] == true ||
        error.requestOptions.extra['_retriedAfterRefresh'] == true) {
      return false;
    }

    final path = error.requestOptions.path.toLowerCase();
    if (path.contains(ApiEndpoints.authLogin) ||
        path.contains(ApiEndpoints.authRefresh)) {
      return false;
    }

    return true;
  }

  Future<String?> _refreshAccessToken() async {
    if (_activeRefresh != null) {
      return _activeRefresh;
    }

    _activeRefresh = _onRefreshToken!.call();
    try {
      final token = await _activeRefresh;
      if (token != null && token.isNotEmpty) {
        setAuthToken(token);
      }
      return token;
    } finally {
      _activeRefresh = null;
    }
  }

  Future<Response<dynamic>?> _retryRequest(
    RequestOptions requestOptions,
    String token,
  ) async {
    try {
      final headers = Map<String, dynamic>.from(requestOptions.headers);
      headers['Authorization'] = 'Bearer $token';

      final extra = Map<String, dynamic>.from(requestOptions.extra);
      extra['_retriedAfterRefresh'] = true;

      final retriedOptions = requestOptions.copyWith(
        headers: headers,
        extra: extra,
      );

      return await dio.fetch<dynamic>(retriedOptions);
    } catch (_) {
      return null;
    }
  }

  static String _extractMessage(dynamic body) {
    if (body == null) return "";
    if (body is String) return body;
    if (body is Map<String, dynamic>) {
      if (body["message"] is String) return body["message"] as String;
      if (body["error"] is String) return body["error"] as String;
      if (body["title"] is String) return body["title"] as String;
      if (body["errors"] != null) return body["errors"].toString();
    }
    return body.toString();
  }

  static String _fallbackByType(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return "Request timed out";
      case DioExceptionType.connectionError:
        return "Cannot reach server";
      case DioExceptionType.badResponse:
        return "Server error (${e.response?.statusCode})";
      case DioExceptionType.cancel:
        return "Request cancelled";
      default:
        return e.message ?? "Unknown error";
    }
  }
}
