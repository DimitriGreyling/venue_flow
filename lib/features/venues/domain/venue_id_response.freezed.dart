// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_id_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VenueIdResponse {

 String get venueId;
/// Create a copy of VenueIdResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueIdResponseCopyWith<VenueIdResponse> get copyWith => _$VenueIdResponseCopyWithImpl<VenueIdResponse>(this as VenueIdResponse, _$identity);

  /// Serializes this VenueIdResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VenueIdResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueIdResponse&&(identical(other.venueId, _this.venueId) || other.venueId == _this.venueId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VenueIdResponse;
  return Object.hash(runtimeType,_this.venueId);
}

@override
String toString() {
  final _this = this as VenueIdResponse;
  return 'VenueIdResponse(venueId: ${_this.venueId})';
}


}

/// @nodoc
abstract mixin class $VenueIdResponseCopyWith<$Res>  {
  factory $VenueIdResponseCopyWith(VenueIdResponse value, $Res Function(VenueIdResponse) _then) = _$VenueIdResponseCopyWithImpl;
@useResult
$Res call({
 String venueId
});




}
/// @nodoc
class _$VenueIdResponseCopyWithImpl<$Res>
    implements $VenueIdResponseCopyWith<$Res> {
  _$VenueIdResponseCopyWithImpl(this._self, this._then);

  final VenueIdResponse _self;
  final $Res Function(VenueIdResponse) _then;

/// Create a copy of VenueIdResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? venueId = null,}) {
  return _then(VenueIdResponse(
venueId: null == venueId ? _self.venueId : venueId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VenueIdResponse].
extension VenueIdResponsePatterns on VenueIdResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenueIdResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenueIdResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenueIdResponse value)  $default,){
final _that = this;
switch (_that) {
case _VenueIdResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenueIdResponse value)?  $default,){
final _that = this;
switch (_that) {
case _VenueIdResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String venueId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenueIdResponse() when $default != null:
return $default(_that.venueId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String venueId)  $default,) {final _that = this;
switch (_that) {
case _VenueIdResponse():
return $default(_that.venueId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String venueId)?  $default,) {final _that = this;
switch (_that) {
case _VenueIdResponse() when $default != null:
return $default(_that.venueId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VenueIdResponse implements VenueIdResponse {
  const _VenueIdResponse({required this.venueId});
  factory _VenueIdResponse.fromJson(Map<String, dynamic> json) => _$VenueIdResponseFromJson(json);

@override final  String venueId;

/// Create a copy of VenueIdResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenueIdResponseCopyWith<_VenueIdResponse> get copyWith => __$VenueIdResponseCopyWithImpl<_VenueIdResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VenueIdResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenueIdResponse&&(identical(other.venueId, venueId) || other.venueId == venueId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,venueId);
}

@override
String toString() {
    return 'VenueIdResponse(venueId: $venueId)';
}


}

/// @nodoc
abstract mixin class _$VenueIdResponseCopyWith<$Res> implements $VenueIdResponseCopyWith<$Res> {
  factory _$VenueIdResponseCopyWith(_VenueIdResponse value, $Res Function(_VenueIdResponse) _then) = __$VenueIdResponseCopyWithImpl;
@override @useResult
$Res call({
 String venueId
});




}
/// @nodoc
class __$VenueIdResponseCopyWithImpl<$Res>
    implements _$VenueIdResponseCopyWith<$Res> {
  __$VenueIdResponseCopyWithImpl(this._self, this._then);

  final _VenueIdResponse _self;
  final $Res Function(_VenueIdResponse) _then;

/// Create a copy of VenueIdResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? venueId = null,}) {
  return _then(_VenueIdResponse(
venueId: null == venueId ? _self.venueId : venueId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
