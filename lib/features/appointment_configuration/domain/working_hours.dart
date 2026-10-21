import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:venue_flow_app/core/converters/time_of_day_converter.dart';

part 'working_hours.g.dart';

part 'working_hours.freezed.dart';

@freezed
abstract class WorkingHours with _$WorkingHours {
  const factory WorkingHours({
    required String id,
    required int dayOfWeek,
    @TimeOfDayConverter() required TimeOfDay startTime,
    @TimeOfDayConverter() required TimeOfDay endTime,
    required bool enabled,
  }) = _WorkingHours;

  factory WorkingHours.fromJson(Map<String, dynamic> json) =>
      _$WorkingHoursFromJson(json);
}
