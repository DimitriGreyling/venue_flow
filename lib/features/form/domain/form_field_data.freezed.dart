// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_field_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FormFieldData {

@IconDataConverter() IconData? get leadingIcon; String? get title; String? get subtitle;@IconDataConverter() IconData? get trailingIcon; String? get trailingTooltip; FormFieldType? get fieldType;
/// Create a copy of FormFieldData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormFieldDataCopyWith<FormFieldData> get copyWith => _$FormFieldDataCopyWithImpl<FormFieldData>(this as FormFieldData, _$identity);

  /// Serializes this FormFieldData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FormFieldData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormFieldData&&(identical(other.leadingIcon, _this.leadingIcon) || other.leadingIcon == _this.leadingIcon)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.subtitle, _this.subtitle) || other.subtitle == _this.subtitle)&&(identical(other.trailingIcon, _this.trailingIcon) || other.trailingIcon == _this.trailingIcon)&&(identical(other.trailingTooltip, _this.trailingTooltip) || other.trailingTooltip == _this.trailingTooltip)&&(identical(other.fieldType, _this.fieldType) || other.fieldType == _this.fieldType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FormFieldData;
  return Object.hash(runtimeType,_this.leadingIcon,_this.title,_this.subtitle,_this.trailingIcon,_this.trailingTooltip,_this.fieldType);
}

@override
String toString() {
  final _this = this as FormFieldData;
  return 'FormFieldData(leadingIcon: ${_this.leadingIcon}, title: ${_this.title}, subtitle: ${_this.subtitle}, trailingIcon: ${_this.trailingIcon}, trailingTooltip: ${_this.trailingTooltip}, fieldType: ${_this.fieldType})';
}


}

/// @nodoc
abstract mixin class $FormFieldDataCopyWith<$Res>  {
  factory $FormFieldDataCopyWith(FormFieldData value, $Res Function(FormFieldData) _then) = _$FormFieldDataCopyWithImpl;
@useResult
$Res call({
@IconDataConverter() IconData? leadingIcon, String? title, String? subtitle,@IconDataConverter() IconData? trailingIcon, String? trailingTooltip, FormFieldType? fieldType
});




}
/// @nodoc
class _$FormFieldDataCopyWithImpl<$Res>
    implements $FormFieldDataCopyWith<$Res> {
  _$FormFieldDataCopyWithImpl(this._self, this._then);

  final FormFieldData _self;
  final $Res Function(FormFieldData) _then;

/// Create a copy of FormFieldData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leadingIcon = freezed,Object? title = freezed,Object? subtitle = freezed,Object? trailingIcon = freezed,Object? trailingTooltip = freezed,Object? fieldType = freezed,}) {
  return _then(FormFieldData(
leadingIcon: freezed == leadingIcon ? _self.leadingIcon : leadingIcon // ignore: cast_nullable_to_non_nullable
as IconData?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,trailingIcon: freezed == trailingIcon ? _self.trailingIcon : trailingIcon // ignore: cast_nullable_to_non_nullable
as IconData?,trailingTooltip: freezed == trailingTooltip ? _self.trailingTooltip : trailingTooltip // ignore: cast_nullable_to_non_nullable
as String?,fieldType: freezed == fieldType ? _self.fieldType : fieldType // ignore: cast_nullable_to_non_nullable
as FormFieldType?,
  ));
}

}


