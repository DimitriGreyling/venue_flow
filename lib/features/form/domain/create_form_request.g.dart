// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_form_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateFormRequest _$CreateFormRequestFromJson(Map<String, dynamic> json) =>
    _CreateFormRequest(
      name: json['name'] as String,
      description: json['description'] as String?,
      formType: json['formType'] as String?,
      schema: json['schema'] == null
          ? null
          : FormSchema.fromJson(json['schema'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateFormRequestToJson(_CreateFormRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'formType': instance.formType,
      'schema': instance.schema,
    };
