
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/token_storage.dart';
import '../domain/login_request.dart';
import 'auth_repository.dart';

part 'auth_session.g.dart';

bool _isJwtValid(String token) {
  try {
    final parts = token.split('.');

    if (parts.length != 3) return false;

    final payloadBase64 = base64Url.normalize(parts[1]);
    final payloadJson = utf8.decode(
      base64Url.decode(payloadBase64),
    );

    final payload = jsonDecode(payloadJson) as Map<String, dynamic>;
    final exp = payload['exp'];

    if (exp is! num) return false;

    final expiry = DateTime.fromMillisecondsSinceEpoch(
      exp.toInt() * 1000,
    );

    return expiry.isAfter(DateTime.now());
  } catch (_) {
    return false;
  }
}

@Riverpod(keepAlive: true)
class AuthSession extends _$AuthSession {
  @override
  Future<bool> build() async {
    final storage = ref.read(tokenStorageProvider);

    final accessToken = await storage.readToken();
    final refreshToken = await storage.readRefreshToken();

    // No credentials means no authenticated session.
    if ((accessToken == null || accessToken.isEmpty) &&
        (refreshToken == null || refreshToken.isEmpty)) {
      return false;
    }

    // A valid access token means the session can continue.
    if (accessToken != null &&
        accessToken.isNotEmpty &&
        _isJwtValid(accessToken)) {
      return true;
    }

    // An expired access token can still be refreshed.
    // The Dio interceptor will perform the refresh on the next API request.
    if (refreshToken != null && refreshToken.isNotEmpty) {
      return true;
    }

    // There is no usable access token or refresh token.
    await storage.clearTokens();
    return false;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final response = await ref
          .read(authRepositoryProvider)
          .login(
        LoginRequest(
          email: email,
          password: password,
        ),
      );

      final storage = ref.read(tokenStorageProvider);

      // Assumes your login response contains both properties.
      await storage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      return true;
    });
  }

  Future<void> logout() async {
    await ref.read(tokenStorageProvider).clearTokens();
    state = const AsyncData(false);
  }
}
