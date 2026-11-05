import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:venue_flow_app/features/form/domain/form_schema.dart';
import 'form_field_schema.dart';

part 'create_form_response.freezed.dart';

part 'create_form_response.g.dart';

@freezed
abstract class CreateFormResponse with _$CreateFormResponse {
  const factory CreateFormResponse({
    String? id,
    String? name,
    String? description,
    String? formType,
  }) = _CreateFormResponse;

  factory CreateFormResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateFormResponseFromJson(json);
}
