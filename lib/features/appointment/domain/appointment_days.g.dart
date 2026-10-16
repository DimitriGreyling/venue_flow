// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_days.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppointmentDays _$AppointmentDaysFromJson(Map<String, dynamic> json) =>
    _AppointmentDays(
      date: DateTime.parse(json['date'] as String),
      totalCount: (json['totalCount'] as num).toInt(),
      pendingCount: (json['pendingCount'] as num).toInt(),
      confirmedCount: (json['confirmedCount'] as num).toInt(),
      rescheduleProposedCount: (json['rescheduleProposedCount'] as num).toInt(),
      appointmentIds: (json['appointmentIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AppointmentDaysToJson(_AppointmentDays instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'totalCount': instance.totalCount,
      'pendingCount': instance.pendingCount,
      'confirmedCount': instance.confirmedCount,
      'rescheduleProposedCount': instance.rescheduleProposedCount,
      'appointmentIds': instance.appointmentIds,
    };
