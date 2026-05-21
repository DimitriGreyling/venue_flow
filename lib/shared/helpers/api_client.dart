import 'package:dio/dio.dart';

// class ApiClient {
//   final Dio dio;

//   ApiClient()
//       : dio = Dio(BaseOptions(
//           baseUrl: "http://localhost:5082/api/",
//           connectTimeout: const Duration(seconds: 10),
//           receiveTimeout: const Duration(seconds: 10),
//           headers: {
//             'Content-Type': 'application/json',

//           },
//         ));
// }

class ApiClient {
  late final Dio dio;

  ApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: "http://localhost:5082/api",
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
          // You can inject token here later
          return handler.next(options);
        },
        onError: (e, handler) {
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
