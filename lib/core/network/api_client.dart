import 'package:dio/dio.dart';
import 'package:venue_flow_app/core/error/failure.dart';
import 'package:venue_flow_app/app/global_popup.dart';

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

      throw const Failure('Unexpected API response format.');
    } on DioException catch (error) {
      final failure = ApiClient.mapDioException(error);
      GlobalPopup.show(message: failure.message, mode: PopupMode.error);
      throw failure;
    }
  }

  static Failure mapDioException(DioException error) {
    final message = switch (error.type) {
      DioExceptionType.connectionTimeout => 'Connection timed out.',
      DioExceptionType.sendTimeout => 'Request timed out.',
      DioExceptionType.receiveTimeout => 'Response timed out.',
      DioExceptionType.badResponse => 'The server rejected the request.',
      DioExceptionType.cancel => 'Request was cancelled.',
      DioExceptionType.connectionError => 'No internet connection.',
      _ => 'Unable to reach the server right now.',
    };

    return Failure(message);
  }
}