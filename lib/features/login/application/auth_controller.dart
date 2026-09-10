import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/features/login/data/auth_repository.dart';
import 'package:venue_flow_app/features/login/domain/auth_session.dart';

final authControllerProvider =
    AsyncNotifierProvider<AuthController, AuthSession?>(AuthController.new);

class AuthController extends AsyncNotifier<AuthSession?> {
  @override
  Future<AuthSession?> build() async {
    final repository = ref.read(authRepositoryProvider);
    return repository.fetchSessionFromServer();
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading<AuthSession?>();

    state = await AsyncValue.guard<AuthSession?>(() async {
      final repository = ref.read(authRepositoryProvider);
      return repository.login(
        email: email,
        password: password,
      );
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading<AuthSession?>();

    state = await AsyncValue.guard<AuthSession?>(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.logout();
      return null;
    });
  }
}
