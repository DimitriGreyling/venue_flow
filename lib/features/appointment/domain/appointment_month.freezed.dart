// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_month.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppointmentMonth {

 DateTime get startDate; DateTime get endDate; List<AppointmentDays> get days;
/// Create a copy of AppointmentMonth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppointmentMonthCopyWith<AppointmentMonth> get copyWith => _$AppointmentMonthCopyWithImpl<AppointmentMonth>(this as AppointmentMonth, _$identity);

  /// Serializes this AppointmentMonth to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AppointmentMonth;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppointmentMonth&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&const DeepCollectionEquality().equals(other.days, _this.days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AppointmentMonth;
  return Object.hash(runtimeType,_this.startDate,_this.endDate,const DeepCollectionEquality().hash(_this.days));
}

@override
String toString() {
  final _this = this as AppointmentMonth;
  return 'AppointmentMonth(startDate: ${_this.startDate}, endDate: ${_this.endDate}, days: ${_this.days})';
}


}

/// @nodoc
abstract mixin class $AppointmentMonthCopyWith<$Res>  {
  factory $AppointmentMonthCopyWith(AppointmentMonth value, $Res Function(AppointmentMonth) _then) = _$AppointmentMonthCopyWithImpl;
@useResult
$Res call({
 DateTime startDate, DateTime endDate, List<AppointmentDays> days
});




}
/// @nodoc
class _$AppointmentMonthCopyWithImpl<$Res>
    implements $AppointmentMonthCopyWith<$Res> {
  _$AppointmentMonthCopyWithImpl(this._self, this._then);

  final AppointmentMonth _self;
  final $Res Function(AppointmentMonth) _then;

/// Create a copy of AppointmentMonth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startDate = null,Object? endDate = null,Object? days = null,}) {
  return _then(AppointmentMonth(
startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<AppointmentDays>,
  ));
}

}


/// Adds pattern-matching-related methods to [AppointmentMonth].
extension AppointmentMonthPatterns on AppointmentMonth {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppointmentMonth value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppointmentMonth() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppointmentMonth value)  $default,){
final _that = this;
switch (_that) {
case _AppointmentMonth():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppointmentMonth value)?  $default,){
final _that = this;
switch (_that) {
case _AppointmentMonth() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime startDate,  DateTime endDate,  List<AppointmentDays> days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppointmentMonth() when $default != null:
return $default(_that.startDate,_that.endDate,_that.days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime startDate,  DateTime endDate,  List<AppointmentDays> days)  $default,) {final _that = this;
switch (_that) {
case _AppointmentMonth():
return $default(_that.startDate,_that.endDate,_that.days);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime startDate,  DateTime endDate,  List<AppointmentDays> days)?  $default,) {final _that = this;
switch (_that) {
case _AppointmentMonth() when $default != null:
return $default(_that.startDate,_that.endDate,_that.days);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppointmentMonth implements AppointmentMonth {
  const _AppointmentMonth({required this.startDate, required this.endDate, required  List<AppointmentDays> days}): _days = days;
  factory _AppointmentMonth.fromJson(Map<String, dynamic> json) => _$AppointmentMonthFromJson(json);

@override final  DateTime startDate;
@override final  DateTime endDate;
 final  List<AppointmentDays> _days;
@override List<AppointmentDays> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}


/// Create a copy of AppointmentMonth
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppointmentMonthCopyWith<_AppointmentMonth> get copyWith => __$AppointmentMonthCopyWithImpl<_AppointmentMonth>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppointmentMonthToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppointmentMonth&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&const DeepCollectionEquality().equals(other.days, _days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,startDate,endDate,const DeepCollectionEquality().hash(_days));
}

@override
String toString() {
    return 'AppointmentMonth(startDate: $startDate, endDate: $endDate, days: $days)';
}


}

/// @nodoc
abstract mixin class _$AppointmentMonthCopyWith<$Res> implements $AppointmentMonthCopyWith<$Res> {
  factory _$AppointmentMonthCopyWith(_AppointmentMonth value, $Res Function(_AppointmentMonth) _then) = __$AppointmentMonthCopyWithImpl;
@override @useResult
$Res call({
 DateTime startDate, DateTime endDate, List<AppointmentDays> days
});




}
/// @nodoc
class __$AppointmentMonthCopyWithImpl<$Res>
    implements _$AppointmentMonthCopyWith<$Res> {
  __$AppointmentMonthCopyWithImpl(this._self, this._then);

  final _AppointmentMonth _self;
  final $Res Function(_AppointmentMonth) _then;

/// Create a copy of AppointmentMonth
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startDate = null,Object? endDate = null,Object? days = null,}) {
  return _then(_AppointmentMonth(
startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<AppointmentDays>,
  ));
}


}

// dart format on
