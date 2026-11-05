import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:venue_flow_app/core/enums/form_field_type.dart';
import '../../../core/domain/icon_feature.dart';

part 'form_field_data.freezed.dart';

part 'form_field_data.g.dart';

///
/// Schema for form field data
///
@freezed
abstract class FormFieldData with _$FormFieldData {
  const factory FormFieldData({
    IconFeature? leadingIcon,
    String? title,
    String? subtitle,
    IconFeature? trailingIcon,
    String? trailingTooltip,
    FormFieldType? fieldType,
    // @JsonKey(includeFromJson: false, includeToJson: false)
    // ValueChanged<void>? onTap,
  }) = _FormFieldData;

  factory FormFieldData.fromJson(Map<String, dynamic> json) =>
      _$FormFieldDataFromJson(json);
}
