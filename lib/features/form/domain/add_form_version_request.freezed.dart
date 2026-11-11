// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_form_version_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddFormVersionRequest {

 String get name; String get description; String get formType; FormVersion get sourceVersion;
/// Create a copy of AddFormVersionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddFormVersionRequestCopyWith<AddFormVersionRequest> get copyWith => _$AddFormVersionRequestCopyWithImpl<AddFormVersionRequest>(this as AddFormVersionRequest, _$identity);

  /// Serializes this AddFormVersionRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AddFormVersionRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddFormVersionRequest&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.formType, _this.formType) || other.formType == _this.formType)&&(identical(other.sourceVersion, _this.sourceVersion) || other.sourceVersion == _this.sourceVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AddFormVersionRequest;
  return Object.hash(runtimeType,_this.name,_this.description,_this.formType,_this.sourceVersion);
}

@override
String toString() {
  final _this = this as AddFormVersionRequest;
  return 'AddFormVersionRequest(name: ${_this.name}, description: ${_this.description}, formType: ${_this.formType}, sourceVersion: ${_this.sourceVersion})';
}


}

/// @nodoc
abstract mixin class $AddFormVersionRequestCopyWith<$Res>  {
  factory $AddFormVersionRequestCopyWith(AddFormVersionRequest value, $Res Function(AddFormVersionRequest) _then) = _$AddFormVersionRequestCopyWithImpl;
@useResult
$Res call({
 String name, String description, String formType, FormVersion sourceVersion
});


$FormVersionCopyWith<$Res> get sourceVersion;

}
/// @nodoc
class _$AddFormVersionRequestCopyWithImpl<$Res>
    implements $AddFormVersionRequestCopyWith<$Res> {
  _$AddFormVersionRequestCopyWithImpl(this._self, this._then);

  final AddFormVersionRequest _self;
  final $Res Function(AddFormVersionRequest) _then;

/// Create a copy of AddFormVersionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? formType = null,Object? sourceVersion = null,}) {
  return _then(AddFormVersionRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,formType: null == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as String,sourceVersion: null == sourceVersion ? _self.sourceVersion : sourceVersion // ignore: cast_nullable_to_non_nullable
as FormVersion,
  ));
}
/// Create a copy of AddFormVersionRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FormVersionCopyWith<$Res> get sourceVersion {
  
  return $FormVersionCopyWith<$Res>(_self.sourceVersion, (value) {
    return _then(_self.copyWith(sourceVersion: value));
  });
}
}


/// Adds pattern-matching-related methods to [AddFormVersionRequest].
extension AddFormVersionRequestPatterns on AddFormVersionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddFormVersionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddFormVersionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddFormVersionRequest value)  $default,){
final _that = this;
switch (_that) {
case _AddFormVersionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddFormVersionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AddFormVersionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String description,  String formType,  FormVersion sourceVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddFormVersionRequest() when $default != null:
return $default(_that.name,_that.description,_that.formType,_that.sourceVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String description,  String formType,  FormVersion sourceVersion)  $default,) {final _that = this;
switch (_that) {
case _AddFormVersionRequest():
return $default(_that.name,_that.description,_that.formType,_that.sourceVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String description,  String formType,  FormVersion sourceVersion)?  $default,) {final _that = this;
switch (_that) {
case _AddFormVersionRequest() when $default != null:
return $default(_that.name,_that.description,_that.formType,_that.sourceVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddFormVersionRequest implements AddFormVersionRequest {
  const _AddFormVersionRequest({required this.name, required this.description, required this.formType, required this.sourceVersion});
  factory _AddFormVersionRequest.fromJson(Map<String, dynamic> json) => _$AddFormVersionRequestFromJson(json);

@override final  String name;
@override final  String description;
@override final  String formType;
@override final  FormVersion sourceVersion;

/// Create a copy of AddFormVersionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddFormVersionRequestCopyWith<_AddFormVersionRequest> get copyWith => __$AddFormVersionRequestCopyWithImpl<_AddFormVersionRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddFormVersionRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddFormVersionRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.formType, formType) || other.formType == formType)&&(identical(other.sourceVersion, sourceVersion) || other.sourceVersion == sourceVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,description,formType,sourceVersion);
}

@override
String toString() {
    return 'AddFormVersionRequest(name: $name, description: $description, formType: $formType, sourceVersion: $sourceVersion)';
}


}

/// @nodoc
abstract mixin class _$AddFormVersionRequestCopyWith<$Res> implements $AddFormVersionRequestCopyWith<$Res> {
  factory _$AddFormVersionRequestCopyWith(_AddFormVersionRequest value, $Res Function(_AddFormVersionRequest) _then) = __$AddFormVersionRequestCopyWithImpl;
@override @useResult
$Res call({
 String name, String description, String formType, FormVersion sourceVersion
});


@override $FormVersionCopyWith<$Res> get sourceVersion;

}
/// @nodoc
class __$AddFormVersionRequestCopyWithImpl<$Res>
    implements _$AddFormVersionRequestCopyWith<$Res> {
  __$AddFormVersionRequestCopyWithImpl(this._self, this._then);

  final _AddFormVersionRequest _self;
  final $Res Function(_AddFormVersionRequest) _then;

/// Create a copy of AddFormVersionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? formType = null,Object? sourceVersion = null,}) {
  return _then(_AddFormVersionRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,formType: null == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as String,sourceVersion: null == sourceVersion ? _self.sourceVersion : sourceVersion // ignore: cast_nullable_to_non_nullable
as FormVersion,
  ));
}

/// Create a copy of AddFormVersionRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FormVersionCopyWith<$Res> get sourceVersion {
  
  return $FormVersionCopyWith<$Res>(_self.sourceVersion, (value) {
    return _then(_self.copyWith(sourceVersion: value));
  });
}
}

// dart format on
