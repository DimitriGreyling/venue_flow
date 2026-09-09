import 'package:dio/dio.dart';

class ApiClient {
  ApiClient(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> getJson(String path) async {
    try {
      final response = await _dio.get(path);
      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }
      if (response.data is Map) {
        return Map<String, dynamic>.from(response.data as Map);
      }
      throw const ApiException('Unexpected API response format.');
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }
}

class ApiException implements Exception {
  const ApiException(this.message);

  factory ApiException.fromDio(DioException error) {
    final message = switch (error.type) {
      DioExceptionType.connectionTimeout => 'Connection timed out.',
      DioExceptionType.sendTimeout => 'Request timed out.',
      DioExceptionType.receiveTimeout => 'Response timed out.',
      DioExceptionType.badResponse => 'The server rejected the request.',
      DioExceptionType.cancel => 'Request was cancelled.',
      _ => 'Unable to reach the server right now.',
    };

    return ApiException(message);
  }

  final String message;

  @override
  String toString() => 'ApiException: $message';
}
