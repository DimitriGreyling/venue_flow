import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/enums/form_type.dart';

part 'form_details_model.freezed.dart';

part 'form_details_model.g.dart';

@freezed
abstract class FormDetailsModel with _$FormDetailsModel {
  const factory FormDetailsModel({
    String? name,
    String? description,
    FormType? type,
  }) = _FormDetailsModel;

  factory FormDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$FormDetailsModelFromJson(json);
}
