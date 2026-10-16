// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_month.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppointmentMonth _$AppointmentMonthFromJson(Map<String, dynamic> json) =>
    _AppointmentMonth(
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      days: (json['days'] as List<dynamic>)
          .map((e) => AppointmentDays.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppointmentMonthToJson(_AppointmentMonth instance) =>
    <String, dynamic>{
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'days': instance.days,
    };
