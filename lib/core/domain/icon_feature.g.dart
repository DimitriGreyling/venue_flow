// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_feature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IconFeature _$IconFeatureFromJson(Map<String, dynamic> json) => _IconFeature(
  name: json['name'] as String,
  codePoint: (json['codePoint'] as num).toInt(),
  fontFamily: json['fontFamily'] as String?,
  icon: json['icon'] as String,
  iconType: json['iconType'] as String,
);

Map<String, dynamic> _$IconFeatureToJson(_IconFeature instance) =>
    <String, dynamic>{
      'name': instance.name,
      'codePoint': instance.codePoint,
      'fontFamily': instance.fontFamily,
      'icon': instance.icon,
      'iconType': instance.iconType,
    };
