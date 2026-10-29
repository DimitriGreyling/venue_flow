// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_validation_rules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FieldValidationRules _$FieldValidationRulesFromJson(
  Map<String, dynamic> json,
) => _FieldValidationRules(
  minLength: (json['minLength'] as num?)?.toInt(),
  maxLength: (json['maxLength'] as num?)?.toInt(),
  pattern: json['pattern'] as String?,
);

Map<String, dynamic> _$FieldValidationRulesToJson(
  _FieldValidationRules instance,
) => <String, dynamic>{
  'minLength': instance.minLength,
  'maxLength': instance.maxLength,
  'pattern': instance.pattern,
};
