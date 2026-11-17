// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResponseObject<T> _$ResponseObjectFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _ResponseObject<T>(
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
  message: json['message'] as String?,
  success: json['success'] as bool? ?? false,
  statusCode: (json['statusCode'] as num?)?.toInt(),
);

Map<String, dynamic> _$ResponseObjectToJson<T>(
  _ResponseObject<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'data': _$nullableGenericToJson(instance.data, toJsonT),
  'message': instance.message,
  'success': instance.success,
  'statusCode': instance.statusCode,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);
