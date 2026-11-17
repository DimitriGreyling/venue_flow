import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/domain/response_object.dart';
import '../../../core/storage/token_storage.dart';
import 'auth_repository.dart';
import '../domain/login_request.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref
          .read(authRepositoryProvider)
          .login(LoginRequest(email: email, password: password));
      await ref.read(tokenStorageProvider).saveToken(response.accessToken);
    });
  }

  Future<ResponseObject<String>> sendResetPasswordEmail({
    required String email,
  }) async {
    final response = await ref
        .read(authRepositoryProvider)
        .sendResetPasswordEmail(email: email);

    return response;
  }

  Future<void> logout() async {
    await ref.read(tokenStorageProvider).clearToken();
  }
}
