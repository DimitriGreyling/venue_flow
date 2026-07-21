import 'package:dio/dio.dart';

class AuthApi {
  final Dio dio;
  AuthApi(this.dio);

  Future<String> login(String email, String password) async {
    final res = await dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });

    // adjust to your backend response shape
    return res.data['token'] as String;
  }
}