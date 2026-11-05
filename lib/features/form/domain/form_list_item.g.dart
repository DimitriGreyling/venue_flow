// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FormListItem _$FormListItemFromJson(Map<String, dynamic> json) =>
    _FormListItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      formType: json['formType'] as String?,
      currentPublishedVersionId: json['currentPublishedVersionId'] as String?,
      createAt: json['createAt'] == null
          ? null
          : DateTime.parse(json['createAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$FormListItemToJson(_FormListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'formType': instance.formType,
      'currentPublishedVersionId': instance.currentPublishedVersionId,
      'createAt': instance.createAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
