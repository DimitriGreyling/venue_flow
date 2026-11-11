// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_form_version_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AddFormVersionRequest _$AddFormVersionRequestFromJson(
  Map<String, dynamic> json,
) => _AddFormVersionRequest(
  name: json['name'] as String,
  description: json['description'] as String,
  formType: json['formType'] as String,
  sourceVersion: FormVersion.fromJson(
    json['sourceVersion'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$AddFormVersionRequestToJson(
  _AddFormVersionRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'formType': instance.formType,
  'sourceVersion': instance.sourceVersion,
};
