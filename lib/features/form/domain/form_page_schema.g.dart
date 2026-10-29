// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_page_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FormPageSchema _$FormPageSchemaFromJson(Map<String, dynamic> json) =>
    _FormPageSchema(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      orderNumber: (json['orderNumber'] as num?)?.toInt() ?? 0,
      fields:
          (json['fields'] as List<dynamic>?)
              ?.map((e) => FormFieldSchema.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$FormPageSchemaToJson(_FormPageSchema instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'orderNumber': instance.orderNumber,
      'fields': instance.fields,
    };
