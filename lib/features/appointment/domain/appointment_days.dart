import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_days.freezed.dart';
part 'appointment_days.g.dart';

@freezed
abstract class AppointmentDays with _$AppointmentDays {
  const factory AppointmentDays({
    required DateTime date,
    required int totalCount,
    required int pendingCount,
    required int confirmedCount,
    required int rescheduleProposedCount,
    required List<String> appointmentIds,
  }) = _AppointmentDays;

  factory AppointmentDays.fromJson(Map<String,dynamic> json)=>
      _$AppointmentDaysFromJson(json);
}