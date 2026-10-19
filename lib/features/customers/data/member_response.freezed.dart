// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemberResponse {

 String get organizationId; String get userId; String get roleId; String get roleName; String get createdAtUtc;
/// Create a copy of MemberResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberResponseCopyWith<MemberResponse> get copyWith => _$MemberResponseCopyWithImpl<MemberResponse>(this as MemberResponse, _$identity);

  /// Serializes this MemberResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MemberResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberResponse&&(identical(other.organizationId, _this.organizationId) || other.organizationId == _this.organizationId)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.roleId, _this.roleId) || other.roleId == _this.roleId)&&(identical(other.roleName, _this.roleName) || other.roleName == _this.roleName)&&(identical(other.createdAtUtc, _this.createdAtUtc) || other.createdAtUtc == _this.createdAtUtc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MemberResponse;
  return Object.hash(runtimeType,_this.organizationId,_this.userId,_this.roleId,_this.roleName,_this.createdAtUtc);
}

@override
String toString() {
  final _this = this as MemberResponse;
  return 'MemberResponse(organizationId: ${_this.organizationId}, userId: ${_this.userId}, roleId: ${_this.roleId}, roleName: ${_this.roleName}, createdAtUtc: ${_this.createdAtUtc})';
}


}

/// @nodoc
abstract mixin class $MemberResponseCopyWith<$Res>  {
  factory $MemberResponseCopyWith(MemberResponse value, $Res Function(MemberResponse) _then) = _$MemberResponseCopyWithImpl;
@useResult
$Res call({
 String organizationId, String userId, String roleId, String roleName, String createdAtUtc
});




}
/// @nodoc
class _$MemberResponseCopyWithImpl<$Res>
    implements $MemberResponseCopyWith<$Res> {
  _$MemberResponseCopyWithImpl(this._self, this._then);

  final MemberResponse _self;
  final $Res Function(MemberResponse) _then;

/// Create a copy of MemberResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? organizationId = null,Object? userId = null,Object? roleId = null,Object? roleName = null,Object? createdAtUtc = null,}) {
  return _then(MemberResponse(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,roleId: null == roleId ? _self.roleId : roleId // ignore: cast_nullable_to_non_nullable
as String,roleName: null == roleName ? _self.roleName : roleName // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberResponse].
extension MemberResponsePatterns on MemberResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberResponse value)  $default,){
final _that = this;
switch (_that) {
case _MemberResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MemberResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String organizationId,  String userId,  String roleId,  String roleName,  String createdAtUtc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberResponse() when $default != null:
return $default(_that.organizationId,_that.userId,_that.roleId,_that.roleName,_that.createdAtUtc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String organizationId,  String userId,  String roleId,  String roleName,  String createdAtUtc)  $default,) {final _that = this;
switch (_that) {
case _MemberResponse():
return $default(_that.organizationId,_that.userId,_that.roleId,_that.roleName,_that.createdAtUtc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String organizationId,  String userId,  String roleId,  String roleName,  String createdAtUtc)?  $default,) {final _that = this;
switch (_that) {
case _MemberResponse() when $default != null:
return $default(_that.organizationId,_that.userId,_that.roleId,_that.roleName,_that.createdAtUtc);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberResponse implements MemberResponse {
  const _MemberResponse({required this.organizationId, required this.userId, required this.roleId, required this.roleName, required this.createdAtUtc});
  factory _MemberResponse.fromJson(Map<String, dynamic> json) => _$MemberResponseFromJson(json);

@override final  String organizationId;
@override final  String userId;
@override final  String roleId;
@override final  String roleName;
@override final  String createdAtUtc;

/// Create a copy of MemberResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberResponseCopyWith<_MemberResponse> get copyWith => __$MemberResponseCopyWithImpl<_MemberResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberResponse&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.roleId, roleId) || other.roleId == roleId)&&(identical(other.roleName, roleName) || other.roleName == roleName)&&(identical(other.createdAtUtc, createdAtUtc) || other.createdAtUtc == createdAtUtc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,organizationId,userId,roleId,roleName,createdAtUtc);
}

@override
String toString() {
    return 'MemberResponse(organizationId: $organizationId, userId: $userId, roleId: $roleId, roleName: $roleName, createdAtUtc: $createdAtUtc)';
}


}

/// @nodoc
abstract mixin class _$MemberResponseCopyWith<$Res> implements $MemberResponseCopyWith<$Res> {
  factory _$MemberResponseCopyWith(_MemberResponse value, $Res Function(_MemberResponse) _then) = __$MemberResponseCopyWithImpl;
@override @useResult
$Res call({
 String organizationId, String userId, String roleId, String roleName, String createdAtUtc
});




}
/// @nodoc
class __$MemberResponseCopyWithImpl<$Res>
    implements _$MemberResponseCopyWith<$Res> {
  __$MemberResponseCopyWithImpl(this._self, this._then);

  final _MemberResponse _self;
  final $Res Function(_MemberResponse) _then;

/// Create a copy of MemberResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? organizationId = null,Object? userId = null,Object? roleId = null,Object? roleName = null,Object? createdAtUtc = null,}) {
  return _then(_MemberResponse(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,roleId: null == roleId ? _self.roleId : roleId // ignore: cast_nullable_to_non_nullable
as String,roleName: null == roleName ? _self.roleName : roleName // ignore: cast_nullable_to_non_nullable
as String,createdAtUtc: null == createdAtUtc ? _self.createdAtUtc : createdAtUtc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
