// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemberResponse _$MemberResponseFromJson(Map<String, dynamic> json) =>
    _MemberResponse(
      orgMemberId: json['orgMemberId'] as String,
      organizationId: json['organizationId'] as String,
      userId: json['userId'] as String,
      roleId: json['roleId'] as String,
      roleName: json['roleName'] as String,
      createdAtUtc: json['createdAtUtc'] as String,
    );

Map<String, dynamic> _$MemberResponseToJson(_MemberResponse instance) =>
    <String, dynamic>{
      'orgMemberId': instance.orgMemberId,
      'organizationId': instance.organizationId,
      'userId': instance.userId,
      'roleId': instance.roleId,
      'roleName': instance.roleName,
      'createdAtUtc': instance.createdAtUtc,
    };
