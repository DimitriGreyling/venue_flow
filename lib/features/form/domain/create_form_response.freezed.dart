// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_form_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateFormResponse {

 String? get id; String? get name; String? get description; String? get formType;
/// Create a copy of CreateFormResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateFormResponseCopyWith<CreateFormResponse> get copyWith => _$CreateFormResponseCopyWithImpl<CreateFormResponse>(this as CreateFormResponse, _$identity);

  /// Serializes this CreateFormResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreateFormResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateFormResponse&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.formType, _this.formType) || other.formType == _this.formType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreateFormResponse;
  return Object.hash(runtimeType,_this.id,_this.name,_this.description,_this.formType);
}

@override
String toString() {
  final _this = this as CreateFormResponse;
  return 'CreateFormResponse(id: ${_this.id}, name: ${_this.name}, description: ${_this.description}, formType: ${_this.formType})';
}


}

/// @nodoc
abstract mixin class $CreateFormResponseCopyWith<$Res>  {
  factory $CreateFormResponseCopyWith(CreateFormResponse value, $Res Function(CreateFormResponse) _then) = _$CreateFormResponseCopyWithImpl;
@useResult
$Res call({
 String? id, String? name, String? description, String? formType
});




}
/// @nodoc
class _$CreateFormResponseCopyWithImpl<$Res>
    implements $CreateFormResponseCopyWith<$Res> {
  _$CreateFormResponseCopyWithImpl(this._self, this._then);

  final CreateFormResponse _self;
  final $Res Function(CreateFormResponse) _then;

/// Create a copy of CreateFormResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,Object? description = freezed,Object? formType = freezed,}) {
  return _then(CreateFormResponse(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,formType: freezed == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateFormResponse].
extension CreateFormResponsePatterns on CreateFormResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateFormResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateFormResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateFormResponse value)  $default,){
final _that = this;
switch (_that) {
case _CreateFormResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateFormResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CreateFormResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? name,  String? description,  String? formType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateFormResponse() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.formType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? name,  String? description,  String? formType)  $default,) {final _that = this;
switch (_that) {
case _CreateFormResponse():
return $default(_that.id,_that.name,_that.description,_that.formType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? name,  String? description,  String? formType)?  $default,) {final _that = this;
switch (_that) {
case _CreateFormResponse() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.formType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateFormResponse implements CreateFormResponse {
  const _CreateFormResponse({this.id, this.name, this.description, this.formType});
  factory _CreateFormResponse.fromJson(Map<String, dynamic> json) => _$CreateFormResponseFromJson(json);

@override final  String? id;
@override final  String? name;
@override final  String? description;
@override final  String? formType;

/// Create a copy of CreateFormResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateFormResponseCopyWith<_CreateFormResponse> get copyWith => __$CreateFormResponseCopyWithImpl<_CreateFormResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateFormResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateFormResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.formType, formType) || other.formType == formType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,description,formType);
}

@override
String toString() {
    return 'CreateFormResponse(id: $id, name: $name, description: $description, formType: $formType)';
}


}

/// @nodoc
abstract mixin class _$CreateFormResponseCopyWith<$Res> implements $CreateFormResponseCopyWith<$Res> {
  factory _$CreateFormResponseCopyWith(_CreateFormResponse value, $Res Function(_CreateFormResponse) _then) = __$CreateFormResponseCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? name, String? description, String? formType
});




}
/// @nodoc
class __$CreateFormResponseCopyWithImpl<$Res>
    implements _$CreateFormResponseCopyWith<$Res> {
  __$CreateFormResponseCopyWithImpl(this._self, this._then);

  final _CreateFormResponse _self;
  final $Res Function(_CreateFormResponse) _then;

/// Create a copy of CreateFormResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,Object? description = freezed,Object? formType = freezed,}) {
  return _then(_CreateFormResponse(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,formType: freezed == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
