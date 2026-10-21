import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:venue_flow_app/features/appointment_configuration/domain/appointment_type.dart';
import 'package:venue_flow_app/features/appointment_configuration/domain/working_hours.dart';

part 'appointment_configuration.g.dart';

part 'appointment_configuration.freezed.dart';

@freezed
abstract class AppointmentConfiguration with _$AppointmentConfiguration {
  const factory AppointmentConfiguration({
    required String id,
    required String venueId,
    required bool enabled,
    required String timeZone,
    required String approvalMode,
    required int advanceBookingDays,
    required int minimumNoticeHours,
    required int slotIntervalMinutes,
    required int bufferMinutes,
    required int maximumBookingsPerSlot,
    required List<AppointmentType> appointmentTypes,
    required List<WorkingHours> workingHours
  }) = _AppointmentConfiguration;

  factory AppointmentConfiguration.fromJson(Map<String, dynamic> json) =>
      _$AppointmentConfigurationFromJson(json);
}
