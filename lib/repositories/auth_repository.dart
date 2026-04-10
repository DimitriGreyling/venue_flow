// lib/repositories/auth_repository.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'dart:developer';
import '../models/user_model.dart';
import '../models/tenant_model.dart';

class AuthRepository {
  final SupabaseClient _client;

  AuthRepository({required SupabaseClient client}) : _client = client;

  // Sign in with email and password
  Future<UserModel?> signIn({
    required String email, 
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final userData = await _getUserProfile(response.user!.id);
        return userData;
      }
      return null;
    } catch (error) {
      log('Sign in error: $error');
      rethrow;
    }
  }

  // Sign up with role and tenant
  Future<UserModel?> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required UserRole role,
    required String tenantSlug,
  }) async {
    try {
      // Get tenant by slug
      final tenantResponse = await _client
          .from('tenants')
          .select()
          .eq('slug', tenantSlug)
          .single();
      
      final tenant = TenantModel.fromJson(tenantResponse);

      final response = await _client.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // Create user profile
        await _client.from('users').insert({
          'id': response.user!.id,
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
          'role': role.name,
          'tenant_id': tenant.id,
        });

        return await _getUserProfile(response.user!.id);
      }
      return null;
    } catch (error) {
      log('Sign up error: $error');
      rethrow;
    }
  }

  // Get current user session
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _client.auth.currentUser;
      if (user != null) {
        return await _getUserProfile(user.id);
      }
      return null;
    } catch (error) {
      log('Get current user error: $error');
      return null;
    }
  }

  // Get user profile with tenant info
  Future<UserModel?> _getUserProfile(String userId) async {
    try {
      final response = await _client
          .from('users')
          .select('*, tenant:tenants(*)')
          .eq('id', userId)
          .single();

      return UserModel.fromJson(response);
    } catch (error) {
      log('Get user profile error: $error');
      return null;
    }
  }

  // Get tenant by slug
  Future<TenantModel?> getTenantBySlug(String slug) async {
    try {
      final response = await _client
          .from('tenants')
          .select()
          .eq('slug', slug)
          .single();

      return TenantModel.fromJson(response);
    } catch (error) {
      log('Get tenant error: $error');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (error) {
      log('Sign out error: $error');
      rethrow;
    }
  }

  // Listen to auth changes
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;
}