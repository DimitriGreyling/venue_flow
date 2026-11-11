// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FormDetailsModel {

 String? get name; String? get description; FormType? get type;
/// Create a copy of FormDetailsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormDetailsModelCopyWith<FormDetailsModel> get copyWith => _$FormDetailsModelCopyWithImpl<FormDetailsModel>(this as FormDetailsModel, _$identity);

  /// Serializes this FormDetailsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FormDetailsModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormDetailsModel&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.type, _this.type) || other.type == _this.type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FormDetailsModel;
  return Object.hash(runtimeType,_this.name,_this.description,_this.type);
}

@override
String toString() {
  final _this = this as FormDetailsModel;
  return 'FormDetailsModel(name: ${_this.name}, description: ${_this.description}, type: ${_this.type})';
}


}

/// @nodoc
abstract mixin class $FormDetailsModelCopyWith<$Res>  {
  factory $FormDetailsModelCopyWith(FormDetailsModel value, $Res Function(FormDetailsModel) _then) = _$FormDetailsModelCopyWithImpl;
@useResult
$Res call({
 String? name, String? description, FormType? type
});




}
/// @nodoc
class _$FormDetailsModelCopyWithImpl<$Res>
    implements $FormDetailsModelCopyWith<$Res> {
  _$FormDetailsModelCopyWithImpl(this._self, this._then);

  final FormDetailsModel _self;
  final $Res Function(FormDetailsModel) _then;

/// Create a copy of FormDetailsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? description = freezed,Object? type = freezed,}) {
  return _then(FormDetailsModel(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FormType?,
  ));
}

}


/// Adds pattern-matching-related methods to [FormDetailsModel].
extension FormDetailsModelPatterns on FormDetailsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FormDetailsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FormDetailsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FormDetailsModel value)  $default,){
final _that = this;
switch (_that) {
case _FormDetailsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FormDetailsModel value)?  $default,){
final _that = this;
switch (_that) {
case _FormDetailsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? description,  FormType? type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FormDetailsModel() when $default != null:
return $default(_that.name,_that.description,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? description,  FormType? type)  $default,) {final _that = this;
switch (_that) {
case _FormDetailsModel():
return $default(_that.name,_that.description,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? description,  FormType? type)?  $default,) {final _that = this;
switch (_that) {
case _FormDetailsModel() when $default != null:
return $default(_that.name,_that.description,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FormDetailsModel implements FormDetailsModel {
  const _FormDetailsModel({this.name, this.description, this.type});
  factory _FormDetailsModel.fromJson(Map<String, dynamic> json) => _$FormDetailsModelFromJson(json);

@override final  String? name;
@override final  String? description;
@override final  FormType? type;

/// Create a copy of FormDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormDetailsModelCopyWith<_FormDetailsModel> get copyWith => __$FormDetailsModelCopyWithImpl<_FormDetailsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormDetailsModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormDetailsModel&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,description,type);
}

@override
String toString() {
    return 'FormDetailsModel(name: $name, description: $description, type: $type)';
}


}

/// @nodoc
abstract mixin class _$FormDetailsModelCopyWith<$Res> implements $FormDetailsModelCopyWith<$Res> {
  factory _$FormDetailsModelCopyWith(_FormDetailsModel value, $Res Function(_FormDetailsModel) _then) = __$FormDetailsModelCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? description, FormType? type
});




}
/// @nodoc
class __$FormDetailsModelCopyWithImpl<$Res>
    implements _$FormDetailsModelCopyWith<$Res> {
  __$FormDetailsModelCopyWithImpl(this._self, this._then);

  final _FormDetailsModel _self;
  final $Res Function(_FormDetailsModel) _then;

/// Create a copy of FormDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? description = freezed,Object? type = freezed,}) {
  return _then(_FormDetailsModel(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FormType?,
  ));
}


}

// dart format on
