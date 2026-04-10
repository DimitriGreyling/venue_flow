// lib/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/models/auth_state_model.dart';
import 'package:venue_flow_app/models/tenant_model.dart';
import 'package:venue_flow_app/models/user_model.dart';
import '../repositories/auth_repository.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'supbase_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final supabaseClient = ref.watch(supabaseProvider);
  return AuthRepository(client: supabaseClient);
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