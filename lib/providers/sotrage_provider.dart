// lib/providers/storage_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/shared/helpers/storage_helper.dart';

// Provider for StorageHelper (singleton behavior)
final storageHelperProvider = Provider<IStorageHelper>((ref) {
  return StorageHelper();
});

// // Alternative: If you need different implementations for testing
// final storageHelperProvider = Provider<IStorageHelper>((ref) {
//   // You can switch implementations here
//   return StorageHelper(); // Production
//   // return MockStorageHelper(); // Testing
// });