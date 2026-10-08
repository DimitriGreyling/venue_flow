import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/storage/token_storage.dart';
import '../data/auth_repository.dart';
import '../domain/login_request.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(authRepositoryProvider).login(
        LoginRequest(email: email, password: password),
      );
      await ref.read(tokenStorageProvider).saveToken(response.token);
    });
  }

  Future<void> logout() async {
    await ref.read(tokenStorageProvider).clearToken();
  }
}