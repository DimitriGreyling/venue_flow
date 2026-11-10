// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_draft_version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateDraftVersion _$UpdateDraftVersionFromJson(Map<String, dynamic> json) =>
    _UpdateDraftVersion(
      formId: json['formId'] as String,
      versionId: json['versionId'] as String,
      request: json['request'] == null
          ? null
          : UpdateFormVersionRequest.fromJson(
              json['request'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$UpdateDraftVersionToJson(_UpdateDraftVersion instance) =>
    <String, dynamic>{
      'formId': instance.formId,
      'versionId': instance.versionId,
      'request': instance.request,
    };
