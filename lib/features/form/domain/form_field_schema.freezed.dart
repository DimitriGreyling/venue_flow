// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_field_schema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FormFieldSchema {

 String get title; FormFieldType get fieldType; String? get value; String? get hintText; int get orderNumber; bool? get isRequired; FieldValidationRules? get validationRules;
/// Create a copy of FormFieldSchema
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormFieldSchemaCopyWith<FormFieldSchema> get copyWith => _$FormFieldSchemaCopyWithImpl<FormFieldSchema>(this as FormFieldSchema, _$identity);

  /// Serializes this FormFieldSchema to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FormFieldSchema;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormFieldSchema&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.fieldType, _this.fieldType) || other.fieldType == _this.fieldType)&&(identical(other.value, _this.value) || other.value == _this.value)&&(identical(other.hintText, _this.hintText) || other.hintText == _this.hintText)&&(identical(other.orderNumber, _this.orderNumber) || other.orderNumber == _this.orderNumber)&&(identical(other.isRequired, _this.isRequired) || other.isRequired == _this.isRequired)&&(identical(other.validationRules, _this.validationRules) || other.validationRules == _this.validationRules));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FormFieldSchema;
  return Object.hash(runtimeType,_this.title,_this.fieldType,_this.value,_this.hintText,_this.orderNumber,_this.isRequired,_this.validationRules);
}

@override
String toString() {
  final _this = this as FormFieldSchema;
  return 'FormFieldSchema(title: ${_this.title}, fieldType: ${_this.fieldType}, value: ${_this.value}, hintText: ${_this.hintText}, orderNumber: ${_this.orderNumber}, isRequired: ${_this.isRequired}, validationRules: ${_this.validationRules})';
}


}

/// @nodoc
abstract mixin class $FormFieldSchemaCopyWith<$Res>  {
  factory $FormFieldSchemaCopyWith(FormFieldSchema value, $Res Function(FormFieldSchema) _then) = _$FormFieldSchemaCopyWithImpl;
@useResult
$Res call({
 String title, FormFieldType fieldType, String? value, String? hintText, int orderNumber, bool? isRequired, FieldValidationRules? validationRules
});


$FieldValidationRulesCopyWith<$Res>? get validationRules;

}
/// @nodoc
class _$FormFieldSchemaCopyWithImpl<$Res>
    implements $FormFieldSchemaCopyWith<$Res> {
  _$FormFieldSchemaCopyWithImpl(this._self, this._then);

  final FormFieldSchema _self;
  final $Res Function(FormFieldSchema) _then;

/// Create a copy of FormFieldSchema
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? fieldType = null,Object? value = freezed,Object? hintText = freezed,Object? orderNumber = null,Object? isRequired = freezed,Object? validationRules = freezed,}) {
  return _then(FormFieldSchema(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,fieldType: null == fieldType ? _self.fieldType : fieldType // ignore: cast_nullable_to_non_nullable
as FormFieldType,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,hintText: freezed == hintText ? _self.hintText : hintText // ignore: cast_nullable_to_non_nullable
as String?,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as int,isRequired: freezed == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool?,validationRules: freezed == validationRules ? _self.validationRules : validationRules // ignore: cast_nullable_to_non_nullable
as FieldValidationRules?,
  ));
}
/// Create a copy of FormFieldSchema
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldValidationRulesCopyWith<$Res>? get validationRules {
    if (_self.validationRules == null) {
    return null;
  }

  return $FieldValidationRulesCopyWith<$Res>(_self.validationRules!, (value) {
    return _then(_self.copyWith(validationRules: value));
  });
}
}


