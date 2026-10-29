import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_form_version_request.freezed.dart';
part 'update_form_version_request.g.dart';


@freezed
abstract class UpdateFormVersionRequest with _$UpdateFormVersionRequest {
  const factory UpdateFormVersionRequest({
    required String schemaJson
  }) = _UpdateFormVersionRequest;

  factory UpdateFormVersionRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateFormVersionRequestFromJson(json);
}