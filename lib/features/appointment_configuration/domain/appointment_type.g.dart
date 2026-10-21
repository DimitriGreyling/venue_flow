// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppointmentType _$AppointmentTypeFromJson(Map<String, dynamic> json) =>
    _AppointmentType(
      id: json['id'] as String,
      typeCode: json['typeCode'] as String,
      displayName: json['displayName'] as String,
      enabled: json['enabled'] as bool,
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      sortOrder: (json['sortOrder'] as num).toInt(),
    );

Map<String, dynamic> _$AppointmentTypeToJson(_AppointmentType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typeCode': instance.typeCode,
      'displayName': instance.displayName,
      'enabled': instance.enabled,
      'durationMinutes': instance.durationMinutes,
      'sortOrder': instance.sortOrder,
    };
