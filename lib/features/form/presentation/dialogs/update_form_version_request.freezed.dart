// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_form_version_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateFormVersionRequest {

 String get schemaJson;
/// Create a copy of UpdateFormVersionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateFormVersionRequestCopyWith<UpdateFormVersionRequest> get copyWith => _$UpdateFormVersionRequestCopyWithImpl<UpdateFormVersionRequest>(this as UpdateFormVersionRequest, _$identity);

  /// Serializes this UpdateFormVersionRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UpdateFormVersionRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateFormVersionRequest&&(identical(other.schemaJson, _this.schemaJson) || other.schemaJson == _this.schemaJson));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UpdateFormVersionRequest;
  return Object.hash(runtimeType,_this.schemaJson);
}

@override
String toString() {
  final _this = this as UpdateFormVersionRequest;
  return 'UpdateFormVersionRequest(schemaJson: ${_this.schemaJson})';
}


}

/// @nodoc
abstract mixin class $UpdateFormVersionRequestCopyWith<$Res>  {
  factory $UpdateFormVersionRequestCopyWith(UpdateFormVersionRequest value, $Res Function(UpdateFormVersionRequest) _then) = _$UpdateFormVersionRequestCopyWithImpl;
@useResult
$Res call({
 String schemaJson
});




}
/// @nodoc
class _$UpdateFormVersionRequestCopyWithImpl<$Res>
    implements $UpdateFormVersionRequestCopyWith<$Res> {
  _$UpdateFormVersionRequestCopyWithImpl(this._self, this._then);

  final UpdateFormVersionRequest _self;
  final $Res Function(UpdateFormVersionRequest) _then;

/// Create a copy of UpdateFormVersionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaJson = null,}) {
  return _then(UpdateFormVersionRequest(
schemaJson: null == schemaJson ? _self.schemaJson : schemaJson // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateFormVersionRequest].
extension UpdateFormVersionRequestPatterns on UpdateFormVersionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateFormVersionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateFormVersionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateFormVersionRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateFormVersionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateFormVersionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateFormVersionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String schemaJson)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateFormVersionRequest() when $default != null:
return $default(_that.schemaJson);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String schemaJson)  $default,) {final _that = this;
switch (_that) {
case _UpdateFormVersionRequest():
return $default(_that.schemaJson);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String schemaJson)?  $default,) {final _that = this;
switch (_that) {
case _UpdateFormVersionRequest() when $default != null:
return $default(_that.schemaJson);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateFormVersionRequest implements UpdateFormVersionRequest {
  const _UpdateFormVersionRequest({required this.schemaJson});
  factory _UpdateFormVersionRequest.fromJson(Map<String, dynamic> json) => _$UpdateFormVersionRequestFromJson(json);

@override final  String schemaJson;

/// Create a copy of UpdateFormVersionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateFormVersionRequestCopyWith<_UpdateFormVersionRequest> get copyWith => __$UpdateFormVersionRequestCopyWithImpl<_UpdateFormVersionRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateFormVersionRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateFormVersionRequest&&(identical(other.schemaJson, schemaJson) || other.schemaJson == schemaJson));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,schemaJson);
}

@override
String toString() {
    return 'UpdateFormVersionRequest(schemaJson: $schemaJson)';
}


}

/// @nodoc
abstract mixin class _$UpdateFormVersionRequestCopyWith<$Res> implements $UpdateFormVersionRequestCopyWith<$Res> {
  factory _$UpdateFormVersionRequestCopyWith(_UpdateFormVersionRequest value, $Res Function(_UpdateFormVersionRequest) _then) = __$UpdateFormVersionRequestCopyWithImpl;
@override @useResult
$Res call({
 String schemaJson
});




}
/// @nodoc
class __$UpdateFormVersionRequestCopyWithImpl<$Res>
    implements _$UpdateFormVersionRequestCopyWith<$Res> {
  __$UpdateFormVersionRequestCopyWithImpl(this._self, this._then);

  final _UpdateFormVersionRequest _self;
  final $Res Function(_UpdateFormVersionRequest) _then;

/// Create a copy of UpdateFormVersionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaJson = null,}) {
  return _then(_UpdateFormVersionRequest(
schemaJson: null == schemaJson ? _self.schemaJson : schemaJson // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