/// Adds pattern-matching-related methods to [FormFieldSchema].
extension FormFieldSchemaPatterns on FormFieldSchema {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FormFieldSchema value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FormFieldSchema() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FormFieldSchema value)  $default,){
final _that = this;
switch (_that) {
case _FormFieldSchema():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FormFieldSchema value)?  $default,){
final _that = this;
switch (_that) {
case _FormFieldSchema() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  FormFieldType fieldType,  String? value,  String? hintText,  int orderNumber,  bool? isRequired,  FieldValidationRules? validationRules)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FormFieldSchema() when $default != null:
return $default(_that.title,_that.fieldType,_that.value,_that.hintText,_that.orderNumber,_that.isRequired,_that.validationRules);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  FormFieldType fieldType,  String? value,  String? hintText,  int orderNumber,  bool? isRequired,  FieldValidationRules? validationRules)  $default,) {final _that = this;
switch (_that) {
case _FormFieldSchema():
return $default(_that.title,_that.fieldType,_that.value,_that.hintText,_that.orderNumber,_that.isRequired,_that.validationRules);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  FormFieldType fieldType,  String? value,  String? hintText,  int orderNumber,  bool? isRequired,  FieldValidationRules? validationRules)?  $default,) {final _that = this;
switch (_that) {
case _FormFieldSchema() when $default != null:
return $default(_that.title,_that.fieldType,_that.value,_that.hintText,_that.orderNumber,_that.isRequired,_that.validationRules);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FormFieldSchema implements FormFieldSchema {
  const _FormFieldSchema({required this.title, required this.fieldType, this.value, this.hintText, required this.orderNumber, this.isRequired, this.validationRules});
  factory _FormFieldSchema.fromJson(Map<String, dynamic> json) => _$FormFieldSchemaFromJson(json);

@override final  String title;
@override final  FormFieldType fieldType;
@override final  String? value;
@override final  String? hintText;
@override final  int orderNumber;
@override final  bool? isRequired;
@override final  FieldValidationRules? validationRules;

/// Create a copy of FormFieldSchema
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormFieldSchemaCopyWith<_FormFieldSchema> get copyWith => __$FormFieldSchemaCopyWithImpl<_FormFieldSchema>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormFieldSchemaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormFieldSchema&&(identical(other.title, title) || other.title == title)&&(identical(other.fieldType, fieldType) || other.fieldType == fieldType)&&(identical(other.value, value) || other.value == value)&&(identical(other.hintText, hintText) || other.hintText == hintText)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&(identical(other.validationRules, validationRules) || other.validationRules == validationRules));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,title,fieldType,value,hintText,orderNumber,isRequired,validationRules);
}

@override
String toString() {
    return 'FormFieldSchema(title: $title, fieldType: $fieldType, value: $value, hintText: $hintText, orderNumber: $orderNumber, isRequired: $isRequired, validationRules: $validationRules)';
}


}

/// @nodoc
abstract mixin class _$FormFieldSchemaCopyWith<$Res> implements $FormFieldSchemaCopyWith<$Res> {
  factory _$FormFieldSchemaCopyWith(_FormFieldSchema value, $Res Function(_FormFieldSchema) _then) = __$FormFieldSchemaCopyWithImpl;
@override @useResult
$Res call({
 String title, FormFieldType fieldType, String? value, String? hintText, int orderNumber, bool? isRequired, FieldValidationRules? validationRules
});


@override $FieldValidationRulesCopyWith<$Res>? get validationRules;

}
/// @nodoc
class __$FormFieldSchemaCopyWithImpl<$Res>
    implements _$FormFieldSchemaCopyWith<$Res> {
  __$FormFieldSchemaCopyWithImpl(this._self, this._then);

  final _FormFieldSchema _self;
  final $Res Function(_FormFieldSchema) _then;

/// Create a copy of FormFieldSchema
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? fieldType = null,Object? value = freezed,Object? hintText = freezed,Object? orderNumber = null,Object? isRequired = freezed,Object? validationRules = freezed,}) {
  return _then(_FormFieldSchema(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,fieldType: null == fieldType ? _self.fieldType : fieldType // ignore: cast_nullable_to_non_nullable
as FormFieldType,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,hintText: freezed == hintText ? _self.hintText : hintText // ignore: cast_nullable_to_non_nullable
as String?,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as int,isRequired: freezed == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool?,validationRules: freezed == validationRules ? _self.validationRules : validationRules // ignore: cast_nullable_to_non_nullable
as FieldValidationRules?,
  ));
}

/// Create a copy of FormFieldSchema
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldValidationRulesCopyWith<$Res>? get validationRules {
    if (_self.validationRules == null) {
    return null;
  }

  return $FieldValidationRulesCopyWith<$Res>(_self.validationRules!, (value) {
    return _then(_self.copyWith(validationRules: value));
  });
}
}

// dart format on
