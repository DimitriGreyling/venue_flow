import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/storage/token_storage.dart';
import '../data/auth_repository.dart';
import '../domain/login_request.dart';

part 'auth_session.g.dart';

/// true = logged in, false = logged out
@Riverpod(keepAlive: true)
class AuthSession extends _$AuthSession {
  @override
  Future<bool> build() async {
    final token = await ref.read(tokenStorageProvider).readToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> login(String email, String password) async {
    final res = await ref
        .read(authRepositoryProvider)
        .login(LoginRequest(email: email, password: password));
    await ref.read(tokenStorageProvider).saveToken(res.token);
    state = const AsyncData(true);
  }

  Future<void> logout() async {
    await ref.read(tokenStorageProvider).clearToken();
    state = const AsyncData(false);
  }
}