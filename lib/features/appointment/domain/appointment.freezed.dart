// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppointmentModel {

 String get id; String get venueId; String get venueName; String? get clientUserId; String? get coordinatorUserId; AppointmentType get type; AppointmentStatus get status; DateTime get startAtUtc; DateTime get endAtUtc; String? get clientNotes;
/// Create a copy of AppointmentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppointmentModelCopyWith<AppointmentModel> get copyWith => _$AppointmentModelCopyWithImpl<AppointmentModel>(this as AppointmentModel, _$identity);

  /// Serializes this AppointmentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AppointmentModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppointmentModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.venueId, _this.venueId) || other.venueId == _this.venueId)&&(identical(other.venueName, _this.venueName) || other.venueName == _this.venueName)&&(identical(other.clientUserId, _this.clientUserId) || other.clientUserId == _this.clientUserId)&&(identical(other.coordinatorUserId, _this.coordinatorUserId) || other.coordinatorUserId == _this.coordinatorUserId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.startAtUtc, _this.startAtUtc) || other.startAtUtc == _this.startAtUtc)&&(identical(other.endAtUtc, _this.endAtUtc) || other.endAtUtc == _this.endAtUtc)&&(identical(other.clientNotes, _this.clientNotes) || other.clientNotes == _this.clientNotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AppointmentModel;
  return Object.hash(runtimeType,_this.id,_this.venueId,_this.venueName,_this.clientUserId,_this.coordinatorUserId,_this.type,_this.status,_this.startAtUtc,_this.endAtUtc,_this.clientNotes);
}

@override
String toString() {
  final _this = this as AppointmentModel;
  return 'AppointmentModel(id: ${_this.id}, venueId: ${_this.venueId}, venueName: ${_this.venueName}, clientUserId: ${_this.clientUserId}, coordinatorUserId: ${_this.coordinatorUserId}, type: ${_this.type}, status: ${_this.status}, startAtUtc: ${_this.startAtUtc}, endAtUtc: ${_this.endAtUtc}, clientNotes: ${_this.clientNotes})';
}


}

