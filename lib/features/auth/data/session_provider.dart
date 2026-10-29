
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/token_storage.dart';

part 'session_provider.g.dart';

@riverpod
Future<bool> isAuthenticated(Ref ref) async {
  final storage = ref.read(tokenStorageProvider);

  final accessToken = await storage.readToken();
  final refreshToken = await storage.readRefreshToken();

  return (accessToken != null && accessToken.isNotEmpty) ||
      (refreshToken != null && refreshToken.isNotEmpty);
}
