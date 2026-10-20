// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegisterCustomer {

 String get firstName; String get lastName; String get email; String? get password;
/// Create a copy of RegisterCustomer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterCustomerCopyWith<RegisterCustomer> get copyWith => _$RegisterCustomerCopyWithImpl<RegisterCustomer>(this as RegisterCustomer, _$identity);

  /// Serializes this RegisterCustomer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RegisterCustomer;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterCustomer&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.password, _this.password) || other.password == _this.password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RegisterCustomer;
  return Object.hash(runtimeType,_this.firstName,_this.lastName,_this.email,_this.password);
}

@override
String toString() {
  final _this = this as RegisterCustomer;
  return 'RegisterCustomer(firstName: ${_this.firstName}, lastName: ${_this.lastName}, email: ${_this.email}, password: ${_this.password})';
}


}

/// @nodoc
abstract mixin class $RegisterCustomerCopyWith<$Res>  {
  factory $RegisterCustomerCopyWith(RegisterCustomer value, $Res Function(RegisterCustomer) _then) = _$RegisterCustomerCopyWithImpl;
@useResult
$Res call({
 String firstName, String lastName, String email, String? password
});




}
/// @nodoc
class _$RegisterCustomerCopyWithImpl<$Res>
    implements $RegisterCustomerCopyWith<$Res> {
  _$RegisterCustomerCopyWithImpl(this._self, this._then);

  final RegisterCustomer _self;
  final $Res Function(RegisterCustomer) _then;

/// Create a copy of RegisterCustomer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = null,Object? lastName = null,Object? email = null,Object? password = freezed,}) {
  return _then(RegisterCustomer(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterCustomer].
extension RegisterCustomerPatterns on RegisterCustomer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterCustomer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterCustomer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterCustomer value)  $default,){
final _that = this;
switch (_that) {
case _RegisterCustomer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterCustomer value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterCustomer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String email,  String? password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterCustomer() when $default != null:
return $default(_that.firstName,_that.lastName,_that.email,_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String email,  String? password)  $default,) {final _that = this;
switch (_that) {
case _RegisterCustomer():
return $default(_that.firstName,_that.lastName,_that.email,_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String firstName,  String lastName,  String email,  String? password)?  $default,) {final _that = this;
switch (_that) {
case _RegisterCustomer() when $default != null:
return $default(_that.firstName,_that.lastName,_that.email,_that.password);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisterCustomer implements RegisterCustomer {
  const _RegisterCustomer({required this.firstName, required this.lastName, required this.email, this.password});
  factory _RegisterCustomer.fromJson(Map<String, dynamic> json) => _$RegisterCustomerFromJson(json);

@override final  String firstName;
@override final  String lastName;
@override final  String email;
@override final  String? password;

/// Create a copy of RegisterCustomer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterCustomerCopyWith<_RegisterCustomer> get copyWith => __$RegisterCustomerCopyWithImpl<_RegisterCustomer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterCustomerToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterCustomer&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,firstName,lastName,email,password);
}

@override
String toString() {
    return 'RegisterCustomer(firstName: $firstName, lastName: $lastName, email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$RegisterCustomerCopyWith<$Res> implements $RegisterCustomerCopyWith<$Res> {
  factory _$RegisterCustomerCopyWith(_RegisterCustomer value, $Res Function(_RegisterCustomer) _then) = __$RegisterCustomerCopyWithImpl;
@override @useResult
$Res call({
 String firstName, String lastName, String email, String? password
});




}
/// @nodoc
class __$RegisterCustomerCopyWithImpl<$Res>
    implements _$RegisterCustomerCopyWith<$Res> {
  __$RegisterCustomerCopyWithImpl(this._self, this._then);

  final _RegisterCustomer _self;
  final $Res Function(_RegisterCustomer) _then;

/// Create a copy of RegisterCustomer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? lastName = null,Object? email = null,Object? password = freezed,}) {
  return _then(_RegisterCustomer(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
