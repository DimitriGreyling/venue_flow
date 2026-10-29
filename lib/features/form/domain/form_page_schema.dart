import 'package:freezed_annotation/freezed_annotation.dart';
import 'form_field_schema.dart';

part 'form_page_schema.freezed.dart';
part 'form_page_schema.g.dart';

@freezed
abstract class FormPageSchema with _$FormPageSchema {
  const factory FormPageSchema({
    required String id,
    required String title,
    String? description,
    @Default(0) int orderNumber,
    @Default([]) List<FormFieldSchema> fields,
  }) = _FormPageSchema;

  factory FormPageSchema.fromJson(Map<String, dynamic> json) =>
      _$FormPageSchemaFromJson(json);
}