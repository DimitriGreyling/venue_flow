import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/features/auth/application/session_provider.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/storage/token_storage.dart';
import '../data/auth_api.dart';

final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi(ref.read(dioProvider));
});

final authControllerProvider =
AsyncNotifierProvider<AuthController, void>(AuthController.new);

class AuthController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final token = await ref.read(authApiProvider).login(email, password);
      await ref.read(sessionProvider.notifier).setAuthenticated(token);
      await ref.read(tokenStorageProvider).save(token);
    });
  }

  Future<void> logout() async {
    await ref.read(tokenStorageProvider).clear();
  }
}