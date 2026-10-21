// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppointmentConfiguration _$AppointmentConfigurationFromJson(
  Map<String, dynamic> json,
) => _AppointmentConfiguration(
  id: json['id'] as String,
  venueId: json['venueId'] as String,
  enabled: json['enabled'] as bool,
  timeZone: json['timeZone'] as String,
  approvalMode: json['approvalMode'] as String,
  advanceBookingDays: (json['advanceBookingDays'] as num).toInt(),
  minimumNoticeHours: (json['minimumNoticeHours'] as num).toInt(),
  slotIntervalMinutes: (json['slotIntervalMinutes'] as num).toInt(),
  bufferMinutes: (json['bufferMinutes'] as num).toInt(),
  maximumBookingsPerSlot: (json['maximumBookingsPerSlot'] as num).toInt(),
  appointmentTypes: (json['appointmentTypes'] as List<dynamic>)
      .map((e) => AppointmentType.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AppointmentConfigurationToJson(
  _AppointmentConfiguration instance,
) => <String, dynamic>{
  'id': instance.id,
  'venueId': instance.venueId,
  'enabled': instance.enabled,
  'timeZone': instance.timeZone,
  'approvalMode': instance.approvalMode,
  'advanceBookingDays': instance.advanceBookingDays,
  'minimumNoticeHours': instance.minimumNoticeHours,
  'slotIntervalMinutes': instance.slotIntervalMinutes,
  'bufferMinutes': instance.bufferMinutes,
  'maximumBookingsPerSlot': instance.maximumBookingsPerSlot,
  'appointmentTypes': instance.appointmentTypes,
};
