import 'package:dio/dio.dart';
import '../error/app_exception.dart';

class DioErrorMapper {
  static AppException map(DioException e) {
    final status = e.response?.statusCode;
    final data = e.response?.data;

    String? backendMessage;
    String? backendCode;

    if (data is Map<String, dynamic>) {
      backendMessage =
          data['message']?.toString() ??
              data['detail']?.toString() ??
              data['title']?.toString() ??
              _firstValidationError(data);
      backendCode = data['code']?.toString();
    }

    // Timeout / no internet / cancel
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const AppException(
          message: 'Request timed out. Please try again.',
          code: 'timeout',
        );

      case DioExceptionType.connectionError:
        return const AppException(
          message: 'No internet connection. Check your network and try again.',
          code: 'network_error',
        );

      case DioExceptionType.cancel:
        return const AppException(
          message: 'Request was cancelled.',
          code: 'cancelled',
        );

      case DioExceptionType.badCertificate:
        return const AppException(
          message: 'Secure connection failed. Please try again later.',
          code: 'bad_certificate',
        );

      case DioExceptionType.badResponse:
        return _fromStatusCode(status, backendMessage, backendCode);

      case DioExceptionType.unknown:
        return AppException(
          message: backendMessage ?? 'Something went wrong. Please try again.',
          code: backendCode ?? 'unknown',
          statusCode: status,
        );
    }
  }

  static AppException _fromStatusCode(
      int? status,
      String? backendMessage,
      String? backendCode,
      ) {
    switch (status) {
      case 400:
        return AppException(
          message: backendMessage ?? 'Invalid request. Please check your input.',
          code: backendCode ?? 'bad_request',
          statusCode: status,
        );
      case 401:
        return const AppException(
          message: 'Your session has expired. Please sign in again.',
          code: 'unauthorized',
          statusCode: 401,
        );
      case 403:
        return const AppException(
          message: 'You do not have permission to perform this action.',
          code: 'forbidden',
          statusCode: 403,
        );
      case 404:
        return AppException(
          message: backendMessage ?? 'The requested resource was not found.',
          code: backendCode ?? 'not_found',
          statusCode: status,
        );
      case 409:
        return AppException(
          message: backendMessage ?? 'Conflict detected. Data may already exist.',
          code: backendCode ?? 'conflict',
          statusCode: status,
        );
      case 422:
        return AppException(
          message: backendMessage ?? 'Validation failed. Please review your input.',
          code: backendCode ?? 'validation_error',
          statusCode: status,
        );
      case 500:
      case 502:
      case 503:
      case 504:
        return const AppException(
          message: 'Server is currently unavailable. Please try again shortly.',
          code: 'server_error',
        );
      default:
        return AppException(
          message: backendMessage ?? 'Unexpected server response. Please try again.',
          code: backendCode ?? 'http_error',
          statusCode: status,
        );
    }
  }

  static String? _firstValidationError(Map<String, dynamic> data) {
    final errors = data['errors'];
    if (errors is Map<String, dynamic>) {
      for (final value in errors.values) {
        if (value is List && value.isNotEmpty) return value.first.toString();
      }
    }
    return null;
  }
}