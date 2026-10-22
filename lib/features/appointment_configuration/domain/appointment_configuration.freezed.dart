// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppointmentConfiguration {

 String get id; String get venueId; bool get enabled; String get timeZone; String get approvalMode; int get advanceBookingDays; int get minimumNoticeHours; int get slotIntervalMinutes; int get bufferMinutes; int get maximumBookingsPerSlot; List<AppointmentType> get appointmentTypes; List<WorkingHours> get workingHours;
/// Create a copy of AppointmentConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppointmentConfigurationCopyWith<AppointmentConfiguration> get copyWith => _$AppointmentConfigurationCopyWithImpl<AppointmentConfiguration>(this as AppointmentConfiguration, _$identity);

  /// Serializes this AppointmentConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AppointmentConfiguration;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppointmentConfiguration&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.venueId, _this.venueId) || other.venueId == _this.venueId)&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled)&&(identical(other.timeZone, _this.timeZone) || other.timeZone == _this.timeZone)&&(identical(other.approvalMode, _this.approvalMode) || other.approvalMode == _this.approvalMode)&&(identical(other.advanceBookingDays, _this.advanceBookingDays) || other.advanceBookingDays == _this.advanceBookingDays)&&(identical(other.minimumNoticeHours, _this.minimumNoticeHours) || other.minimumNoticeHours == _this.minimumNoticeHours)&&(identical(other.slotIntervalMinutes, _this.slotIntervalMinutes) || other.slotIntervalMinutes == _this.slotIntervalMinutes)&&(identical(other.bufferMinutes, _this.bufferMinutes) || other.bufferMinutes == _this.bufferMinutes)&&(identical(other.maximumBookingsPerSlot, _this.maximumBookingsPerSlot) || other.maximumBookingsPerSlot == _this.maximumBookingsPerSlot)&&const DeepCollectionEquality().equals(other.appointmentTypes, _this.appointmentTypes)&&const DeepCollectionEquality().equals(other.workingHours, _this.workingHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AppointmentConfiguration;
  return Object.hash(runtimeType,_this.id,_this.venueId,_this.enabled,_this.timeZone,_this.approvalMode,_this.advanceBookingDays,_this.minimumNoticeHours,_this.slotIntervalMinutes,_this.bufferMinutes,_this.maximumBookingsPerSlot,const DeepCollectionEquality().hash(_this.appointmentTypes),const DeepCollectionEquality().hash(_this.workingHours));
}

@override
String toString() {
  final _this = this as AppointmentConfiguration;
  return 'AppointmentConfiguration(id: ${_this.id}, venueId: ${_this.venueId}, enabled: ${_this.enabled}, timeZone: ${_this.timeZone}, approvalMode: ${_this.approvalMode}, advanceBookingDays: ${_this.advanceBookingDays}, minimumNoticeHours: ${_this.minimumNoticeHours}, slotIntervalMinutes: ${_this.slotIntervalMinutes}, bufferMinutes: ${_this.bufferMinutes}, maximumBookingsPerSlot: ${_this.maximumBookingsPerSlot}, appointmentTypes: ${_this.appointmentTypes}, workingHours: ${_this.workingHours})';
}


}

/// @nodoc
abstract mixin class $AppointmentConfigurationCopyWith<$Res>  {
  factory $AppointmentConfigurationCopyWith(AppointmentConfiguration value, $Res Function(AppointmentConfiguration) _then) = _$AppointmentConfigurationCopyWithImpl;
@useResult
$Res call({
 String id, String venueId, bool enabled, String timeZone, String approvalMode, int advanceBookingDays, int minimumNoticeHours, int slotIntervalMinutes, int bufferMinutes, int maximumBookingsPerSlot, List<AppointmentType> appointmentTypes, List<WorkingHours> workingHours
});




}
/// @nodoc
class _$AppointmentConfigurationCopyWithImpl<$Res>
    implements $AppointmentConfigurationCopyWith<$Res> {
  _$AppointmentConfigurationCopyWithImpl(this._self, this._then);

  final AppointmentConfiguration _self;
  final $Res Function(AppointmentConfiguration) _then;

/// Create a copy of AppointmentConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? venueId = null,Object? enabled = null,Object? timeZone = null,Object? approvalMode = null,Object? advanceBookingDays = null,Object? minimumNoticeHours = null,Object? slotIntervalMinutes = null,Object? bufferMinutes = null,Object? maximumBookingsPerSlot = null,Object? appointmentTypes = null,Object? workingHours = null,}) {
  return _then(AppointmentConfiguration(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,venueId: null == venueId ? _self.venueId : venueId // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,timeZone: null == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String,approvalMode: null == approvalMode ? _self.approvalMode : approvalMode // ignore: cast_nullable_to_non_nullable
as String,advanceBookingDays: null == advanceBookingDays ? _self.advanceBookingDays : advanceBookingDays // ignore: cast_nullable_to_non_nullable
as int,minimumNoticeHours: null == minimumNoticeHours ? _self.minimumNoticeHours : minimumNoticeHours // ignore: cast_nullable_to_non_nullable
as int,slotIntervalMinutes: null == slotIntervalMinutes ? _self.slotIntervalMinutes : slotIntervalMinutes // ignore: cast_nullable_to_non_nullable
as int,bufferMinutes: null == bufferMinutes ? _self.bufferMinutes : bufferMinutes // ignore: cast_nullable_to_non_nullable
as int,maximumBookingsPerSlot: null == maximumBookingsPerSlot ? _self.maximumBookingsPerSlot : maximumBookingsPerSlot // ignore: cast_nullable_to_non_nullable
as int,appointmentTypes: null == appointmentTypes ? _self.appointmentTypes : appointmentTypes // ignore: cast_nullable_to_non_nullable
as List<AppointmentType>,workingHours: null == workingHours ? _self.workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as List<WorkingHours>,
  ));
}

}


