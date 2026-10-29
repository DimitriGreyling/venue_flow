
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/data/auth_session.dart';
import '../config/env.dart';
import '../error/app_exception.dart';
import '../error/error_service.dart';
import '../storage/token_storage.dart';

part 'dio_client.g.dart';

const String _retryKey = 'auth_retry_attempted';

const String _loginPath = '/auth/login';
const String _refreshPath = '/auth/refresh';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final baseOptions = BaseOptions(
    baseUrl: Env.apiBaseUrl,
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
  );

  final dio = Dio(baseOptions);

  // Deliberately has no auth interceptor.
  // Refresh requests must not recursively trigger refresh handling.
  final refreshDio = Dio(baseOptions);

  // All requests that need a refresh share this Future.
  Future<String?>? refreshFuture;

  Future<String?> refreshAccessToken() {
    return refreshFuture ??= _performRefresh(
      refreshDio: refreshDio,
      ref: ref,
    ).whenComplete(() {
      refreshFuture = null;
    });
  }

  Future<void> expireSession(AppException exception) async {
    await ref.read(authSessionProvider.notifier).logout();
    ref.read(errorServiceProvider).show(exception);
  }

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await ref.read(tokenStorageProvider).readToken();

        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        } else {
          options.headers.remove('Authorization');
        }

        handler.next(options);
      },
      onError: (error, handler) async {
        final request = error.requestOptions;
        final path = request.path.toLowerCase();

        final isLogin = path.contains(_loginPath);
        final isRefresh = path.contains(_refreshPath);
        final alreadyRetried = request.extra[_retryKey] == true;

        final isUnauthorized =
            error.response?.statusCode == 401;

        // Do not refresh login/refresh requests or retry the same
        // original request more than once.
        if (!isUnauthorized ||
            isLogin ||
            isRefresh ||
            alreadyRetried) {
          final exception = AppException.from(error);

          // Keep the original behavior for unauthorized protected requests
          // that have already exhausted the refresh attempt.
          if (isUnauthorized && !isLogin && !isRefresh) {
            await expireSession(exception);
          }

          handler.next(error.copyWith(error: exception));
          return;
        }

        try {
          final newAccessToken = await refreshAccessToken();

          if (newAccessToken == null || newAccessToken.isEmpty) {
            final exception = AppException.from(error);
            await expireSession(exception);
            handler.next(error.copyWith(error: exception));
            return;
          }

          // Mark the request so it cannot enter an infinite retry loop.
          final retryOptions = request.copyWith(
            headers: {
              ...request.headers,
              'Authorization': 'Bearer $newAccessToken',
            },
            extra: {
              ...request.extra,
              _retryKey: true,
            },
          );

          final response = await dio.fetch<dynamic>(retryOptions);
          handler.resolve(response);
          return;
        } on DioException catch (refreshError) {
          final statusCode = refreshError.response?.statusCode;

          // Only rejected/invalid refresh credentials end the session.
          if (statusCode == 400 ||
              statusCode == 401 ||
              statusCode == 403) {
            final exception = AppException.from(refreshError);
            await expireSession(exception);
          }

          // Network errors and server errors do not automatically log out.
          final originalException = AppException.from(error);
          handler.next(error.copyWith(error: originalException));
          return;
        } catch (_) {
          // Unexpected refresh failures should not silently destroy
          // otherwise recoverable credentials.
          final originalException = AppException.from(error);
          handler.next(error.copyWith(error: originalException));
          return;
        }
      },
    ),
  );

  return dio;
}

Future<String?> _performRefresh({
  required Dio refreshDio,
  required Ref ref,
}) async {
  final storage = ref.read(tokenStorageProvider);
  final refreshToken = await storage.readRefreshToken();

  if (refreshToken == null || refreshToken.isEmpty) {
    throw DioException(
      requestOptions: RequestOptions(path: _refreshPath),
      response: Response<dynamic>(
        requestOptions: RequestOptions(path: _refreshPath),
        statusCode: 401,
        data: {'message': 'Refresh token is missing.'},
      ),
      type: DioExceptionType.badResponse,
    );
  }

  final response = await refreshDio.post<Map<String, dynamic>>(
    _refreshPath,
    data: {
      'refreshToken': refreshToken,
    },
  );

  final accessToken = response.data?['accessToken'];

  if (accessToken is! String || accessToken.isEmpty) {
    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      message: 'The refresh response did not contain an accessToken.',
      type: DioExceptionType.badResponse,
    );
  }

  // Your backend currently returns only a new access token.
  // Keep the existing refresh token unless your backend rotates it.
  await storage.saveToken(accessToken);

  return accessToken;
}
