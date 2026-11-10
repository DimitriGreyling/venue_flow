// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FormVersion _$FormVersionFromJson(Map<String, dynamic> json) => _FormVersion(
  id: json['id'] as String,
  formDefinitionId: json['formDefinitionId'] as String,
  versionNumber: (json['versionNumber'] as num?)?.toInt(),
  status: json['status'] as String?,
  schemaJson: json['schemaJson'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  submittedAt: json['submittedAt'] == null
      ? null
      : DateTime.parse(json['submittedAt'] as String),
  reviewedAt: json['reviewedAt'] == null
      ? null
      : DateTime.parse(json['reviewedAt'] as String),
);

Map<String, dynamic> _$FormVersionToJson(_FormVersion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'formDefinitionId': instance.formDefinitionId,
      'versionNumber': instance.versionNumber,
      'status': instance.status,
      'schemaJson': instance.schemaJson,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'submittedAt': instance.submittedAt?.toIso8601String(),
      'reviewedAt': instance.reviewedAt?.toIso8601String(),
    };
