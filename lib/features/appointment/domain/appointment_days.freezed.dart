// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_days.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppointmentDays {

 DateTime get date; int get totalCount; int get pendingCount; int get confirmedCount; int get rescheduleProposedCount; List<String> get appointmentIds;
/// Create a copy of AppointmentDays
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppointmentDaysCopyWith<AppointmentDays> get copyWith => _$AppointmentDaysCopyWithImpl<AppointmentDays>(this as AppointmentDays, _$identity);

  /// Serializes this AppointmentDays to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AppointmentDays;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppointmentDays&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&(identical(other.pendingCount, _this.pendingCount) || other.pendingCount == _this.pendingCount)&&(identical(other.confirmedCount, _this.confirmedCount) || other.confirmedCount == _this.confirmedCount)&&(identical(other.rescheduleProposedCount, _this.rescheduleProposedCount) || other.rescheduleProposedCount == _this.rescheduleProposedCount)&&const DeepCollectionEquality().equals(other.appointmentIds, _this.appointmentIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AppointmentDays;
  return Object.hash(runtimeType,_this.date,_this.totalCount,_this.pendingCount,_this.confirmedCount,_this.rescheduleProposedCount,const DeepCollectionEquality().hash(_this.appointmentIds));
}

@override
String toString() {
  final _this = this as AppointmentDays;
  return 'AppointmentDays(date: ${_this.date}, totalCount: ${_this.totalCount}, pendingCount: ${_this.pendingCount}, confirmedCount: ${_this.confirmedCount}, rescheduleProposedCount: ${_this.rescheduleProposedCount}, appointmentIds: ${_this.appointmentIds})';
}


}

