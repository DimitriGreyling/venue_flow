import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:venue_flow_app/features/form/domain/form_schema.dart';
import 'package:venue_flow_app/features/form/presentation/dialogs/update_form_version_request.dart';
import 'form_field_schema.dart';

part 'update_draft_version.freezed.dart';

part 'update_draft_version.g.dart';

@freezed
abstract class UpdateDraftVersion with _$UpdateDraftVersion {
  const factory UpdateDraftVersion({
    required String formId,
    required String versionId,
    UpdateFormVersionRequest? request,
  }) = _UpdateDraftVersion;

  factory UpdateDraftVersion.fromJson(Map<String, dynamic> json) =>
      _$UpdateDraftVersionFromJson(json);
}
