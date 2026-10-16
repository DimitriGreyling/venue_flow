import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:venue_flow_app/features/appointment/domain/appointment_days.dart';

part 'appointment_month.freezed.dart';
part 'appointment_month.g.dart';

@freezed
abstract class AppointmentMonth with _$AppointmentMonth {
  const factory AppointmentMonth({
    required DateTime startDate,
    required DateTime endDate,
    required List<AppointmentDays> days,
}) = _AppointmentMonth;

  factory AppointmentMonth.fromJson(Map<String,dynamic> json)=>
      _$AppointmentMonthFromJson(json);
}