//
// import 'dart:async';
//
// import 'package:dio/dio.dart';
//
// import '../storage/token_storage.dart';
//
// class AuthInterceptor extends Interceptor {
//   AuthInterceptor({
//     required Dio dio,
//     required Dio refreshDio,
//     required TokenStorage tokenStorage,
//     required String refreshPath,
//     required Future<void> Function() onSessionExpired,
//   })  : _dio = dio,
//         _refreshDio = refreshDio,
//         _tokenStorage = tokenStorage,
//         _refreshPath = refreshPath,
//         _onSessionExpired = onSessionExpired;
//
//   final Dio _dio;
//   final Dio _refreshDio;
//   final TokenStorage _tokenStorage;
//   final String _refreshPath;
//   final Future<void> Function() _onSessionExpired;
//
//   Future<String?>? _refreshFuture;
//   Future<void>? _expiryFuture;
//
//   @override
//   void onRequest(
//       RequestOptions options,
//       RequestInterceptorHandler handler,
//       ) async {
//     try {
//       if (options.extra['skipAuth'] == true) {
//         handler.next(options);
//         return;
//       }
//
//       final token = await _tokenStorage.readToken();
//
//       if (token != null && token.isNotEmpty) {
//         options.headers['Authorization'] = 'Bearer $token';
//       }
//
//       handler.next(options);
//     } catch (error) {
//       handler.reject(
//         DioException(
//           requestOptions: options,
//           error: error,
//         ),
//       );
//     }
//   }
//
//   @override
//   void onError(
//       DioException err,
//       ErrorInterceptorHandler handler,
//       ) async {
//     final request = err.requestOptions;
//
//     final shouldRefresh =
//         err.response?.statusCode == 401 &&
//             request.extra['skipAuth'] != true &&
//             request.extra['authRetry'] != true &&
//             !_isRefreshRequest(request.path);
//
//     if (!shouldRefresh) {
//       handler.next(err);
//       return;
//     }
//
//     try {
//       final newToken = await _refreshFutureOrStart();
//
//       if (newToken == null || newToken.isEmpty) {
//         handler.next(err);
//         return;
//       }
//
//       request.extra['authRetry'] = true;
//       request.headers['Authorization'] = 'Bearer $newToken';
//
//       final response = await _dio.fetch<dynamic>(request);
//
//       handler.resolve(response);
//     } on DioException catch (refreshError) {
//       final status = refreshError.response?.statusCode;
//
//       if (status == 400 || status == 401 || status == 403) {
//         await _expireSession();
//       }
//
//       // Preserve the original request error for the caller.
//       handler.next(err);
//     } catch (_) {
//       // Transient network/server errors shouldn't automatically
//       // destroy the stored refresh session.
//       handler.next(err);
//     }
//   }
//
//   bool _isRefreshRequest(String path) =>
//       path == _refreshPath || path.endsWith(_refreshPath);
//
//   Future<String?> _refreshFutureOrStart() {
//     return _refreshFuture ??= _performRefresh().whenComplete(() {
//       _refreshFuture = null;
//     });
//   }
//
//   Future<String?> _performRefresh() async {
//     final refreshToken = await _tokenStorage.readRefreshToken();
//
//     if (refreshToken == null || refreshToken.isEmpty) {
//       await _expireSession();
//       return null;
//     }
//
//     final response = await _refreshDio.post<dynamic>(
//       _refreshPath,
//       data: {
//         'refreshToken': refreshToken,
//       },
//     );
//
//     final data = response.data;
//
//     if (data is! Map<String, dynamic>) {
//       throw DioException(
//         requestOptions: response.requestOptions,
//         message: 'Invalid token refresh response.',
//       );
//     }
//
//     final newAccessToken = data['accessToken'];
//
//     if (newAccessToken is! String || newAccessToken.isEmpty) {
//       throw DioException(
//         requestOptions: response.requestOptions,
//         message: 'The refresh response has no accessToken.',
//       );
//     }
//
//     // Preserve the existing refresh token.
//     await _tokenStorage.saveAccessToken(newAccessToken);
//
//     return newAccessToken;
//   }
//
//   Future<void> _expireSession() {
//     return _expiryFuture ??= _onSessionExpired().whenComplete(() {
//       _expiryFuture = null;
//     });
//   }
// }
