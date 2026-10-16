import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/enums/appointment_status.dart';
import '../../../core/enums/appointment_type.dart';

part 'appointment.freezed.dart';
part 'appointment.g.dart';

@freezed
abstract class Appointment with _$Appointment {
  const factory Appointment({
    required String id,
    required String venueId,
    required String venueName,
    String? clientUserId,
    String? coordinatorUserId,
    required AppointmentType type,
    required AppointmentStatus status,
    required DateTime startAtUtc,
    required DateTime endAtUtc,
    String? clientNotes,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);
}