// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'link_customer_to_org.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LinkCustomerToOrg {

 String get roleId; String get userId;
/// Create a copy of LinkCustomerToOrg
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LinkCustomerToOrgCopyWith<LinkCustomerToOrg> get copyWith => _$LinkCustomerToOrgCopyWithImpl<LinkCustomerToOrg>(this as LinkCustomerToOrg, _$identity);

  /// Serializes this LinkCustomerToOrg to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LinkCustomerToOrg;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LinkCustomerToOrg&&(identical(other.roleId, _this.roleId) || other.roleId == _this.roleId)&&(identical(other.userId, _this.userId) || other.userId == _this.userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LinkCustomerToOrg;
  return Object.hash(runtimeType,_this.roleId,_this.userId);
}

@override
String toString() {
  final _this = this as LinkCustomerToOrg;
  return 'LinkCustomerToOrg(roleId: ${_this.roleId}, userId: ${_this.userId})';
}


}

/// @nodoc
abstract mixin class $LinkCustomerToOrgCopyWith<$Res>  {
  factory $LinkCustomerToOrgCopyWith(LinkCustomerToOrg value, $Res Function(LinkCustomerToOrg) _then) = _$LinkCustomerToOrgCopyWithImpl;
@useResult
$Res call({
 String roleId, String userId
});




}
/// @nodoc
class _$LinkCustomerToOrgCopyWithImpl<$Res>
    implements $LinkCustomerToOrgCopyWith<$Res> {
  _$LinkCustomerToOrgCopyWithImpl(this._self, this._then);

  final LinkCustomerToOrg _self;
  final $Res Function(LinkCustomerToOrg) _then;

/// Create a copy of LinkCustomerToOrg
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roleId = null,Object? userId = null,}) {
  return _then(LinkCustomerToOrg(
roleId: null == roleId ? _self.roleId : roleId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LinkCustomerToOrg].
extension LinkCustomerToOrgPatterns on LinkCustomerToOrg {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LinkCustomerToOrg value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LinkCustomerToOrg() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LinkCustomerToOrg value)  $default,){
final _that = this;
switch (_that) {
case _LinkCustomerToOrg():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LinkCustomerToOrg value)?  $default,){
final _that = this;
switch (_that) {
case _LinkCustomerToOrg() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String roleId,  String userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LinkCustomerToOrg() when $default != null:
return $default(_that.roleId,_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String roleId,  String userId)  $default,) {final _that = this;
switch (_that) {
case _LinkCustomerToOrg():
return $default(_that.roleId,_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String roleId,  String userId)?  $default,) {final _that = this;
switch (_that) {
case _LinkCustomerToOrg() when $default != null:
return $default(_that.roleId,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LinkCustomerToOrg implements LinkCustomerToOrg {
  const _LinkCustomerToOrg({required this.roleId, required this.userId});
  factory _LinkCustomerToOrg.fromJson(Map<String, dynamic> json) => _$LinkCustomerToOrgFromJson(json);

@override final  String roleId;
@override final  String userId;

/// Create a copy of LinkCustomerToOrg
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LinkCustomerToOrgCopyWith<_LinkCustomerToOrg> get copyWith => __$LinkCustomerToOrgCopyWithImpl<_LinkCustomerToOrg>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LinkCustomerToOrgToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LinkCustomerToOrg&&(identical(other.roleId, roleId) || other.roleId == roleId)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,roleId,userId);
}

@override
String toString() {
    return 'LinkCustomerToOrg(roleId: $roleId, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$LinkCustomerToOrgCopyWith<$Res> implements $LinkCustomerToOrgCopyWith<$Res> {
  factory _$LinkCustomerToOrgCopyWith(_LinkCustomerToOrg value, $Res Function(_LinkCustomerToOrg) _then) = __$LinkCustomerToOrgCopyWithImpl;
@override @useResult
$Res call({
 String roleId, String userId
});




}
/// @nodoc
class __$LinkCustomerToOrgCopyWithImpl<$Res>
    implements _$LinkCustomerToOrgCopyWith<$Res> {
  __$LinkCustomerToOrgCopyWithImpl(this._self, this._then);

  final _LinkCustomerToOrg _self;
  final $Res Function(_LinkCustomerToOrg) _then;

/// Create a copy of LinkCustomerToOrg
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roleId = null,Object? userId = null,}) {
  return _then(_LinkCustomerToOrg(
roleId: null == roleId ? _self.roleId : roleId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
