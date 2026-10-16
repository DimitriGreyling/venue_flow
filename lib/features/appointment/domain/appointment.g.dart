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
  AppointmentType.venueViewing: 'VenueViewing',
  AppointmentType.consultation: 'Consultation',
  AppointmentType.planningMeeting: 'PlanningMeeting',
  AppointmentType.unknown: 'Unknown',
};

const _$AppointmentStatusEnumMap = {
  AppointmentStatus.pending: 'Pending',
  AppointmentStatus.confirmed: 'Confirmed',
  AppointmentStatus.rescheduleProposed: 'RescheduleProposed',
  AppointmentStatus.declined: 'Declined',
  AppointmentStatus.cancelled: 'Cancelled',
  AppointmentStatus.completed: 'Completed',
  AppointmentStatus.noShow: 'NoShow',
};
