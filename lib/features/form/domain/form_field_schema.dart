import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:venue_flow_app/core/enums/form_field_type.dart';
import 'package:venue_flow_app/features/form/domain/field_validation_rules.dart';

part 'form_field_schema.freezed.dart';

part 'form_field_schema.g.dart';

///
/// Schema for forms
///
@freezed
abstract class FormFieldSchema with _$FormFieldSchema {
  const factory FormFieldSchema({
    required String title,
    required FormFieldType fieldType,
    String? value,
    String? hintText,
    required int orderNumber,
    bool? isRequired,
    FieldValidationRules? validationRules,
  }) = _FormFieldSchema;

  factory FormFieldSchema.fromJson(Map<String, dynamic> json) =>
      _$FormFieldSchemaFromJson(json);
}
