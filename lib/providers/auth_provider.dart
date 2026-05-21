// lib/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/models/auth_state_model.dart';
import 'package:venue_flow_app/models/tenant_model.dart';
import 'package:venue_flow_app/models/user_model.dart';
import 'package:venue_flow_app/providers/api_client_provider.dart';
import '../repositories/auth_repository.dart';
import '../viewmodels/auth_viewmodel.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);

  return AuthRepository(apiClient: apiClient);
});

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthStateModel>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthViewModel(authRepository: authRepository);
});

// Convenience providers
final currentUserProvider = Provider<UserModel?>((ref) {
  return ref.watch(authViewModelProvider).user;
});

final currentTenantProvider = Provider<TenantModel?>((ref) {
  return ref.watch(authViewModelProvider).tenant;
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authViewModelProvider).isAuthenticated;
});