/// Adds pattern-matching-related methods to [AppointmentConfiguration].
extension AppointmentConfigurationPatterns on AppointmentConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppointmentConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppointmentConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppointmentConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _AppointmentConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppointmentConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _AppointmentConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String venueId,  bool enabled,  String timeZone,  String approvalMode,  int advanceBookingDays,  int minimumNoticeHours,  int slotIntervalMinutes,  int bufferMinutes,  int maximumBookingsPerSlot,  List<AppointmentType> appointmentTypes,  List<WorkingHours> workingHours)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppointmentConfiguration() when $default != null:
return $default(_that.id,_that.venueId,_that.enabled,_that.timeZone,_that.approvalMode,_that.advanceBookingDays,_that.minimumNoticeHours,_that.slotIntervalMinutes,_that.bufferMinutes,_that.maximumBookingsPerSlot,_that.appointmentTypes,_that.workingHours);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String venueId,  bool enabled,  String timeZone,  String approvalMode,  int advanceBookingDays,  int minimumNoticeHours,  int slotIntervalMinutes,  int bufferMinutes,  int maximumBookingsPerSlot,  List<AppointmentType> appointmentTypes,  List<WorkingHours> workingHours)  $default,) {final _that = this;
switch (_that) {
case _AppointmentConfiguration():
return $default(_that.id,_that.venueId,_that.enabled,_that.timeZone,_that.approvalMode,_that.advanceBookingDays,_that.minimumNoticeHours,_that.slotIntervalMinutes,_that.bufferMinutes,_that.maximumBookingsPerSlot,_that.appointmentTypes,_that.workingHours);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String venueId,  bool enabled,  String timeZone,  String approvalMode,  int advanceBookingDays,  int minimumNoticeHours,  int slotIntervalMinutes,  int bufferMinutes,  int maximumBookingsPerSlot,  List<AppointmentType> appointmentTypes,  List<WorkingHours> workingHours)?  $default,) {final _that = this;
switch (_that) {
case _AppointmentConfiguration() when $default != null:
return $default(_that.id,_that.venueId,_that.enabled,_that.timeZone,_that.approvalMode,_that.advanceBookingDays,_that.minimumNoticeHours,_that.slotIntervalMinutes,_that.bufferMinutes,_that.maximumBookingsPerSlot,_that.appointmentTypes,_that.workingHours);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppointmentConfiguration implements AppointmentConfiguration {
  const _AppointmentConfiguration({required this.id, required this.venueId, required this.enabled, required this.timeZone, required this.approvalMode, required this.advanceBookingDays, required this.minimumNoticeHours, required this.slotIntervalMinutes, required this.bufferMinutes, required this.maximumBookingsPerSlot, required  List<AppointmentType> appointmentTypes, required  List<WorkingHours> workingHours}): _appointmentTypes = appointmentTypes,_workingHours = workingHours;
  factory _AppointmentConfiguration.fromJson(Map<String, dynamic> json) => _$AppointmentConfigurationFromJson(json);

@override final  String id;
@override final  String venueId;
@override final  bool enabled;
@override final  String timeZone;
@override final  String approvalMode;
@override final  int advanceBookingDays;
@override final  int minimumNoticeHours;
@override final  int slotIntervalMinutes;
@override final  int bufferMinutes;
@override final  int maximumBookingsPerSlot;
 final  List<AppointmentType> _appointmentTypes;
@override List<AppointmentType> get appointmentTypes {
  if (_appointmentTypes is EqualUnmodifiableListView) return _appointmentTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_appointmentTypes);
}

 final  List<WorkingHours> _workingHours;
@override List<WorkingHours> get workingHours {
  if (_workingHours is EqualUnmodifiableListView) return _workingHours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workingHours);
}


/// Create a copy of AppointmentConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppointmentConfigurationCopyWith<_AppointmentConfiguration> get copyWith => __$AppointmentConfigurationCopyWithImpl<_AppointmentConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppointmentConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppointmentConfiguration&&(identical(other.id, id) || other.id == id)&&(identical(other.venueId, venueId) || other.venueId == venueId)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone)&&(identical(other.approvalMode, approvalMode) || other.approvalMode == approvalMode)&&(identical(other.advanceBookingDays, advanceBookingDays) || other.advanceBookingDays == advanceBookingDays)&&(identical(other.minimumNoticeHours, minimumNoticeHours) || other.minimumNoticeHours == minimumNoticeHours)&&(identical(other.slotIntervalMinutes, slotIntervalMinutes) || other.slotIntervalMinutes == slotIntervalMinutes)&&(identical(other.bufferMinutes, bufferMinutes) || other.bufferMinutes == bufferMinutes)&&(identical(other.maximumBookingsPerSlot, maximumBookingsPerSlot) || other.maximumBookingsPerSlot == maximumBookingsPerSlot)&&const DeepCollectionEquality().equals(other.appointmentTypes, _appointmentTypes)&&const DeepCollectionEquality().equals(other.workingHours, _workingHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,venueId,enabled,timeZone,approvalMode,advanceBookingDays,minimumNoticeHours,slotIntervalMinutes,bufferMinutes,maximumBookingsPerSlot,const DeepCollectionEquality().hash(_appointmentTypes),const DeepCollectionEquality().hash(_workingHours));
}

