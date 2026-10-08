import 'package:dio/dio.dart';

enum AppErrorType {
  network,
  timeout,
  unauthorized,
  forbidden,
  notFound,
  validation,
  server,
  cancelled,
  unknown,
}

class AppException implements Exception {
  AppException(
      this.type,
      this.message, {
        this.title,
        this.fieldErrors = const {},
        this.statusCode,
      });

  final AppErrorType type;
  final String message;
  final String? title;
  final Map<String, List<String>> fieldErrors;
  final int? statusCode;

  /// Convert ANY thrown object into an AppException.
  factory AppException.from(Object error) {
    if (error is AppException) return error;
    if (error is DioException) {
      if (error.error is AppException) return error.error as AppException;
      return _fromDio(error);
    }
    return AppException(
      AppErrorType.unknown,
      'Something went wrong. Please try again.',
    );
  }

  static AppException _fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppException(AppErrorType.timeout,
            'The server took too long to respond.',
            title: 'Timeout');
      case DioExceptionType.connectionError:
        return AppException(AppErrorType.network,
            'Cannot reach the server. Check your connection (or CORS/certificate in dev).',
            title: 'No connection');
      case DioExceptionType.cancel:
        return AppException(AppErrorType.cancelled, 'Request cancelled.');
      default:
        break;
    }

    final status = e.response?.statusCode;
    final data = e.response?.data;

    // ASP.NET ProblemDetails / ValidationProblemDetails
    String? detail;
    String? title;
    final fields = <String, List<String>>{};
    if (data is Map) {
      detail = (data['detail'] ?? data['message']) as String?;
      title = data['title'] as String?;
      final errors = data['errors'];
      if (errors is Map) {
        errors.forEach((k, v) {
          if (v is List) fields[k.toString()] = v.map((x) => '$x').toList();
        });
      }
    } else if (data is String && data.isNotEmpty && data.length < 300) {
      detail = data;
    }

    switch (status) {
      case 400:
      case 422:
        final fieldMsg = fields.values.expand((x) => x).join('\n');
        return AppException(
          AppErrorType.validation,
          fieldMsg.isNotEmpty ? fieldMsg : (detail ?? 'Invalid request.'),
          title: title ?? 'Invalid data',
          fieldErrors: fields,
          statusCode: status,
        );
      case 401:
        return AppException(AppErrorType.unauthorized,
            detail ?? 'Your session has expired. Please sign in again.',
            title: 'Session expired', statusCode: status);
      case 403:
        return AppException(AppErrorType.forbidden,
            detail ?? 'You do not have permission to do that.',
            title: 'Access denied', statusCode: status);
      case 404:
        return AppException(AppErrorType.notFound,
            detail ?? 'The requested item was not found.',
            title: 'Not found', statusCode: status);
      default:
        if (status != null && status >= 500) {
          return AppException(AppErrorType.server,
              'The server hit a problem. Please try again later.',
              title: 'Server error', statusCode: status);
        }
        return AppException(AppErrorType.unknown,
            detail ?? 'Something went wrong. Please try again.',
            statusCode: status);
    }
  }

  @override
  String toString() => 'AppException($type, $message)';
}