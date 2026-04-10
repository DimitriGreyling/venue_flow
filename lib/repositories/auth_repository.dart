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

      //  await createTestUsers();

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

  // Add this method to create test users programmatically
  // Future<void> createTestUsers() async {
  //   final testUsers = [
  //     // Elegant Events Venue users
  //     {
  //       'email': 'coordinator@elegant-events.com',
  //       'password': 'TestPassword123!',
  //       'firstName': 'Sarah',
  //       'lastName': 'Johnson',
  //       'role': UserRole.coordinator,
  //       'tenantId': 'a0000000-0000-0000-0000-000000000001',
  //     },
  //     {
  //       'email': 'admin@elegant-events.com',
  //       'password': 'TestPassword123!',
  //       'firstName': 'Michael',
  //       'lastName': 'Chen',
  //       'role': UserRole.admin,
  //       'tenantId': 'a0000000-0000-0000-0000-000000000001',
  //     },
  //     {
  //       'email': 'client@elegant-events.com',
  //       'password': 'TestPassword123!',
  //       'firstName': 'Emma',
  //       'lastName': 'Davis',
  //       'role': UserRole.client,
  //       'tenantId': 'a0000000-0000-0000-0000-000000000001',
  //     },

  //     // Garden Paradise users
  //     {
  //       'email': 'coordinator@garden-paradise.com',
  //       'password': 'TestPassword123!',
  //       'firstName': 'James',
  //       'lastName': 'Wilson',
  //       'role': UserRole.coordinator,
  //       'tenantId': 'a0000000-0000-0000-0000-000000000002',
  //     },
  //     {
  //       'email': 'client@garden-paradise.com',
  //       'password': 'TestPassword123!',
  //       'firstName': 'Lisa',
  //       'lastName': 'Thompson',
  //       'role': UserRole.client,
  //       'tenantId': 'a0000000-0000-0000-0000-000000000002',
  //     },

  //     // Metro Conference users
  //     {
  //       'email': 'coordinator@metro-conference.com',
  //       'password': 'TestPassword123!',
  //       'firstName': 'Robert',
  //       'lastName': 'Martinez',
  //       'role': UserRole.coordinator,
  //       'tenantId': 'a0000000-0000-0000-0000-000000000003',
  //     },

  //     // Quick test user
  //     {
  //       'email': 'test@test.com',
  //       'password': 'TestPassword123!',
  //       'firstName': 'Test',
  //       'lastName': 'User',
  //       'role': UserRole.coordinator,
  //       'tenantId': 'a0000000-0000-0000-0000-000000000001',
  //     },
  //   ];

  //   print('🚀 Creating ${testUsers.length} test users...');

  //   for (final userData in testUsers) {
  //     try {
  //       // Create auth user
  //       final response = await _client.auth.signUp(
  //         email: userData['email'] as String,
  //         password: userData['password'] as String,
  //       );

  //       if (response.user != null) {
  //         // Create user profile
  //         await _client.from('users').insert({
  //           'id': response.user!.id,
  //           'email': userData['email'],
  //           'first_name': userData['firstName'],
  //           'last_name': userData['lastName'],
  //           'role': (userData['role'] as UserRole).name,
  //           'tenant_id': userData['tenantId'],
  //           'is_active': true,
  //         });

  //         print('✅ Created user: ${userData['email']}');

  //         // Sign out to prepare for next user
  //         await _client.auth.signOut();
  //       } else {
  //         print('❌ Failed to create auth user: ${userData['email']}');
  //       }
  //     } catch (error) {
  //       print('❌ Error creating ${userData['email']}: $error');
  //     }
  //   }

  //   print('🎉 Test user creation completed!');
  // }

// Method to verify all users were created
  Future<void> verifyTestUsers() async {
    try {
      final users =
          await _client.from('users').select('*, tenants(name, slug)');

      print('📊 === USER VERIFICATION ===');
      print('Total users created: ${users.length}');

      for (final user in users) {
        print(
            '  📧 ${user['email']} - ${user['role']} at ${user['tenants']['name']}');
      }

      final tenants = await _client.from('tenants').select('*');
      print('📊 Total tenants: ${tenants.length}');
    } catch (error) {
      print('❌ Verification failed: $error');
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
      final response =
          await _client.from('tenants').select().eq('slug', slug).single();

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
