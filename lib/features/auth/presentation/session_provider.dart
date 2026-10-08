import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/storage/token_storage.dart';

part 'session_provider.g.dart';

@riverpod
Future<bool> isAuthenticated(Ref ref) async {
  final token = await ref.read(tokenStorageProvider).readToken();
  return token != null && token.isNotEmpty;
}