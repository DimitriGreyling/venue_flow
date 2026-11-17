// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'response_object.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResponseObject<T> {

 T? get data; String? get message; bool get success; int? get statusCode;
/// Create a copy of ResponseObject
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResponseObjectCopyWith<T, ResponseObject<T>> get copyWith => _$ResponseObjectCopyWithImpl<T, ResponseObject<T>>(this as ResponseObject<T>, _$identity);

  /// Serializes this ResponseObject to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  final _this = this as ResponseObject<T>;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResponseObject<T>&&const DeepCollectionEquality().equals(other.data, _this.data)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.success, _this.success) || other.success == _this.success)&&(identical(other.statusCode, _this.statusCode) || other.statusCode == _this.statusCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ResponseObject<T>;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.data),_this.message,_this.success,_this.statusCode);
}

@override
String toString() {
  final _this = this as ResponseObject<T>;
  return 'ResponseObject<$T>(data: ${_this.data}, message: ${_this.message}, success: ${_this.success}, statusCode: ${_this.statusCode})';
}


}

/// @nodoc
abstract mixin class $ResponseObjectCopyWith<T,$Res>  {
  factory $ResponseObjectCopyWith(ResponseObject<T> value, $Res Function(ResponseObject<T>) _then) = _$ResponseObjectCopyWithImpl;
@useResult
$Res call({
 T? data, String? message, bool success, int? statusCode
});




}
/// @nodoc
class _$ResponseObjectCopyWithImpl<T,$Res>
    implements $ResponseObjectCopyWith<T, $Res> {
  _$ResponseObjectCopyWithImpl(this._self, this._then);

  final ResponseObject<T> _self;
  final $Res Function(ResponseObject<T>) _then;

/// Create a copy of ResponseObject
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = freezed,Object? message = freezed,Object? success = null,Object? statusCode = freezed,}) {
  return _then(ResponseObject(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ResponseObject].
extension ResponseObjectPatterns<T> on ResponseObject<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResponseObject<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResponseObject() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResponseObject<T> value)  $default,){
final _that = this;
switch (_that) {
case _ResponseObject():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResponseObject<T> value)?  $default,){
final _that = this;
switch (_that) {
case _ResponseObject() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( T? data,  String? message,  bool success,  int? statusCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResponseObject() when $default != null:
return $default(_that.data,_that.message,_that.success,_that.statusCode);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( T? data,  String? message,  bool success,  int? statusCode)  $default,) {final _that = this;
switch (_that) {
case _ResponseObject():
return $default(_that.data,_that.message,_that.success,_that.statusCode);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( T? data,  String? message,  bool success,  int? statusCode)?  $default,) {final _that = this;
switch (_that) {
case _ResponseObject() when $default != null:
return $default(_that.data,_that.message,_that.success,_that.statusCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _ResponseObject<T> implements ResponseObject<T> {
  const _ResponseObject({this.data, this.message, this.success = false, this.statusCode});
  factory _ResponseObject.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$ResponseObjectFromJson(json,fromJsonT);

@override final  T? data;
@override final  String? message;
@override@JsonKey() final  bool success;
@override final  int? statusCode;

/// Create a copy of ResponseObject
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResponseObjectCopyWith<T, _ResponseObject<T>> get copyWith => __$ResponseObjectCopyWithImpl<T, _ResponseObject<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$ResponseObjectToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResponseObject<T>&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.message, message) || other.message == message)&&(identical(other.success, success) || other.success == success)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(data),message,success,statusCode);
}

@override
String toString() {
    return 'ResponseObject<$T>(data: $data, message: $message, success: $success, statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class _$ResponseObjectCopyWith<T,$Res> implements $ResponseObjectCopyWith<T, $Res> {
  factory _$ResponseObjectCopyWith(_ResponseObject<T> value, $Res Function(_ResponseObject<T>) _then) = __$ResponseObjectCopyWithImpl;
@override @useResult
$Res call({
 T? data, String? message, bool success, int? statusCode
});




}
/// @nodoc
class __$ResponseObjectCopyWithImpl<T,$Res>
    implements _$ResponseObjectCopyWith<T, $Res> {
  __$ResponseObjectCopyWithImpl(this._self, this._then);

  final _ResponseObject<T> _self;
  final $Res Function(_ResponseObject<T>) _then;

/// Create a copy of ResponseObject
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? message = freezed,Object? success = null,Object? statusCode = freezed,}) {
  return _then(_ResponseObject<T>(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
