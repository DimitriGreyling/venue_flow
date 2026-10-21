import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class TimeOfDayConverter
    implements JsonConverter<TimeOfDay, String> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromJson(String json) {
    final parts = json.split(':');

    if (parts.length < 2 || parts.length > 3) {
      throw FormatException('Invalid time format: $json');
    }

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);

    if (hour == null ||
        minute == null ||
        hour < 0 ||
        hour > 23 ||
        minute < 0 ||
        minute > 59) {
      throw FormatException('Invalid time value: $json');
    }

    // Validate optional seconds, e.g. "08:00:00".
    if (parts.length == 3) {
      final second = int.tryParse(parts[2]);

      if (second == null || second < 0 || second > 59) {
        throw FormatException('Invalid time value: $json');
      }
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  String toJson(TimeOfDay object) {
    final hour = object.hour.toString().padLeft(2, '0');
    final minute = object.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }
}