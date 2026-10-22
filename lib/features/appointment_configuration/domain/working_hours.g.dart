// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'working_hours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkingHours _$WorkingHoursFromJson(Map<String, dynamic> json) =>
    _WorkingHours(
      id: json['id'] as String,
      dayOfWeek: (json['dayOfWeek'] as num).toInt(),
      startTime: const TimeOfDayConverter().fromJson(
        json['startTime'] as String,
      ),
      endTime: const TimeOfDayConverter().fromJson(json['endTime'] as String),
      enabled: json['enabled'] as bool,
    );

Map<String, dynamic> _$WorkingHoursToJson(_WorkingHours instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dayOfWeek': instance.dayOfWeek,
      'startTime': const TimeOfDayConverter().toJson(instance.startTime),
      'endTime': const TimeOfDayConverter().toJson(instance.endTime),
      'enabled': instance.enabled,
    };
