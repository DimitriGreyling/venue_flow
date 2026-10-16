// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Appointment _$AppointmentFromJson(Map<String, dynamic> json) => _Appointment(
  id: json['id'] as String,
  venueId: json['venueId'] as String,
  venueName: json['venueName'] as String,
  clientUserId: json['clientUserId'] as String?,
  coordinatorUserId: json['coordinatorUserId'] as String?,
  type: $enumDecode(_$AppointmentTypeEnumMap, json['type']),
  status: $enumDecode(_$AppointmentStatusEnumMap, json['status']),
  startAtUtc: DateTime.parse(json['startAtUtc'] as String),
  endAtUtc: DateTime.parse(json['endAtUtc'] as String),
  clientNotes: json['clientNotes'] as String?,
);

Map<String, dynamic> _$AppointmentToJson(_Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'venueId': instance.venueId,
      'venueName': instance.venueName,
      'clientUserId': instance.clientUserId,
      'coordinatorUserId': instance.coordinatorUserId,
      'type': _$AppointmentTypeEnumMap[instance.type]!,
      'status': _$AppointmentStatusEnumMap[instance.status]!,
      'startAtUtc': instance.startAtUtc.toIso8601String(),
      'endAtUtc': instance.endAtUtc.toIso8601String(),
      'clientNotes': instance.clientNotes,
    };

const _$AppointmentTypeEnumMap = {
  AppointmentType.venueViewing: 'venueViewing',
  AppointmentType.consultation: 'consultation',
  AppointmentType.planningMeeting: 'planningMeeting',
  AppointmentType.unknown: 'unknown',
};

const _$AppointmentStatusEnumMap = {
  AppointmentStatus.pending: 'pending',
  AppointmentStatus.confirmed: 'confirmed',
  AppointmentStatus.rescheduleProposed: 'rescheduleProposed',
  AppointmentStatus.declined: 'declined',
  AppointmentStatus.cancelled: 'cancelled',
  AppointmentStatus.completed: 'completed',
  AppointmentStatus.noShow: 'noShow',
  AppointmentStatus.unknown: 'unknown',
};