/// Adds pattern-matching-related methods to [FormFieldData].
extension FormFieldDataPatterns on FormFieldData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FormFieldData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FormFieldData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FormFieldData value)  $default,){
final _that = this;
switch (_that) {
case _FormFieldData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FormFieldData value)?  $default,){
final _that = this;
switch (_that) {
case _FormFieldData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IconDataConverter()  IconData? leadingIcon,  String? title,  String? subtitle, @IconDataConverter()  IconData? trailingIcon,  String? trailingTooltip,  FormFieldType? fieldType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FormFieldData() when $default != null:
return $default(_that.leadingIcon,_that.title,_that.subtitle,_that.trailingIcon,_that.trailingTooltip,_that.fieldType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IconDataConverter()  IconData? leadingIcon,  String? title,  String? subtitle, @IconDataConverter()  IconData? trailingIcon,  String? trailingTooltip,  FormFieldType? fieldType)  $default,) {final _that = this;
switch (_that) {
case _FormFieldData():
return $default(_that.leadingIcon,_that.title,_that.subtitle,_that.trailingIcon,_that.trailingTooltip,_that.fieldType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IconDataConverter()  IconData? leadingIcon,  String? title,  String? subtitle, @IconDataConverter()  IconData? trailingIcon,  String? trailingTooltip,  FormFieldType? fieldType)?  $default,) {final _that = this;
switch (_that) {
case _FormFieldData() when $default != null:
return $default(_that.leadingIcon,_that.title,_that.subtitle,_that.trailingIcon,_that.trailingTooltip,_that.fieldType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FormFieldData implements FormFieldData {
  const _FormFieldData({@IconDataConverter() this.leadingIcon, this.title, this.subtitle, @IconDataConverter() this.trailingIcon, this.trailingTooltip, this.fieldType});
  factory _FormFieldData.fromJson(Map<String, dynamic> json) => _$FormFieldDataFromJson(json);

@override@IconDataConverter() final  IconData? leadingIcon;
@override final  String? title;
@override final  String? subtitle;
@override@IconDataConverter() final  IconData? trailingIcon;
@override final  String? trailingTooltip;
@override final  FormFieldType? fieldType;

/// Create a copy of FormFieldData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormFieldDataCopyWith<_FormFieldData> get copyWith => __$FormFieldDataCopyWithImpl<_FormFieldData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormFieldDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormFieldData&&(identical(other.leadingIcon, leadingIcon) || other.leadingIcon == leadingIcon)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.trailingIcon, trailingIcon) || other.trailingIcon == trailingIcon)&&(identical(other.trailingTooltip, trailingTooltip) || other.trailingTooltip == trailingTooltip)&&(identical(other.fieldType, fieldType) || other.fieldType == fieldType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,leadingIcon,title,subtitle,trailingIcon,trailingTooltip,fieldType);
}

@override
String toString() {
    return 'FormFieldData(leadingIcon: $leadingIcon, title: $title, subtitle: $subtitle, trailingIcon: $trailingIcon, trailingTooltip: $trailingTooltip, fieldType: $fieldType)';
}


}

/// @nodoc
abstract mixin class _$FormFieldDataCopyWith<$Res> implements $FormFieldDataCopyWith<$Res> {
  factory _$FormFieldDataCopyWith(_FormFieldData value, $Res Function(_FormFieldData) _then) = __$FormFieldDataCopyWithImpl;
@override @useResult
$Res call({
@IconDataConverter() IconData? leadingIcon, String? title, String? subtitle,@IconDataConverter() IconData? trailingIcon, String? trailingTooltip, FormFieldType? fieldType
});




}
/// @nodoc
class __$FormFieldDataCopyWithImpl<$Res>
    implements _$FormFieldDataCopyWith<$Res> {
  __$FormFieldDataCopyWithImpl(this._self, this._then);

  final _FormFieldData _self;
  final $Res Function(_FormFieldData) _then;

/// Create a copy of FormFieldData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leadingIcon = freezed,Object? title = freezed,Object? subtitle = freezed,Object? trailingIcon = freezed,Object? trailingTooltip = freezed,Object? fieldType = freezed,}) {
  return _then(_FormFieldData(
leadingIcon: freezed == leadingIcon ? _self.leadingIcon : leadingIcon // ignore: cast_nullable_to_non_nullable
as IconData?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,trailingIcon: freezed == trailingIcon ? _self.trailingIcon : trailingIcon // ignore: cast_nullable_to_non_nullable
as IconData?,trailingTooltip: freezed == trailingTooltip ? _self.trailingTooltip : trailingTooltip // ignore: cast_nullable_to_non_nullable
as String?,fieldType: freezed == fieldType ? _self.fieldType : fieldType // ignore: cast_nullable_to_non_nullable
as FormFieldType?,
  ));
}


}

// dart format on
