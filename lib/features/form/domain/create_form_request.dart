import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:venue_flow_app/features/form/domain/form_schema.dart';
import 'form_field_schema.dart';

part 'create_form_request.freezed.dart';

part 'create_form_request.g.dart';

@freezed
abstract class CreateFormRequest with _$CreateFormRequest {
  const factory CreateFormRequest({
    required String name,
    String? description,
    String? formType,
    FormSchema? schema,
  }) = _CreateFormRequest;

  factory CreateFormRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateFormRequestFromJson(json);
}
