// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_form_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateFormRequest {

 String get name; String? get description; String? get formType; FormSchema? get schema;
/// Create a copy of CreateFormRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateFormRequestCopyWith<CreateFormRequest> get copyWith => _$CreateFormRequestCopyWithImpl<CreateFormRequest>(this as CreateFormRequest, _$identity);

  /// Serializes this CreateFormRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreateFormRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateFormRequest&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.formType, _this.formType) || other.formType == _this.formType)&&(identical(other.schema, _this.schema) || other.schema == _this.schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreateFormRequest;
  return Object.hash(runtimeType,_this.name,_this.description,_this.formType,_this.schema);
}

@override
String toString() {
  final _this = this as CreateFormRequest;
  return 'CreateFormRequest(name: ${_this.name}, description: ${_this.description}, formType: ${_this.formType}, schema: ${_this.schema})';
}


}

/// @nodoc
abstract mixin class $CreateFormRequestCopyWith<$Res>  {
  factory $CreateFormRequestCopyWith(CreateFormRequest value, $Res Function(CreateFormRequest) _then) = _$CreateFormRequestCopyWithImpl;
@useResult
$Res call({
 String name, String? description, String? formType, FormSchema? schema
});


$FormSchemaCopyWith<$Res>? get schema;

}
/// @nodoc
class _$CreateFormRequestCopyWithImpl<$Res>
    implements $CreateFormRequestCopyWith<$Res> {
  _$CreateFormRequestCopyWithImpl(this._self, this._then);

  final CreateFormRequest _self;
  final $Res Function(CreateFormRequest) _then;

/// Create a copy of CreateFormRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = freezed,Object? formType = freezed,Object? schema = freezed,}) {
  return _then(CreateFormRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,formType: freezed == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as String?,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as FormSchema?,
  ));
}
/// Create a copy of CreateFormRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FormSchemaCopyWith<$Res>? get schema {
    if (_self.schema == null) {
    return null;
  }

  return $FormSchemaCopyWith<$Res>(_self.schema!, (value) {
    return _then(_self.copyWith(schema: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreateFormRequest].
extension CreateFormRequestPatterns on CreateFormRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateFormRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateFormRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateFormRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateFormRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateFormRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateFormRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? description,  String? formType,  FormSchema? schema)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateFormRequest() when $default != null:
return $default(_that.name,_that.description,_that.formType,_that.schema);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? description,  String? formType,  FormSchema? schema)  $default,) {final _that = this;
switch (_that) {
case _CreateFormRequest():
return $default(_that.name,_that.description,_that.formType,_that.schema);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? description,  String? formType,  FormSchema? schema)?  $default,) {final _that = this;
switch (_that) {
case _CreateFormRequest() when $default != null:
return $default(_that.name,_that.description,_that.formType,_that.schema);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateFormRequest implements CreateFormRequest {
  const _CreateFormRequest({required this.name, this.description, this.formType, this.schema});
  factory _CreateFormRequest.fromJson(Map<String, dynamic> json) => _$CreateFormRequestFromJson(json);

@override final  String name;
@override final  String? description;
@override final  String? formType;
@override final  FormSchema? schema;

/// Create a copy of CreateFormRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateFormRequestCopyWith<_CreateFormRequest> get copyWith => __$CreateFormRequestCopyWithImpl<_CreateFormRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateFormRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateFormRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.formType, formType) || other.formType == formType)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,description,formType,schema);
}

@override
String toString() {
    return 'CreateFormRequest(name: $name, description: $description, formType: $formType, schema: $schema)';
}


}

/// @nodoc
abstract mixin class _$CreateFormRequestCopyWith<$Res> implements $CreateFormRequestCopyWith<$Res> {
  factory _$CreateFormRequestCopyWith(_CreateFormRequest value, $Res Function(_CreateFormRequest) _then) = __$CreateFormRequestCopyWithImpl;
@override @useResult
$Res call({
 String name, String? description, String? formType, FormSchema? schema
});


@override $FormSchemaCopyWith<$Res>? get schema;

}
/// @nodoc
class __$CreateFormRequestCopyWithImpl<$Res>
    implements _$CreateFormRequestCopyWith<$Res> {
  __$CreateFormRequestCopyWithImpl(this._self, this._then);

  final _CreateFormRequest _self;
  final $Res Function(_CreateFormRequest) _then;

/// Create a copy of CreateFormRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = freezed,Object? formType = freezed,Object? schema = freezed,}) {
  return _then(_CreateFormRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,formType: freezed == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as String?,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as FormSchema?,
  ));
}

/// Create a copy of CreateFormRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FormSchemaCopyWith<$Res>? get schema {
    if (_self.schema == null) {
    return null;
  }

  return $FormSchemaCopyWith<$Res>(_self.schema!, (value) {
    return _then(_self.copyWith(schema: value));
  });
}
}

// dart format on
