import 'package:freezed_annotation/freezed_annotation.dart';

part 'working_hours.g.dart';

part 'working_hours.freezed.dart';

@freezed
abstract class WorkingHours with _$WorkingHours {
  const factory WorkingHours({
    required String id,
    required int dayOfWeek,
    required DateTime startTime,
    required DateTime endTime,
    required bool enabled,
  }) = _WorkingHours;

  factory WorkingHours.fromJson(Map<String, dynamic> json) =>
      _$WorkingHoursFromJson(json);
}
