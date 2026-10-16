// enum AppointmentStatus {
//   pending,
//   confirmed,
//   rescheduleProposed,
//   declined,
//   cancelled,
//   completed,
//   noShow,
//   unknown,
// }

import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
enum AppointmentStatus {
  @JsonValue('Pending')
  pending,

  @JsonValue('Confirmed')
  confirmed,

  @JsonValue('RescheduleProposed')
  rescheduleProposed,

  @JsonValue('Declined')
  declined,

  @JsonValue('Cancelled')
  cancelled,

  @JsonValue('Completed')
  completed,

  @JsonValue('NoShow')
  noShow,
}