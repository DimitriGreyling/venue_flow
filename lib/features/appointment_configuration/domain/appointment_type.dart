import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_type.g.dart';
part 'appointment_type.freezed.dart';

@freezed
abstract class AppointmentType with _$AppointmentType {
  const factory AppointmentType({
    required String id,
    required String typeCode,
    required String displayName,
    required bool enabled,
    required int durationMinutes,
    required int sortOrder,
  }) = _AppointmentType;

  factory AppointmentType.fromJson(Map<String, dynamic> json) =>
      _$AppointmentTypeFromJson(json);
}
