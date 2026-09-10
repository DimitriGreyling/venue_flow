import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:venue_flow_app/features/login/domain/auth_session.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const LoginResponse._();

  const factory LoginResponse({
    required String accessToken,
    String? refreshToken,
    required DateTime expiresAt,
    required LoginUser user,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  AuthSession toSession() {
    return AuthSession(
      userId: user.id,
      email: user.email,
      token: accessToken,
      refreshToken: refreshToken,
      expiresAt: expiresAt,
    );
  }
}

@freezed
class LoginUser with _$LoginUser {
  const factory LoginUser({
    required String id,
    required String email,
    String? firstName,
    String? lastName,
  }) = _LoginUser;

  factory LoginUser.fromJson(Map<String, dynamic> json) =>
      _$LoginUserFromJson(json);
}
