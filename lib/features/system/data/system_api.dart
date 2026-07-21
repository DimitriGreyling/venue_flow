import 'package:dio/dio.dart';

class SystemApi {
  final Dio _dio;
  SystemApi(this._dio);

  Future<bool> pingHealth() async {
    final res = await _dio.get('/health');
    return res.statusCode == 200;
  }

  Future<Map<String, dynamic>> me() async {
    final res = await _dio.get('/auth/me');
    return Map<String, dynamic>.from(res.data as Map);
  }
}