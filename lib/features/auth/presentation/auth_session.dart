import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/token_storage.dart';
import '../data/auth_repository.dart';
import '../domain/login_request.dart';

part 'auth_session.g.dart';

bool _isJwtValid(String token) {
  try {
    final parts = token.split('.');
    if (parts.length != 3) return false;

    final payloadBase64 = base64Url.normalize(parts[1]);
    final payloadJson = utf8.decode(base64Url.decode(payloadBase64));
    final payload = jsonDecode(payloadJson) as Map<String, dynamic>;

    final exp = payload['exp'];
    if (exp is! num) return false;

    final expiry = DateTime.fromMillisecondsSinceEpoch(exp.toInt() * 1000);
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
    final token = await storage.readToken();

    if (token == null || token.isEmpty) return false;

    // If token is expired/invalid, wipe and force login.
    if (!_isJwtValid(token)) {
      await storage.clearToken();
      return false;
    }

    return true;
  }

  Future<void> login(String email, String password) async {
    // state = const AsyncLoading();
    // state = await AsyncValue.guard(() async {
    //   final response = await ref.read(authRepositoryProvider).login(
    //     LoginRequest(email: email, password: password),
    //   );
    //
    //   await ref.read(tokenStorageProvider).saveToken(response.token);
    //   return true;
    // });

    final response = await ref
        .read(authRepositoryProvider)
        .login(LoginRequest(email: email, password: password));
    await ref.read(tokenStorageProvider).saveToken(response.token);
    state = const AsyncData(true);
  }

  Future<void> logout() async {
    await ref.read(tokenStorageProvider).clearToken();
    state = const AsyncData(false);
  }
}
