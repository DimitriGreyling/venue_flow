// lib/repositories/auth_repository.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:venue_flow_app/constants/api_contract.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/shared/helpers/api_client.dart';
import 'dart:developer';
import '../models/user_model.dart';
import '../models/tenant_model.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final FlutterSecureStorage _secureStorage;

  AuthRepository({required ApiClient apiClient})
      : _apiClient = apiClient,
        _secureStorage = const FlutterSecureStorage() {
    _apiClient.configureAuthHandlers(
      onRefreshToken: refreshAccessToken,
      onUnauthorized: clearStoredSession,
    );
  }

  Future<ApiLoginResult> login(String email, String password) async {
    final response = await _apiClient.dio.post(
      ApiEndpoints.authLogin,
      data: {"email": email, "password": password},
      options: Options(extra: {'requiresAuth': false, 'skipAuthRefresh': true}),
    );

    final responseData = response.data;
    final token = _extractToken(responseData);

    final refreshToken = _extractRefreshToken(responseData);

    if (token.isEmpty) {
      throw Exception('Login succeeded but token was not returned.');
    }

    await _saveToken(token);
    await _saveRefreshToken(refreshToken);
    _apiClient.setAuthToken(token);

    final hydratedProfile = await fetchCurrentProfileFromApi();
    if (hydratedProfile?.user != null) {
      await _saveAuthProfile(hydratedProfile!);
    }

    return ApiLoginResult(
      token: token,
      user: hydratedProfile?.user ?? _extractUser(responseData),
      tenant: hydratedProfile?.tenant ?? _extractTenant(responseData),
    );
  }

  Future<ApiLoginResult?> restoreApiSession() async {
    final token = await _loadToken();
    if (token == null || token.isEmpty) {
      return null;
    }

    _apiClient.setAuthToken(token);
    final profile = await fetchCurrentProfileFromApi();

    if (profile?.user == null) {
      final cachedProfile = await _loadCachedAuthProfile();
      if (cachedProfile?.user != null) {
        return ApiLoginResult(
          token: token,
          user: cachedProfile?.user,
          tenant: cachedProfile?.tenant,
        );
      }

      await clearStoredSession();
      return null;
    }

    await _saveAuthProfile(profile!);

    return ApiLoginResult(
      token: token,
      user: profile?.user,
      tenant: profile?.tenant,
    );
  }

  Future<ApiAuthProfile?> fetchCurrentProfileFromApi() async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.authMe);
      final responseData = response.data;

      return ApiAuthProfile(
        user: _extractUser(responseData),
        tenant: _extractTenant(responseData),
      );
    } on DioException catch (error) {
      log(
        'Fetch current profile error: ${error.response?.statusCode} ${error.error}',
      );
      return null;
    } catch (error) {
      log('Fetch current profile error: $error');
      return null;
    }
  }

  Future<ApiAuthProfile?> getStoredAuthProfile() async {
    return _loadCachedAuthProfile();
  }

  Future<String?> refreshAccessToken() async {
    final refreshToken = await _loadRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      return null;
    }

    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.authRefresh,
        data: {ApiPayloadKeys.refreshToken: refreshToken},
        options: Options(
          extra: {'requiresAuth': false, 'skipAuthRefresh': true},
        ),
      );

      final responseData = response.data;
      final newAccessToken = _extractToken(responseData);
      final newRefreshToken = _extractRefreshToken(responseData);

      if (newAccessToken.isEmpty) {
        return null;
      }

      await _saveToken(newAccessToken);
      await _saveRefreshToken(
        newRefreshToken.isNotEmpty ? newRefreshToken : refreshToken,
      );
      _apiClient.setAuthToken(newAccessToken);

      return newAccessToken;
    } on DioException catch (error) {
      log('Refresh token error: ${error.response?.statusCode} ${error.error}');
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 403) {
        await clearStoredSession();
      }
      return null;
    } catch (error) {
      log('Refresh token error: $error');
      return null;
    }
  }

  Future<void> clearStoredSession() async {
    _apiClient.clearAuthToken();
    await _clearToken();
    await _clearRefreshToken();
    await _clearAuthProfile();
  }

  Future<void> _saveToken(String token) async {
    await _secureStorage.write(key: AuthStorageKeys.accessToken, value: token);
  }

  Future<String?> _loadToken() async {
    return _secureStorage.read(key: AuthStorageKeys.accessToken);
  }

  Future<void> _clearToken() async {
    await _secureStorage.delete(key: AuthStorageKeys.accessToken);
  }

  Future<void> _saveRefreshToken(String refreshToken) async {
    if (refreshToken.isEmpty) {
      return;
    }

    await _secureStorage.write(
      key: AuthStorageKeys.refreshToken,
      value: refreshToken,
    );
  }

  Future<String?> _loadRefreshToken() async {
    return _secureStorage.read(key: AuthStorageKeys.refreshToken);
  }

  Future<void> _clearRefreshToken() async {
    await _secureStorage.delete(key: AuthStorageKeys.refreshToken);
  }

  Future<void> _saveAuthProfile(ApiAuthProfile profile) async {
    final encoded = jsonEncode({
      'user': profile.user?.toJson(),
      'tenant': profile.tenant?.toJson(),
    });

    await _secureStorage.write(
      key: AuthStorageKeys.authProfile,
      value: encoded,
    );
  }

  Future<ApiAuthProfile?> _loadCachedAuthProfile() async {
    final encoded = await _secureStorage.read(key: AuthStorageKeys.authProfile);
    if (encoded == null || encoded.isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(encoded);
      if (decoded is! Map<String, dynamic>) {
        return null;
      }

      final userJson = decoded['user'];
      final tenantJson = decoded['tenant'];

      return ApiAuthProfile(
        user: userJson is Map<String, dynamic>
            ? UserModel.fromJson(userJson)
            : null,
        tenant: tenantJson is Map<String, dynamic>
            ? TenantModel.fromJson(tenantJson)
            : null,
      );
    } catch (error) {
      log('Load cached auth profile error: $error');
      return null;
    }
  }

  Future<void> _clearAuthProfile() async {
    await _secureStorage.delete(key: AuthStorageKeys.authProfile);
  }

  String _extractToken(dynamic body) {
    if (body is! Map<String, dynamic>) {
      return '';
    }

    if (body['token'] is String) {
      return body['token'] as String;
    }

    final data = body['data'];
    if (data is Map<String, dynamic> && data['token'] is String) {
      return data['token'] as String;
    }

    return '';
  }

  String _extractRefreshToken(dynamic body) {
    if (body is! Map<String, dynamic>) {
      return '';
    }

    if (body['refreshToken'] is String) {
      return body['refreshToken'] as String;
    }

    if (body['refresh_token'] is String) {
      return body['refresh_token'] as String;
    }

    final data = body['data'];
    if (data is Map<String, dynamic>) {
      if (data['refreshToken'] is String) {
        return data['refreshToken'] as String;
      }
      if (data['refresh_token'] is String) {
        return data['refresh_token'] as String;
      }
    }

    return '';
  }

  UserModel? _extractUser(dynamic body) {
    if (body is! Map<String, dynamic>) {
      return null;
    }

    final directUser = body['user'];
    if (directUser is Map<String, dynamic>) {
      return UserModel.fromJson(directUser);
    }

    final data = body['data'];
    if (data is Map<String, dynamic>) {
      final nestedUser = data['user'];
      if (nestedUser is Map<String, dynamic>) {
        return UserModel.fromJson(nestedUser);
      }
    }

    return null;
  }

  TenantModel? _extractTenant(dynamic body) {
    if (body is! Map<String, dynamic>) {
      return null;
    }

    final directTenant = body['tenant'];
    if (directTenant is Map<String, dynamic>) {
      return TenantModel.fromJson(directTenant);
    }

    final data = body['data'];
    if (data is Map<String, dynamic>) {
      final nestedTenant = data['tenant'];
      if (nestedTenant is Map<String, dynamic>) {
        return TenantModel.fromJson(nestedTenant);
      }
    }

    return null;
  }

  Future<UserModel?> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required UserRole role,
    required String tenantSlug,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.authSignup,
        data: {
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
          'role': role.name,
          'tenantSlug': tenantSlug,
        },
        options: Options(
          extra: {'requiresAuth': false, 'skipAuthRefresh': true},
        ),
      );

      return _extractUser(response.data);
    } on DioException catch (error) {
      log('Sign up error: ${error.response?.statusCode} ${error.error}');
      rethrow;
    } catch (error) {
      log('Sign up error: $error');
      rethrow;
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final profile = await fetchCurrentProfileFromApi();
      return profile?.user;
    } catch (error) {
      log('Get current user error: $error');
      return null;
    }
  }

  Future<TenantModel?> getTenantBySlug(String slug) async {
    try {
      final response = await _apiClient.dio.get(
        ApiEndpoints.tenantBySlug(slug),
      );
      return _extractTenant(response.data);
    } on DioException catch (error) {
      log(
        'Get tenant by slug error: ${error.response?.statusCode} ${error.error}',
      );
      return null;
    } catch (error) {
      log('Get tenant by slug error: $error');
      return null;
    }
  }

  Future<TenantModel?> getTenantById(String tenantId) async {
    if (tenantId.isEmpty) {
      return null;
    }

    try {
      final response = await _apiClient.dio.get(
        ApiEndpoints.tenantById(tenantId),
      );
      return _extractTenant(response.data);
    } on DioException catch (error) {
      log(
        'Get tenant by id error: ${error.response?.statusCode} ${error.error}',
      );
      return null;
    } catch (error) {
      log('Get tenant by id error: $error');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndpoints.authLogout,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        log('Sign out successful');
      }
    } on DioException {
      // Logout should still complete locally even if API call fails.
    } catch (error) {
      log('Sign out error: $error');
      rethrow;
    } finally {
      await clearStoredSession();
    }
  }
}

class ApiLoginResult {
  final String token;
  final UserModel? user;
  final TenantModel? tenant;

  const ApiLoginResult({required this.token, this.user, this.tenant});
}

class ApiAuthProfile {
  final UserModel? user;
  final TenantModel? tenant;

  const ApiAuthProfile({this.user, this.tenant});
}
