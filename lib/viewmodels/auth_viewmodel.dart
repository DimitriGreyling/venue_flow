// lib/viewmodels/auth_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_state_model.dart';
import '../models/enums.dart';
import '../repositories/auth_repository.dart';

class AuthViewModel extends StateNotifier<AuthStateModel> {
  final AuthRepository _authRepository;

  AuthViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthStateModel()) {
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    state = state.copyWith(isLoading: true);
    
    try {
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        final tenant = await _authRepository.getTenantById(user.tenantId ?? '');
        state = state.copyWith(
          user: user,
          tenant: tenant,
          isAuthenticated: true,
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (error) {
      state = state.copyWith(
        error: error.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await _authRepository.signIn(
        email: email,
        password: password,
      );

      if (user != null) {
        final tenant = await _authRepository.getTenantById(user.tenantId ?? '');
        state = state.copyWith(
          user: user,
          tenant: tenant,
          isAuthenticated: true,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          error: 'Invalid credentials',
          isLoading: false,
        );
      }
    } catch (error) {
      state = state.copyWith(
        error: error.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required UserRole role,
    required String tenantSlug,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await _authRepository.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        role: role,
        tenantSlug: tenantSlug,
      );

      if (user != null) {
        final tenant = await _authRepository.getTenantById(tenantSlug);
        state = state.copyWith(
          user: user,
          tenant: tenant,
          isAuthenticated: true,
          isLoading: false,
        );
      }
    } catch (error) {
      state = state.copyWith(
        error: error.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _authRepository.signOut();
      state = const AuthStateModel();
    } catch (error) {
      state = state.copyWith(error: error.toString());
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}