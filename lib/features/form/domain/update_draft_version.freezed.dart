// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_draft_version.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateDraftVersion {

 String get formId; String get versionId; UpdateFormVersionRequest? get request;
/// Create a copy of UpdateDraftVersion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateDraftVersionCopyWith<UpdateDraftVersion> get copyWith => _$UpdateDraftVersionCopyWithImpl<UpdateDraftVersion>(this as UpdateDraftVersion, _$identity);

  /// Serializes this UpdateDraftVersion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UpdateDraftVersion;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateDraftVersion&&(identical(other.formId, _this.formId) || other.formId == _this.formId)&&(identical(other.versionId, _this.versionId) || other.versionId == _this.versionId)&&(identical(other.request, _this.request) || other.request == _this.request));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UpdateDraftVersion;
  return Object.hash(runtimeType,_this.formId,_this.versionId,_this.request);
}

@override
String toString() {
  final _this = this as UpdateDraftVersion;
  return 'UpdateDraftVersion(formId: ${_this.formId}, versionId: ${_this.versionId}, request: ${_this.request})';
}


}

/// @nodoc
abstract mixin class $UpdateDraftVersionCopyWith<$Res>  {
  factory $UpdateDraftVersionCopyWith(UpdateDraftVersion value, $Res Function(UpdateDraftVersion) _then) = _$UpdateDraftVersionCopyWithImpl;
@useResult
$Res call({
 String formId, String versionId, UpdateFormVersionRequest? request
});


$UpdateFormVersionRequestCopyWith<$Res>? get request;

}
/// @nodoc
class _$UpdateDraftVersionCopyWithImpl<$Res>
    implements $UpdateDraftVersionCopyWith<$Res> {
  _$UpdateDraftVersionCopyWithImpl(this._self, this._then);

  final UpdateDraftVersion _self;
  final $Res Function(UpdateDraftVersion) _then;

/// Create a copy of UpdateDraftVersion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? formId = null,Object? versionId = null,Object? request = freezed,}) {
  return _then(UpdateDraftVersion(
formId: null == formId ? _self.formId : formId // ignore: cast_nullable_to_non_nullable
as String,versionId: null == versionId ? _self.versionId : versionId // ignore: cast_nullable_to_non_nullable
as String,request: freezed == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as UpdateFormVersionRequest?,
  ));
}
/// Create a copy of UpdateDraftVersion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UpdateFormVersionRequestCopyWith<$Res>? get request {
    if (_self.request == null) {
    return null;
  }

  return $UpdateFormVersionRequestCopyWith<$Res>(_self.request!, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}


/// Adds pattern-matching-related methods to [UpdateDraftVersion].
extension UpdateDraftVersionPatterns on UpdateDraftVersion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateDraftVersion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateDraftVersion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateDraftVersion value)  $default,){
final _that = this;
switch (_that) {
case _UpdateDraftVersion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateDraftVersion value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateDraftVersion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String formId,  String versionId,  UpdateFormVersionRequest? request)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateDraftVersion() when $default != null:
return $default(_that.formId,_that.versionId,_that.request);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String formId,  String versionId,  UpdateFormVersionRequest? request)  $default,) {final _that = this;
switch (_that) {
case _UpdateDraftVersion():
return $default(_that.formId,_that.versionId,_that.request);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String formId,  String versionId,  UpdateFormVersionRequest? request)?  $default,) {final _that = this;
switch (_that) {
case _UpdateDraftVersion() when $default != null:
return $default(_that.formId,_that.versionId,_that.request);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateDraftVersion implements UpdateDraftVersion {
  const _UpdateDraftVersion({required this.formId, required this.versionId, this.request});
  factory _UpdateDraftVersion.fromJson(Map<String, dynamic> json) => _$UpdateDraftVersionFromJson(json);

@override final  String formId;
@override final  String versionId;
@override final  UpdateFormVersionRequest? request;

/// Create a copy of UpdateDraftVersion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateDraftVersionCopyWith<_UpdateDraftVersion> get copyWith => __$UpdateDraftVersionCopyWithImpl<_UpdateDraftVersion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateDraftVersionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateDraftVersion&&(identical(other.formId, formId) || other.formId == formId)&&(identical(other.versionId, versionId) || other.versionId == versionId)&&(identical(other.request, request) || other.request == request));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,formId,versionId,request);
}

@override
String toString() {
    return 'UpdateDraftVersion(formId: $formId, versionId: $versionId, request: $request)';
}


}

/// @nodoc
abstract mixin class _$UpdateDraftVersionCopyWith<$Res> implements $UpdateDraftVersionCopyWith<$Res> {
  factory _$UpdateDraftVersionCopyWith(_UpdateDraftVersion value, $Res Function(_UpdateDraftVersion) _then) = __$UpdateDraftVersionCopyWithImpl;
@override @useResult
$Res call({
 String formId, String versionId, UpdateFormVersionRequest? request
});


@override $UpdateFormVersionRequestCopyWith<$Res>? get request;

}
/// @nodoc
class __$UpdateDraftVersionCopyWithImpl<$Res>
    implements _$UpdateDraftVersionCopyWith<$Res> {
  __$UpdateDraftVersionCopyWithImpl(this._self, this._then);

  final _UpdateDraftVersion _self;
  final $Res Function(_UpdateDraftVersion) _then;

/// Create a copy of UpdateDraftVersion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? formId = null,Object? versionId = null,Object? request = freezed,}) {
  return _then(_UpdateDraftVersion(
formId: null == formId ? _self.formId : formId // ignore: cast_nullable_to_non_nullable
as String,versionId: null == versionId ? _self.versionId : versionId // ignore: cast_nullable_to_non_nullable
as String,request: freezed == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as UpdateFormVersionRequest?,
  ));
}

/// Create a copy of UpdateDraftVersion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UpdateFormVersionRequestCopyWith<$Res>? get request {
    if (_self.request == null) {
    return null;
  }

  return $UpdateFormVersionRequestCopyWith<$Res>(_self.request!, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}

// dart format on
