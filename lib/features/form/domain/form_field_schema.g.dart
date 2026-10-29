// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_field_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FormFieldSchema _$FormFieldSchemaFromJson(Map<String, dynamic> json) =>
    _FormFieldSchema(
      title: json['title'] as String,
      fieldType: $enumDecode(_$FormFieldTypeEnumMap, json['fieldType']),
      value: json['value'] as String?,
      hintText: json['hintText'] as String?,
      orderNumber: (json['orderNumber'] as num).toInt(),
      isRequired: json['isRequired'] as bool?,
      validationRules: json['validationRules'] == null
          ? null
          : FieldValidationRules.fromJson(
              json['validationRules'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$FormFieldSchemaToJson(_FormFieldSchema instance) =>
    <String, dynamic>{
      'title': instance.title,
      'fieldType': _$FormFieldTypeEnumMap[instance.fieldType]!,
      'value': instance.value,
      'hintText': instance.hintText,
      'orderNumber': instance.orderNumber,
      'isRequired': instance.isRequired,
      'validationRules': instance.validationRules,
    };

const _$FormFieldTypeEnumMap = {
  FormFieldType.Text: 'Text',
  FormFieldType.TextArea: 'TextArea',
  FormFieldType.DatePicker: 'DatePicker',
  FormFieldType.IntField: 'IntField',
};
