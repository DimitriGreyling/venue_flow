// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_field_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FormFieldData _$FormFieldDataFromJson(Map<String, dynamic> json) =>
    _FormFieldData(
      leadingIcon: json['leadingIcon'] as String?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      trailingIcon: json['trailingIcon'] as String?,
      trailingTooltip: json['trailingTooltip'] as String?,
      fieldType: $enumDecodeNullable(_$FormFieldTypeEnumMap, json['fieldType']),
    );

Map<String, dynamic> _$FormFieldDataToJson(_FormFieldData instance) =>
    <String, dynamic>{
      'leadingIcon': instance.leadingIcon,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'trailingIcon': instance.trailingIcon,
      'trailingTooltip': instance.trailingTooltip,
      'fieldType': _$FormFieldTypeEnumMap[instance.fieldType],
    };

const _$FormFieldTypeEnumMap = {
  FormFieldType.Text: 'Text',
  FormFieldType.TextArea: 'TextArea',
  FormFieldType.DatePicker: 'DatePicker',
  FormFieldType.IntField: 'IntField',
};
