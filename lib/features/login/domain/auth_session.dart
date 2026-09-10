import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session.freezed.dart';
part 'auth_session.g.dart';

@freezed
class AuthSession with _$AuthSession {
  const AuthSession._();

  const factory AuthSession({
    required String userId,
    required String email,
    required String token,
    String? refreshToken,
    required DateTime expiresAt,
  }) = _AuthSession;

  factory AuthSession.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionFromJson(json);

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}