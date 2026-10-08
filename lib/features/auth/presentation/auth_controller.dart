import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/storage/token_storage.dart';
import '../data/auth_repository.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final token = await ref.read(authRepositoryProvider).login(
        email: email,
        password: password,
      );
      await ref.read(tokenStorageProvider).saveToken(token);
    });
  }

  Future<void> logout() async {
    await ref.read(tokenStorageProvider).clearToken();
  }
}