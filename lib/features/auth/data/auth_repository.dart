import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:venue_flow_app/core/domain/response_object.dart';
import '../../../core/network/dio_client.dart';
import '../domain/login_request.dart';
import '../domain/login_response.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository(this._dio);

  final Dio _dio;

  Future<LoginResponse> login(LoginRequest request) async {
    final res = await _dio.post('/auth/login', data: request.toJson());
    return LoginResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<ResponseObject<String>> sendResetPasswordEmail({
    required String email,
  }) async {
    final res = await _dio.post(
      '/auth/reset-password-email',
      data: {'email': email},
    );

    return ResponseObject<String>.fromJson(res.data, (json) => json as String);
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(dioProvider));
}
