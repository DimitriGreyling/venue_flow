// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_search_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VenueSearchResponse {

 String get id; String get name; String get venueType; String get description;
/// Create a copy of VenueSearchResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueSearchResponseCopyWith<VenueSearchResponse> get copyWith => _$VenueSearchResponseCopyWithImpl<VenueSearchResponse>(this as VenueSearchResponse, _$identity);

  /// Serializes this VenueSearchResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VenueSearchResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueSearchResponse&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.venueType, _this.venueType) || other.venueType == _this.venueType)&&(identical(other.description, _this.description) || other.description == _this.description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VenueSearchResponse;
  return Object.hash(runtimeType,_this.id,_this.name,_this.venueType,_this.description);
}

@override
String toString() {
  final _this = this as VenueSearchResponse;
  return 'VenueSearchResponse(id: ${_this.id}, name: ${_this.name}, venueType: ${_this.venueType}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $VenueSearchResponseCopyWith<$Res>  {
  factory $VenueSearchResponseCopyWith(VenueSearchResponse value, $Res Function(VenueSearchResponse) _then) = _$VenueSearchResponseCopyWithImpl;
@useResult
$Res call({
 String id, String name, String venueType, String description
});




}
/// @nodoc
class _$VenueSearchResponseCopyWithImpl<$Res>
    implements $VenueSearchResponseCopyWith<$Res> {
  _$VenueSearchResponseCopyWithImpl(this._self, this._then);

  final VenueSearchResponse _self;
  final $Res Function(VenueSearchResponse) _then;

/// Create a copy of VenueSearchResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? venueType = null,Object? description = null,}) {
  return _then(VenueSearchResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,venueType: null == venueType ? _self.venueType : venueType // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VenueSearchResponse].
extension VenueSearchResponsePatterns on VenueSearchResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenueSearchResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenueSearchResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenueSearchResponse value)  $default,){
final _that = this;
switch (_that) {
case _VenueSearchResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenueSearchResponse value)?  $default,){
final _that = this;
switch (_that) {
case _VenueSearchResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String venueType,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenueSearchResponse() when $default != null:
return $default(_that.id,_that.name,_that.venueType,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String venueType,  String description)  $default,) {final _that = this;
switch (_that) {
case _VenueSearchResponse():
return $default(_that.id,_that.name,_that.venueType,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String venueType,  String description)?  $default,) {final _that = this;
switch (_that) {
case _VenueSearchResponse() when $default != null:
return $default(_that.id,_that.name,_that.venueType,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VenueSearchResponse implements VenueSearchResponse {
  const _VenueSearchResponse({required this.id, required this.name, required this.venueType, required this.description});
  factory _VenueSearchResponse.fromJson(Map<String, dynamic> json) => _$VenueSearchResponseFromJson(json);

@override final  String id;
@override final  String name;
@override final  String venueType;
@override final  String description;

/// Create a copy of VenueSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenueSearchResponseCopyWith<_VenueSearchResponse> get copyWith => __$VenueSearchResponseCopyWithImpl<_VenueSearchResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VenueSearchResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenueSearchResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.venueType, venueType) || other.venueType == venueType)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,venueType,description);
}

@override
String toString() {
    return 'VenueSearchResponse(id: $id, name: $name, venueType: $venueType, description: $description)';
}


}

/// @nodoc
abstract mixin class _$VenueSearchResponseCopyWith<$Res> implements $VenueSearchResponseCopyWith<$Res> {
  factory _$VenueSearchResponseCopyWith(_VenueSearchResponse value, $Res Function(_VenueSearchResponse) _then) = __$VenueSearchResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String venueType, String description
});




}
/// @nodoc
class __$VenueSearchResponseCopyWithImpl<$Res>
    implements _$VenueSearchResponseCopyWith<$Res> {
  __$VenueSearchResponseCopyWithImpl(this._self, this._then);

  final _VenueSearchResponse _self;
  final $Res Function(_VenueSearchResponse) _then;

/// Create a copy of VenueSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? venueType = null,Object? description = null,}) {
  return _then(_VenueSearchResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,venueType: null == venueType ? _self.venueType : venueType // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
