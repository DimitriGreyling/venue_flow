// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'working_hours.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkingHours {

 String get id; int get dayOfWeek;@TimeOfDayConverter() TimeOfDay get startTime;@TimeOfDayConverter() TimeOfDay get endTime; bool get enabled;
/// Create a copy of WorkingHours
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkingHoursCopyWith<WorkingHours> get copyWith => _$WorkingHoursCopyWithImpl<WorkingHours>(this as WorkingHours, _$identity);

  /// Serializes this WorkingHours to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WorkingHours;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkingHours&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.dayOfWeek, _this.dayOfWeek) || other.dayOfWeek == _this.dayOfWeek)&&(identical(other.startTime, _this.startTime) || other.startTime == _this.startTime)&&(identical(other.endTime, _this.endTime) || other.endTime == _this.endTime)&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WorkingHours;
  return Object.hash(runtimeType,_this.id,_this.dayOfWeek,_this.startTime,_this.endTime,_this.enabled);
}

@override
String toString() {
  final _this = this as WorkingHours;
  return 'WorkingHours(id: ${_this.id}, dayOfWeek: ${_this.dayOfWeek}, startTime: ${_this.startTime}, endTime: ${_this.endTime}, enabled: ${_this.enabled})';
}


}

/// @nodoc
abstract mixin class $WorkingHoursCopyWith<$Res>  {
  factory $WorkingHoursCopyWith(WorkingHours value, $Res Function(WorkingHours) _then) = _$WorkingHoursCopyWithImpl;
@useResult
$Res call({
 String id, int dayOfWeek,@TimeOfDayConverter() TimeOfDay startTime,@TimeOfDayConverter() TimeOfDay endTime, bool enabled
});




}
/// @nodoc
class _$WorkingHoursCopyWithImpl<$Res>
    implements $WorkingHoursCopyWith<$Res> {
  _$WorkingHoursCopyWithImpl(this._self, this._then);

  final WorkingHours _self;
  final $Res Function(WorkingHours) _then;

/// Create a copy of WorkingHours
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? dayOfWeek = null,Object? startTime = null,Object? endTime = null,Object? enabled = null,}) {
  return _then(WorkingHours(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkingHours].
extension WorkingHoursPatterns on WorkingHours {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkingHours value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkingHours() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkingHours value)  $default,){
final _that = this;
switch (_that) {
case _WorkingHours():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkingHours value)?  $default,){
final _that = this;
switch (_that) {
case _WorkingHours() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int dayOfWeek, @TimeOfDayConverter()  TimeOfDay startTime, @TimeOfDayConverter()  TimeOfDay endTime,  bool enabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkingHours() when $default != null:
return $default(_that.id,_that.dayOfWeek,_that.startTime,_that.endTime,_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int dayOfWeek, @TimeOfDayConverter()  TimeOfDay startTime, @TimeOfDayConverter()  TimeOfDay endTime,  bool enabled)  $default,) {final _that = this;
switch (_that) {
case _WorkingHours():
return $default(_that.id,_that.dayOfWeek,_that.startTime,_that.endTime,_that.enabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int dayOfWeek, @TimeOfDayConverter()  TimeOfDay startTime, @TimeOfDayConverter()  TimeOfDay endTime,  bool enabled)?  $default,) {final _that = this;
switch (_that) {
case _WorkingHours() when $default != null:
return $default(_that.id,_that.dayOfWeek,_that.startTime,_that.endTime,_that.enabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkingHours implements WorkingHours {
  const _WorkingHours({required this.id, required this.dayOfWeek, @TimeOfDayConverter() required this.startTime, @TimeOfDayConverter() required this.endTime, required this.enabled});
  factory _WorkingHours.fromJson(Map<String, dynamic> json) => _$WorkingHoursFromJson(json);

@override final  String id;
@override final  int dayOfWeek;
@override@TimeOfDayConverter() final  TimeOfDay startTime;
@override@TimeOfDayConverter() final  TimeOfDay endTime;
@override final  bool enabled;

/// Create a copy of WorkingHours
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkingHoursCopyWith<_WorkingHours> get copyWith => __$WorkingHoursCopyWithImpl<_WorkingHours>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkingHoursToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkingHours&&(identical(other.id, id) || other.id == id)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,dayOfWeek,startTime,endTime,enabled);
}

@override
String toString() {
    return 'WorkingHours(id: $id, dayOfWeek: $dayOfWeek, startTime: $startTime, endTime: $endTime, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$WorkingHoursCopyWith<$Res> implements $WorkingHoursCopyWith<$Res> {
  factory _$WorkingHoursCopyWith(_WorkingHours value, $Res Function(_WorkingHours) _then) = __$WorkingHoursCopyWithImpl;
@override @useResult
$Res call({
 String id, int dayOfWeek,@TimeOfDayConverter() TimeOfDay startTime,@TimeOfDayConverter() TimeOfDay endTime, bool enabled
});




}
/// @nodoc
class __$WorkingHoursCopyWithImpl<$Res>
    implements _$WorkingHoursCopyWith<$Res> {
  __$WorkingHoursCopyWithImpl(this._self, this._then);

  final _WorkingHours _self;
  final $Res Function(_WorkingHours) _then;

/// Create a copy of WorkingHours
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? dayOfWeek = null,Object? startTime = null,Object? endTime = null,Object? enabled = null,}) {
  return _then(_WorkingHours(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
