import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
enum AppointmentType {
  @JsonValue('VenueViewing')
  venueViewing,

  @JsonValue('Consultation')
  consultation,

  @JsonValue('PlanningMeeting')
  planningMeeting,

  @JsonValue('Unknown')
  unknown,
}