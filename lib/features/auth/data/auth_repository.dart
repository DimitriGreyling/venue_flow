import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/network/dio_client.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository(this._dio);
  final Dio _dio;

  Future<String> login({
    required String email,
    required String password,
  }) async {
    final res = await _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });

    final token = res.data['token'] as String?;
    if (token == null || token.isEmpty) {
      throw Exception('Token missing in login response');
    }
    return token;
  }
}

@riverpod
AuthRepository authRepository(Ref ref) => AuthRepository(ref.watch(dioProvider));