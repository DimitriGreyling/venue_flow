import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:venue_flow_app/core/enums/form_field_type.dart';

part 'field_validation_rules.freezed.dart';

part 'field_validation_rules.g.dart';

///
/// Schema for forms
///
@freezed
abstract class FieldValidationRules with _$FieldValidationRules {
  const factory FieldValidationRules({
    int? minLength,
    int? maxLength,
    String? pattern,
  }) = _FieldValidationRules;

  factory FieldValidationRules.fromJson(Map<String, dynamic> json) =>
      _$FieldValidationRulesFromJson(json);
}
