import 'package:freezed_annotation/freezed_annotation.dart';
import 'form_page_schema.dart';

part 'form_schema.freezed.dart';
part 'form_schema.g.dart';

@freezed
abstract class FormSchema with _$FormSchema {
  const factory FormSchema({
    @Default(1) int version,
    @Default([]) List<FormPageSchema> pages,
  }) = _FormSchema;

  factory FormSchema.fromJson(Map<String, dynamic> json) =>
      _$FormSchemaFromJson(json);
}