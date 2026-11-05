import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:venue_flow_app/features/form/domain/form_schema.dart';
import 'form_field_schema.dart';

part 'form_list_id.freezed.dart';

part 'form_list_id.g.dart';

@freezed
abstract class FormListId with _$FormListId {
  const factory FormListId({
    required String id,
  }) = _FormListId;

  factory FormListId.fromJson(Map<String, dynamic> json) =>
      _$FormListIdFromJson(json);
}
