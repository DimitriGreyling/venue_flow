import 'package:dio/dio.dart';
import '../error/app_exception.dart';
import '../error/failures.dart';
import '../result/result.dart';
import 'dio_error_mapper.dart';

class ApiClient {
  final Dio _dio;
  ApiClient(this._dio);

  Failure _failureFromException(AppException e) =>
      Failure(e.message, statusCode: e.statusCode);

  Future<Result<T>> get<T>(
    String path,
    T Function(dynamic json) parser,
  ) async {
    try {
      final res = await _dio.get(path);
      return Success(parser(res.data));
    } on DioException catch (e) {
      final ex = DioErrorMapper.map(e);
      return FailureResult(_failureFromException(ex));
    } catch (_) {
      return const FailureResult(Failure('Something went wrong. Please try again.'));
    }
  }

  Future<Result<T>> post<T>(
    String path, {
    required Map<String, dynamic> data,
    required T Function(dynamic json) parser,
  }) async {
    try {
      final res = await _dio.post(path, data: data);
      return Success(parser(res.data));
    } on DioException catch (e) {
      return FailureResult(_mapDioError(e));
    } catch (e) {
      return FailureResult(Failure('Unexpected error: $e'));
    }
  }

  Failure _mapDioError(DioException e) {
    final code = e.response?.statusCode;
    final message = (e.response?.data is Map && e.response?.data['detail'] != null)
        ? e.response?.data['detail'].toString()
        : e.message ?? 'Request failed';
    return Failure(message ?? '', statusCode: code);
  }
}