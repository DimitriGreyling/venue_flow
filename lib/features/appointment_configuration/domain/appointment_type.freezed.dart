// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppointmentType {

 String get id; String get typeCode; String get displayName; bool get enabled; int get durationMinutes; int get sortOrder;
/// Create a copy of AppointmentType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppointmentTypeCopyWith<AppointmentType> get copyWith => _$AppointmentTypeCopyWithImpl<AppointmentType>(this as AppointmentType, _$identity);

  /// Serializes this AppointmentType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AppointmentType;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppointmentType&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.typeCode, _this.typeCode) || other.typeCode == _this.typeCode)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled)&&(identical(other.durationMinutes, _this.durationMinutes) || other.durationMinutes == _this.durationMinutes)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AppointmentType;
  return Object.hash(runtimeType,_this.id,_this.typeCode,_this.displayName,_this.enabled,_this.durationMinutes,_this.sortOrder);
}

@override
String toString() {
  final _this = this as AppointmentType;
  return 'AppointmentType(id: ${_this.id}, typeCode: ${_this.typeCode}, displayName: ${_this.displayName}, enabled: ${_this.enabled}, durationMinutes: ${_this.durationMinutes}, sortOrder: ${_this.sortOrder})';
}


}

/// @nodoc
abstract mixin class $AppointmentTypeCopyWith<$Res>  {
  factory $AppointmentTypeCopyWith(AppointmentType value, $Res Function(AppointmentType) _then) = _$AppointmentTypeCopyWithImpl;
@useResult
$Res call({
 String id, String typeCode, String displayName, bool enabled, int durationMinutes, int sortOrder
});




}
/// @nodoc
class _$AppointmentTypeCopyWithImpl<$Res>
    implements $AppointmentTypeCopyWith<$Res> {
  _$AppointmentTypeCopyWithImpl(this._self, this._then);

  final AppointmentType _self;
  final $Res Function(AppointmentType) _then;

/// Create a copy of AppointmentType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? typeCode = null,Object? displayName = null,Object? enabled = null,Object? durationMinutes = null,Object? sortOrder = null,}) {
  return _then(AppointmentType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,typeCode: null == typeCode ? _self.typeCode : typeCode // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AppointmentType].
extension AppointmentTypePatterns on AppointmentType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppointmentType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppointmentType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppointmentType value)  $default,){
final _that = this;
switch (_that) {
case _AppointmentType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppointmentType value)?  $default,){
final _that = this;
switch (_that) {
case _AppointmentType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String typeCode,  String displayName,  bool enabled,  int durationMinutes,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppointmentType() when $default != null:
return $default(_that.id,_that.typeCode,_that.displayName,_that.enabled,_that.durationMinutes,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String typeCode,  String displayName,  bool enabled,  int durationMinutes,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _AppointmentType():
return $default(_that.id,_that.typeCode,_that.displayName,_that.enabled,_that.durationMinutes,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String typeCode,  String displayName,  bool enabled,  int durationMinutes,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _AppointmentType() when $default != null:
return $default(_that.id,_that.typeCode,_that.displayName,_that.enabled,_that.durationMinutes,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppointmentType implements AppointmentType {
  const _AppointmentType({required this.id, required this.typeCode, required this.displayName, required this.enabled, required this.durationMinutes, required this.sortOrder});
  factory _AppointmentType.fromJson(Map<String, dynamic> json) => _$AppointmentTypeFromJson(json);

@override final  String id;
@override final  String typeCode;
@override final  String displayName;
@override final  bool enabled;
@override final  int durationMinutes;
@override final  int sortOrder;

/// Create a copy of AppointmentType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppointmentTypeCopyWith<_AppointmentType> get copyWith => __$AppointmentTypeCopyWithImpl<_AppointmentType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppointmentTypeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppointmentType&&(identical(other.id, id) || other.id == id)&&(identical(other.typeCode, typeCode) || other.typeCode == typeCode)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,typeCode,displayName,enabled,durationMinutes,sortOrder);
}

@override
String toString() {
    return 'AppointmentType(id: $id, typeCode: $typeCode, displayName: $displayName, enabled: $enabled, durationMinutes: $durationMinutes, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$AppointmentTypeCopyWith<$Res> implements $AppointmentTypeCopyWith<$Res> {
  factory _$AppointmentTypeCopyWith(_AppointmentType value, $Res Function(_AppointmentType) _then) = __$AppointmentTypeCopyWithImpl;
@override @useResult
$Res call({
 String id, String typeCode, String displayName, bool enabled, int durationMinutes, int sortOrder
});




}
/// @nodoc
class __$AppointmentTypeCopyWithImpl<$Res>
    implements _$AppointmentTypeCopyWith<$Res> {
  __$AppointmentTypeCopyWithImpl(this._self, this._then);

  final _AppointmentType _self;
  final $Res Function(_AppointmentType) _then;

/// Create a copy of AppointmentType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? typeCode = null,Object? displayName = null,Object? enabled = null,Object? durationMinutes = null,Object? sortOrder = null,}) {
  return _then(_AppointmentType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,typeCode: null == typeCode ? _self.typeCode : typeCode // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
