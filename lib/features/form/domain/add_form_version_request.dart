
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:venue_flow_app/features/form/domain/form_version.dart';

part 'add_form_version_request.freezed.dart';
part 'add_form_version_request.g.dart';

@freezed
abstract class AddFormVersionRequest with _$AddFormVersionRequest {
  const factory AddFormVersionRequest({
    required String name,
    required String description,
    required String formType,
    required FormVersion sourceVersion,
  }) = _AddFormVersionRequest;

  factory AddFormVersionRequest.fromJson(Map<String, dynamic> json) =>
      _$AddFormVersionRequestFromJson(json);
}