/// @nodoc
abstract mixin class $AppointmentDaysCopyWith<$Res>  {
  factory $AppointmentDaysCopyWith(AppointmentDays value, $Res Function(AppointmentDays) _then) = _$AppointmentDaysCopyWithImpl;
@useResult
$Res call({
 DateTime date, int totalCount, int pendingCount, int confirmedCount, int rescheduleProposedCount, List<String> appointmentIds
});




}
/// @nodoc
class _$AppointmentDaysCopyWithImpl<$Res>
    implements $AppointmentDaysCopyWith<$Res> {
  _$AppointmentDaysCopyWithImpl(this._self, this._then);

  final AppointmentDays _self;
  final $Res Function(AppointmentDays) _then;

/// Create a copy of AppointmentDays
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? totalCount = null,Object? pendingCount = null,Object? confirmedCount = null,Object? rescheduleProposedCount = null,Object? appointmentIds = null,}) {
  return _then(AppointmentDays(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,pendingCount: null == pendingCount ? _self.pendingCount : pendingCount // ignore: cast_nullable_to_non_nullable
as int,confirmedCount: null == confirmedCount ? _self.confirmedCount : confirmedCount // ignore: cast_nullable_to_non_nullable
as int,rescheduleProposedCount: null == rescheduleProposedCount ? _self.rescheduleProposedCount : rescheduleProposedCount // ignore: cast_nullable_to_non_nullable
as int,appointmentIds: null == appointmentIds ? _self.appointmentIds : appointmentIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [AppointmentDays].
extension AppointmentDaysPatterns on AppointmentDays {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppointmentDays value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppointmentDays() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppointmentDays value)  $default,){
final _that = this;
switch (_that) {
case _AppointmentDays():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppointmentDays value)?  $default,){
final _that = this;
switch (_that) {
case _AppointmentDays() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  int totalCount,  int pendingCount,  int confirmedCount,  int rescheduleProposedCount,  List<String> appointmentIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppointmentDays() when $default != null:
return $default(_that.date,_that.totalCount,_that.pendingCount,_that.confirmedCount,_that.rescheduleProposedCount,_that.appointmentIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  int totalCount,  int pendingCount,  int confirmedCount,  int rescheduleProposedCount,  List<String> appointmentIds)  $default,) {final _that = this;
switch (_that) {
case _AppointmentDays():
return $default(_that.date,_that.totalCount,_that.pendingCount,_that.confirmedCount,_that.rescheduleProposedCount,_that.appointmentIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  int totalCount,  int pendingCount,  int confirmedCount,  int rescheduleProposedCount,  List<String> appointmentIds)?  $default,) {final _that = this;
switch (_that) {
case _AppointmentDays() when $default != null:
return $default(_that.date,_that.totalCount,_that.pendingCount,_that.confirmedCount,_that.rescheduleProposedCount,_that.appointmentIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppointmentDays implements AppointmentDays {
  const _AppointmentDays({required this.date, required this.totalCount, required this.pendingCount, required this.confirmedCount, required this.rescheduleProposedCount, required  List<String> appointmentIds}): _appointmentIds = appointmentIds;
  factory _AppointmentDays.fromJson(Map<String, dynamic> json) => _$AppointmentDaysFromJson(json);

@override final  DateTime date;
@override final  int totalCount;
@override final  int pendingCount;
@override final  int confirmedCount;
@override final  int rescheduleProposedCount;
 final  List<String> _appointmentIds;
@override List<String> get appointmentIds {
  if (_appointmentIds is EqualUnmodifiableListView) return _appointmentIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_appointmentIds);
}


/// Create a copy of AppointmentDays
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppointmentDaysCopyWith<_AppointmentDays> get copyWith => __$AppointmentDaysCopyWithImpl<_AppointmentDays>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppointmentDaysToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppointmentDays&&(identical(other.date, date) || other.date == date)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.pendingCount, pendingCount) || other.pendingCount == pendingCount)&&(identical(other.confirmedCount, confirmedCount) || other.confirmedCount == confirmedCount)&&(identical(other.rescheduleProposedCount, rescheduleProposedCount) || other.rescheduleProposedCount == rescheduleProposedCount)&&const DeepCollectionEquality().equals(other.appointmentIds, _appointmentIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,date,totalCount,pendingCount,confirmedCount,rescheduleProposedCount,const DeepCollectionEquality().hash(_appointmentIds));
}

@override
String toString() {
    return 'AppointmentDays(date: $date, totalCount: $totalCount, pendingCount: $pendingCount, confirmedCount: $confirmedCount, rescheduleProposedCount: $rescheduleProposedCount, appointmentIds: $appointmentIds)';
}


}

/// @nodoc
abstract mixin class _$AppointmentDaysCopyWith<$Res> implements $AppointmentDaysCopyWith<$Res> {
  factory _$AppointmentDaysCopyWith(_AppointmentDays value, $Res Function(_AppointmentDays) _then) = __$AppointmentDaysCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int totalCount, int pendingCount, int confirmedCount, int rescheduleProposedCount, List<String> appointmentIds
});




}
/// @nodoc
class __$AppointmentDaysCopyWithImpl<$Res>
    implements _$AppointmentDaysCopyWith<$Res> {
  __$AppointmentDaysCopyWithImpl(this._self, this._then);

  final _AppointmentDays _self;
  final $Res Function(_AppointmentDays) _then;

/// Create a copy of AppointmentDays
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? totalCount = null,Object? pendingCount = null,Object? confirmedCount = null,Object? rescheduleProposedCount = null,Object? appointmentIds = null,}) {
  return _then(_AppointmentDays(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,pendingCount: null == pendingCount ? _self.pendingCount : pendingCount // ignore: cast_nullable_to_non_nullable
as int,confirmedCount: null == confirmedCount ? _self.confirmedCount : confirmedCount // ignore: cast_nullable_to_non_nullable
as int,rescheduleProposedCount: null == rescheduleProposedCount ? _self.rescheduleProposedCount : rescheduleProposedCount // ignore: cast_nullable_to_non_nullable
as int,appointmentIds: null == appointmentIds ? _self._appointmentIds : appointmentIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
