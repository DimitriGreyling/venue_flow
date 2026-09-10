import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/app/global_popup.dart';
import 'package:venue_flow_app/core/network/api_client.dart';
import 'package:venue_flow_app/core/network/dio_provider.dart';
import 'package:venue_flow_app/core/storage/secure_storage.dart';
import 'package:venue_flow_app/features/login/data/models/login_request.dart';
import 'package:venue_flow_app/features/login/data/models/login_response.dart';
import 'package:venue_flow_app/features/login/domain/auth_session.dart';
import 'package:venue_flow_app/core/error/failure.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.read(dioProvider);
  return AuthRepository(
    dio: dio,
    storage: AppSecureStorage.instance,
  );
});

class AuthRepository {
  const AuthRepository({
    required this.dio,
    required this.storage,
  });

  static const String _sessionKey = 'venue_flow_session';

  final Dio dio;
  final AppSecureStorage storage;

  Future<AuthSession?> currentSession() async {
    final raw = await storage.read(_sessionKey);
    if (raw == null || raw.trim().isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        await storage.delete(_sessionKey);
        return null;
      }

      final session = AuthSession.fromJson(decoded);
      if (session.isExpired) {
        await storage.delete(_sessionKey);
        return null;
      }

      return session;
    } on Failure {
      rethrow;
    } on FormatException {
      await storage.delete(_sessionKey);
      return null;
    }
  }

  Future<AuthSession?> restoreSession() async {
    final session = await currentSession();
    if (session == null) {
      return null;
    }

    if (session.isExpired) {
      await logout();
      return null;
    }

    return session;
  }

  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final trimmedEmail = email.trim();
    final trimmedPassword = password.trim();

    if (trimmedEmail.isEmpty || trimmedPassword.isEmpty) {
      throw const FormatException('Email and password are required.');
    }

    if (!trimmedEmail.contains('@')) {
      throw const FormatException('Please enter a valid email address.');
    }

    try {
      final response = await dio.post<Map<String, dynamic>>(
        '/auth/login',
        data: LoginRequest(
          email: trimmedEmail,
          password: trimmedPassword,
        ).toJson(),
      );

      final data = response.data;
      if (data == null) {
        throw const Failure('The server returned an empty response.');
      }

      final loginResponse = LoginResponse.fromJson(data);
      final session = loginResponse.toSession();

      await storage.write(_sessionKey, jsonEncode(session.toJson()));

      return session;
    } on DioException catch (error) {
      final apiError = switch (error.response?.statusCode) {
        401 => const Failure('Invalid email or password.'),
        403 => const Failure('Your account is not allowed to sign in.'),
        _ => ApiClient.mapDioException(error),
      };

      GlobalPopup.show(message: apiError.message, mode: PopupMode.error);
      throw apiError;
    }
  }

  Future<void> logout() {
    return storage.delete(_sessionKey);
  }
}