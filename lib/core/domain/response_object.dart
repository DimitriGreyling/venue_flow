import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_object.freezed.dart';
part 'response_object.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class ResponseObject<T> with _$ResponseObject<T> {
  const factory ResponseObject({
    T? data,
    String? message,
    @Default(false) bool success,
    int? statusCode,
  }) = _ResponseObject<T>;

  factory ResponseObject.fromJson(
      Map<String, dynamic> json,
      T Function(Object?) fromJsonT,
      ) =>
      _$ResponseObjectFromJson(json, fromJsonT);
}