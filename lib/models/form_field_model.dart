import 'package:venue_flow_app/models/validation_rule_model.dart';
import 'package:venue_flow_app/models/visibility_rule_model.dart';

class FormFieldModel {
  final String id;
  final String type;
  final String label;
  final String? placeholder;

  final bool required;
  final dynamic defaultValue;

  final List<String>? options; // dropdown, radio, etc.

  final List<ValidationRule>? validations;
  final VisibilityRule? visibility;

  FormFieldModel({
    required this.id,
    required this.type,
    required this.label,
    this.placeholder,
    this.required = false,
    this.defaultValue,
    this.options,
    this.validations,
    this.visibility,
  });

  factory FormFieldModel.fromJson(Map<String, dynamic> json) {
    return FormFieldModel(
      id: json['id'],
      type: json['type'],
      label: json['label'] ?? '',
      placeholder: json['placeholder'],
      required: json['required'] ?? false,
      defaultValue: json['defaultValue'],
      options: (json['options'] as List?)?.map((e) => e.toString()).toList(),
      validations: (json['validations'] as List?)
          ?.map((e) => ValidationRule.fromJson(e))
          .toList(),
      visibility: json['visibility'] != null
          ? VisibilityRule.fromJson(json['visibility'])
          : null,
    );
  }
}