import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_response.freezed.dart';
part 'member_response.g.dart';

@freezed
abstract class MemberResponse with _$MemberResponse {
  const factory MemberResponse({
    required String orgMemberId,
    required String organizationId,
    required String userId,
    required String roleId,
    required String roleName,
    required String createdAtUtc,
  }) = _MemberResponse;

  factory MemberResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberResponseFromJson(json);
}