/// @nodoc
abstract mixin class $AppointmentModelCopyWith<$Res>  {
  factory $AppointmentModelCopyWith(AppointmentModel value, $Res Function(AppointmentModel) _then) = _$AppointmentModelCopyWithImpl;
@useResult
$Res call({
 String id, String venueId, String venueName, String? clientUserId, String? coordinatorUserId, AppointmentType type, AppointmentStatus status, DateTime startAtUtc, DateTime endAtUtc, String? clientNotes
});




}
/// @nodoc
class _$AppointmentModelCopyWithImpl<$Res>
    implements $AppointmentModelCopyWith<$Res> {
  _$AppointmentModelCopyWithImpl(this._self, this._then);

  final AppointmentModel _self;
  final $Res Function(AppointmentModel) _then;

/// Create a copy of AppointmentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? venueId = null,Object? venueName = null,Object? clientUserId = freezed,Object? coordinatorUserId = freezed,Object? type = null,Object? status = null,Object? startAtUtc = null,Object? endAtUtc = null,Object? clientNotes = freezed,}) {
  return _then(AppointmentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,venueId: null == venueId ? _self.venueId : venueId // ignore: cast_nullable_to_non_nullable
as String,venueName: null == venueName ? _self.venueName : venueName // ignore: cast_nullable_to_non_nullable
as String,clientUserId: freezed == clientUserId ? _self.clientUserId : clientUserId // ignore: cast_nullable_to_non_nullable
as String?,coordinatorUserId: freezed == coordinatorUserId ? _self.coordinatorUserId : coordinatorUserId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AppointmentType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppointmentStatus,startAtUtc: null == startAtUtc ? _self.startAtUtc : startAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,endAtUtc: null == endAtUtc ? _self.endAtUtc : endAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,clientNotes: freezed == clientNotes ? _self.clientNotes : clientNotes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppointmentModel].
extension AppointmentModelPatterns on AppointmentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppointmentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppointmentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppointmentModel value)  $default,){
final _that = this;
switch (_that) {
case _AppointmentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppointmentModel value)?  $default,){
final _that = this;
switch (_that) {
case _AppointmentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String venueId,  String venueName,  String? clientUserId,  String? coordinatorUserId,  AppointmentType type,  AppointmentStatus status,  DateTime startAtUtc,  DateTime endAtUtc,  String? clientNotes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppointmentModel() when $default != null:
return $default(_that.id,_that.venueId,_that.venueName,_that.clientUserId,_that.coordinatorUserId,_that.type,_that.status,_that.startAtUtc,_that.endAtUtc,_that.clientNotes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String venueId,  String venueName,  String? clientUserId,  String? coordinatorUserId,  AppointmentType type,  AppointmentStatus status,  DateTime startAtUtc,  DateTime endAtUtc,  String? clientNotes)  $default,) {final _that = this;
switch (_that) {
case _AppointmentModel():
return $default(_that.id,_that.venueId,_that.venueName,_that.clientUserId,_that.coordinatorUserId,_that.type,_that.status,_that.startAtUtc,_that.endAtUtc,_that.clientNotes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String venueId,  String venueName,  String? clientUserId,  String? coordinatorUserId,  AppointmentType type,  AppointmentStatus status,  DateTime startAtUtc,  DateTime endAtUtc,  String? clientNotes)?  $default,) {final _that = this;
switch (_that) {
case _AppointmentModel() when $default != null:
return $default(_that.id,_that.venueId,_that.venueName,_that.clientUserId,_that.coordinatorUserId,_that.type,_that.status,_that.startAtUtc,_that.endAtUtc,_that.clientNotes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppointmentModel implements AppointmentModel {
  const _AppointmentModel({required this.id, required this.venueId, required this.venueName, this.clientUserId, this.coordinatorUserId, required this.type, required this.status, required this.startAtUtc, required this.endAtUtc, this.clientNotes});
  factory _AppointmentModel.fromJson(Map<String, dynamic> json) => _$AppointmentModelFromJson(json);

@override final  String id;
@override final  String venueId;
@override final  String venueName;
@override final  String? clientUserId;
@override final  String? coordinatorUserId;
@override final  AppointmentType type;
@override final  AppointmentStatus status;
@override final  DateTime startAtUtc;
@override final  DateTime endAtUtc;
@override final  String? clientNotes;

/// Create a copy of AppointmentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppointmentModelCopyWith<_AppointmentModel> get copyWith => __$AppointmentModelCopyWithImpl<_AppointmentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppointmentModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppointmentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.venueId, venueId) || other.venueId == venueId)&&(identical(other.venueName, venueName) || other.venueName == venueName)&&(identical(other.clientUserId, clientUserId) || other.clientUserId == clientUserId)&&(identical(other.coordinatorUserId, coordinatorUserId) || other.coordinatorUserId == coordinatorUserId)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.startAtUtc, startAtUtc) || other.startAtUtc == startAtUtc)&&(identical(other.endAtUtc, endAtUtc) || other.endAtUtc == endAtUtc)&&(identical(other.clientNotes, clientNotes) || other.clientNotes == clientNotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,venueId,venueName,clientUserId,coordinatorUserId,type,status,startAtUtc,endAtUtc,clientNotes);
}

@override
String toString() {
    return 'AppointmentModel(id: $id, venueId: $venueId, venueName: $venueName, clientUserId: $clientUserId, coordinatorUserId: $coordinatorUserId, type: $type, status: $status, startAtUtc: $startAtUtc, endAtUtc: $endAtUtc, clientNotes: $clientNotes)';
}


}

/// @nodoc
abstract mixin class _$AppointmentModelCopyWith<$Res> implements $AppointmentModelCopyWith<$Res> {
  factory _$AppointmentModelCopyWith(_AppointmentModel value, $Res Function(_AppointmentModel) _then) = __$AppointmentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String venueId, String venueName, String? clientUserId, String? coordinatorUserId, AppointmentType type, AppointmentStatus status, DateTime startAtUtc, DateTime endAtUtc, String? clientNotes
});




}
/// @nodoc
class __$AppointmentModelCopyWithImpl<$Res>
    implements _$AppointmentModelCopyWith<$Res> {
  __$AppointmentModelCopyWithImpl(this._self, this._then);

  final _AppointmentModel _self;
  final $Res Function(_AppointmentModel) _then;

/// Create a copy of AppointmentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? venueId = null,Object? venueName = null,Object? clientUserId = freezed,Object? coordinatorUserId = freezed,Object? type = null,Object? status = null,Object? startAtUtc = null,Object? endAtUtc = null,Object? clientNotes = freezed,}) {
  return _then(_AppointmentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,venueId: null == venueId ? _self.venueId : venueId // ignore: cast_nullable_to_non_nullable
as String,venueName: null == venueName ? _self.venueName : venueName // ignore: cast_nullable_to_non_nullable
as String,clientUserId: freezed == clientUserId ? _self.clientUserId : clientUserId // ignore: cast_nullable_to_non_nullable
as String?,coordinatorUserId: freezed == coordinatorUserId ? _self.coordinatorUserId : coordinatorUserId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AppointmentType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppointmentStatus,startAtUtc: null == startAtUtc ? _self.startAtUtc : startAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,endAtUtc: null == endAtUtc ? _self.endAtUtc : endAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,clientNotes: freezed == clientNotes ? _self.clientNotes : clientNotes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
