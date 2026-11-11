// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FormDetailsModel _$FormDetailsModelFromJson(Map<String, dynamic> json) =>
    _FormDetailsModel(
      name: json['name'] as String?,
      description: json['description'] as String?,
      type: $enumDecodeNullable(_$FormTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$FormDetailsModelToJson(_FormDetailsModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'type': _$FormTypeEnumMap[instance.type],
    };

const _$FormTypeEnumMap = {
  FormType.General: 'General',
  FormType.Food: 'Food',
  FormType.PersonInformation: 'PersonInformation',
};
