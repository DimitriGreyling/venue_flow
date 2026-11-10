import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:venue_flow_app/features/form/domain/form_schema.dart';
import 'form_field_schema.dart';

part 'form_version.freezed.dart';

part 'form_version.g.dart';

@freezed
abstract class FormVersion with _$FormVersion {
  const factory FormVersion({
    required String id,
    required String formDefinitionId,
    int? versionNumber,
    String? status,
    String? schemaJson,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? submittedAt,
    DateTime? reviewedAt,
  }) = _FormVersion;

  factory FormVersion.fromJson(Map<String, dynamic> json) =>
      _$FormVersionFromJson(json);
}
