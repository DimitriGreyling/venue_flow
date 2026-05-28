// lib/viewmodels/auth_viewmodel.dart
import 'dart:developer';

import 'package:dio/dio.dart';
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
      final restoredSession = await _authRepository.restoreApiSession();
      if (restoredSession != null && restoredSession.user != null) {
        state = state.copyWith(
          user: restoredSession.user,
          tenant: restoredSession.tenant,
          isAuthenticated: true,
          isLoading: false,
          error: null,
        );
        return;
      }
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
      final loginResult = await _authRepository.login(email, password);
      final user = loginResult.user;
      final tenant = loginResult.tenant;

      log('Login successful, token: ${loginResult.token}');

      if (user == null) {
        await _authRepository.clearStoredSession();
        state = state.copyWith(
          error: 'Unable to load your account profile. Please sign in again.',
          isLoading: false,
          isAuthenticated: false,
        );
        return;
      }

      state = state.copyWith(
        user: user,
        tenant: tenant,
        isAuthenticated: true,
        isLoading: false,
        error: null,
      );
    } on DioException catch (error) {
      state = state.copyWith(
        error: _getUserFriendlyError(error),
        isLoading: false,
      );
    } catch (_) {
      state = state.copyWith(
        error: 'Unable to sign in right now. Please try again.',
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
      state = state.copyWith(
        error: 'Unable to sign out right now. Please try again.',
      );
    }
  }

  String _getUserFriendlyError(DioException error) {
    final message = error.error;
    if (message is String && message.isNotEmpty) {
      return message;
    }

    switch (error.response?.statusCode) {
      case 400:
      case 422:
        return 'Please check your information and try again.';
      case 401:
        return 'Invalid email or password.';
      case 403:
        return 'You do not have permission to access this account.';
      case 404:
        return 'Account not found.';
      default:
        return 'Unable to sign in right now. Please try again.';
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
