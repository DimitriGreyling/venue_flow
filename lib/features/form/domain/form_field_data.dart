import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:venue_flow_app/core/enums/form_field_type.dart';
import 'package:venue_flow_app/features/form/domain/field_validation_rules.dart';

import '../../../core/converters/icon_data_convert.dart';

part 'form_field_data.freezed.dart';

part 'form_field_data.g.dart';

///
/// Schema for form field data
///
@freezed
abstract class FormFieldData with _$FormFieldData {
  const factory FormFieldData({
    @IconDataConverter()
    IconData? leadingIcon,
    String? title,
    String? subtitle,
    @IconDataConverter()
    IconData? trailingIcon,
    String? trailingTooltip,
    FormFieldType? fieldType,
    // @JsonKey(includeFromJson: false, includeToJson: false)
    // ValueChanged<void>? onTap,
  }) = _FormFieldData;

  factory FormFieldData.fromJson(Map<String, dynamic> json) =>
      _$FormFieldDataFromJson(json);
}
