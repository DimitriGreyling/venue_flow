// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_form_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateFormResponse _$CreateFormResponseFromJson(Map<String, dynamic> json) =>
    _CreateFormResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      formType: json['formType'] as String?,
    );

Map<String, dynamic> _$CreateFormResponseToJson(_CreateFormResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'formType': instance.formType,
    };
