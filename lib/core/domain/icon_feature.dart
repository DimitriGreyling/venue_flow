import 'package:freezed_annotation/freezed_annotation.dart';

part 'icon_feature.freezed.dart';
part 'icon_feature.g.dart';

@freezed
abstract class IconFeature with _$IconFeature {
  const factory IconFeature({
    required String name,
    required int codePoint,
    String? fontFamily,
    required String icon,
    required String iconType,
  }) = _IconFeature;

  factory IconFeature.fromJson(Map<String, dynamic> json) =>
      _$IconFeatureFromJson(json);
}