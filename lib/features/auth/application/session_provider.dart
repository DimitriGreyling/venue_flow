import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/storage/token_storage.dart';
import '../../../core/network/dio_provider.dart';

class SessionState {
  final bool isAuthenticated;
  const SessionState({required this.isAuthenticated});
}

final sessionProvider = AsyncNotifierProvider<SessionNotifier, SessionState>(
  SessionNotifier.new,
);

class SessionNotifier extends AsyncNotifier<SessionState> {
  @override
  Future<SessionState> build() async {
    final token = await ref.read(tokenStorageProvider).read();
    return SessionState(isAuthenticated: token != null && token.isNotEmpty);
  }

  Future<void> setAuthenticated(String token) async {
    await ref.read(tokenStorageProvider).save(token);
    state = const AsyncData(SessionState(isAuthenticated: true));
  }

  Future<void> clear() async {
    await ref.read(tokenStorageProvider).clear();
    state = const AsyncData(SessionState(isAuthenticated: false));
  }
}