@override
String toString() {
    return 'AppointmentConfiguration(id: $id, venueId: $venueId, enabled: $enabled, timeZone: $timeZone, approvalMode: $approvalMode, advanceBookingDays: $advanceBookingDays, minimumNoticeHours: $minimumNoticeHours, slotIntervalMinutes: $slotIntervalMinutes, bufferMinutes: $bufferMinutes, maximumBookingsPerSlot: $maximumBookingsPerSlot, appointmentTypes: $appointmentTypes, workingHours: $workingHours)';
}


}

/// @nodoc
abstract mixin class _$AppointmentConfigurationCopyWith<$Res> implements $AppointmentConfigurationCopyWith<$Res> {
  factory _$AppointmentConfigurationCopyWith(_AppointmentConfiguration value, $Res Function(_AppointmentConfiguration) _then) = __$AppointmentConfigurationCopyWithImpl;
@override @useResult
$Res call({
 String id, String venueId, bool enabled, String timeZone, String approvalMode, int advanceBookingDays, int minimumNoticeHours, int slotIntervalMinutes, int bufferMinutes, int maximumBookingsPerSlot, List<AppointmentType> appointmentTypes, List<WorkingHours> workingHours
});




}
/// @nodoc
class __$AppointmentConfigurationCopyWithImpl<$Res>
    implements _$AppointmentConfigurationCopyWith<$Res> {
  __$AppointmentConfigurationCopyWithImpl(this._self, this._then);

  final _AppointmentConfiguration _self;
  final $Res Function(_AppointmentConfiguration) _then;

/// Create a copy of AppointmentConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? venueId = null,Object? enabled = null,Object? timeZone = null,Object? approvalMode = null,Object? advanceBookingDays = null,Object? minimumNoticeHours = null,Object? slotIntervalMinutes = null,Object? bufferMinutes = null,Object? maximumBookingsPerSlot = null,Object? appointmentTypes = null,Object? workingHours = null,}) {
  return _then(_AppointmentConfiguration(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,venueId: null == venueId ? _self.venueId : venueId // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,timeZone: null == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String,approvalMode: null == approvalMode ? _self.approvalMode : approvalMode // ignore: cast_nullable_to_non_nullable
as String,advanceBookingDays: null == advanceBookingDays ? _self.advanceBookingDays : advanceBookingDays // ignore: cast_nullable_to_non_nullable
as int,minimumNoticeHours: null == minimumNoticeHours ? _self.minimumNoticeHours : minimumNoticeHours // ignore: cast_nullable_to_non_nullable
as int,slotIntervalMinutes: null == slotIntervalMinutes ? _self.slotIntervalMinutes : slotIntervalMinutes // ignore: cast_nullable_to_non_nullable
as int,bufferMinutes: null == bufferMinutes ? _self.bufferMinutes : bufferMinutes // ignore: cast_nullable_to_non_nullable
as int,maximumBookingsPerSlot: null == maximumBookingsPerSlot ? _self.maximumBookingsPerSlot : maximumBookingsPerSlot // ignore: cast_nullable_to_non_nullable
as int,appointmentTypes: null == appointmentTypes ? _self._appointmentTypes : appointmentTypes // ignore: cast_nullable_to_non_nullable
as List<AppointmentType>,workingHours: null == workingHours ? _self._workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as List<WorkingHours>,
  ));
}


}

// dart format on
