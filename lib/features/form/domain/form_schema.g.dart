// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FormSchema _$FormSchemaFromJson(Map<String, dynamic> json) => _FormSchema(
  version: (json['version'] as num?)?.toInt() ?? 1,
  pages:
      (json['pages'] as List<dynamic>?)
          ?.map((e) => FormPageSchema.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$FormSchemaToJson(_FormSchema instance) =>
    <String, dynamic>{'version': instance.version, 'pages': instance.pages};
