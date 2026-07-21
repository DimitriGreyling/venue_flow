import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_provider.dart';
import '../data/system_api.dart';

final systemApiProvider = Provider<SystemApi>((ref) {
  return SystemApi(ref.read(dioProvider));
});

final healthCheckProvider = FutureProvider<bool>((ref) async {
  return ref.read(systemApiProvider).pingHealth();
});