import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/auth/presentation/auth_session.dart';
import '../config/env.dart';
import '../error/app_exception.dart';
import '../error/error_service.dart';
import '../storage/token_storage.dart';

part 'dio_client.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(BaseOptions(
    baseUrl: Env.apiBaseUrl,
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final token = await ref.read(tokenStorageProvider).readToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      handler.next(options);
    },
    onError: (error, handler) async {
      final ex = AppException.from(error);

      // Expired session: clear token; router redirects to /login.
      // Skip for the login call itself (wrong password also returns 401).
      final isLogin = error.requestOptions.path.contains('/auth/login');
      if (ex.type == AppErrorType.unauthorized && !isLogin) {
        await ref.read(authSessionProvider.notifier).logout();
        ref.read(errorServiceProvider).show(ex);
      }

      // Callers always receive a DioException whose .error is an AppException.
      handler.next(error.copyWith(error: ex));
    },
  ));

  return dio;
}