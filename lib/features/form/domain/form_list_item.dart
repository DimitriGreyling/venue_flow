import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:venue_flow_app/features/form/domain/form_schema.dart';
import 'form_field_schema.dart';

part 'form_list_item.freezed.dart';

part 'form_list_item.g.dart';

@freezed
abstract class FormListItem with _$FormListItem {
  const factory FormListItem({
    required String id,
    required String name,
    String? description,
    String? formType,
    String? currentPublishedVersionId,
    DateTime? createAt,
    DateTime? updatedAt,
  }) = _FormListItem;

  factory FormListItem.fromJson(Map<String, dynamic> json) =>
      _$FormListItemFromJson(json);
}
