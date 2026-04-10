// lib/models/auth_state_model.dart
import 'package:venue_flow_app/models/tenant_model.dart';
import 'package:venue_flow_app/models/user_model.dart';

class AuthStateModel {
  final UserModel? user;
  final TenantModel? tenant;
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;

  const AuthStateModel({
    this.user,
    this.tenant,
    this.isLoading = false,
    this.error,
    this.isAuthenticated = false,
  });

  AuthStateModel copyWith({
    UserModel? user,
    TenantModel? tenant,
    bool? isLoading,
    String? error,
    bool? isAuthenticated,
  }) {
    return AuthStateModel(
      user: user ?? this.user,
      tenant: tenant ?? this.tenant,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}