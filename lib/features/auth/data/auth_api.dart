import 'package:dio/dio.dart';
import '../../../core/error/app_exception.dart';
import '../../../core/network/dio_error_mapper.dart';

class AuthApi {
  final Dio dio;
  AuthApi(this.dio);

  Future<String> login(String email, String password) async {
    try {
      final res = await dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      final map = Map<String, dynamic>.from(res.data as Map);
      final token = map['accessToken']?.toString();

      if (token == null || token.isEmpty) {
        throw const AppException(
          message: 'Login response is invalid. Please contact support.',
          code: 'invalid_login_response',
        );
      }

      return token;
    } on DioException catch (e) {
      // ✅ friendly mapped exception
      throw DioErrorMapper.map(e);
    } on AppException {
      rethrow;
    } catch (_) {
      throw const AppException(
        message: 'Unexpected error during login. Please try again.',
        code: 'unexpected_login_error',
      );
    }
  }
}