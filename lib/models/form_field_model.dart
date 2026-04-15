import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/models/validation_rule_model.dart';
import 'package:venue_flow_app/models/visibility_rule_model.dart';

class FormFieldModel {
  String? id;
  FieldType? type;
  String? label;
  String? placeholder;

  bool? required;
  dynamic defaultValue;

  List<String>? options; // dropdown, radio, etc.

  List<ValidationRule>? validations;
  VisibilityRule? visibility;

  FormFieldModel({
    this.id,
    this.type,
    this.label,
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
      type: json['type'] != null ? FieldType.values.byName(json['type']) : null,
      label: json['label'] ?? '',
      placeholder: json['placeholder'],
      required: json['required'] ?? false,
      defaultValue: json['defaultValue'],
      options: (json['options'] as List?)?.map((e) => e.toString()).toList(),
      // validations: (json['validations'] as List?)
      //     ?.map((e) => ValidationRule.fromJson(e))
      //     .toList(),
      visibility: json['visibility'] != null
          ? VisibilityRule.fromJson(json['visibility'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type?.name,
      'label': label,
      'placeholder': placeholder,
      'required': required,
      'defaultValue': defaultValue,
      'options': options,
      // 'validations': validations?.map((e) => e.toJson()).toList(),
      // 'visibility': visibility?.toJson(),
    };
  }

  String submissionKey({
    required int pageIndex,
    required int fieldIndex,
  }) {
    final trimmedId = id?.trim();
    if (trimmedId != null && trimmedId.isNotEmpty) {
      return trimmedId;
    }

    final normalizedLabel = (label ?? 'field')
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');

    final safeLabel = normalizedLabel.isEmpty ? 'field' : normalizedLabel;
    return 'page_${pageIndex}_field_${fieldIndex}_${type?.name ?? 'value'}_$safeLabel';
  }
}
