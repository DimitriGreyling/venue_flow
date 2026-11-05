// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'icon_feature.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IconFeature {

 String get name; int get codePoint; String? get fontFamily; String get icon; String get iconType;
/// Create a copy of IconFeature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IconFeatureCopyWith<IconFeature> get copyWith => _$IconFeatureCopyWithImpl<IconFeature>(this as IconFeature, _$identity);

  /// Serializes this IconFeature to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as IconFeature;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IconFeature&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.codePoint, _this.codePoint) || other.codePoint == _this.codePoint)&&(identical(other.fontFamily, _this.fontFamily) || other.fontFamily == _this.fontFamily)&&(identical(other.icon, _this.icon) || other.icon == _this.icon)&&(identical(other.iconType, _this.iconType) || other.iconType == _this.iconType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as IconFeature;
  return Object.hash(runtimeType,_this.name,_this.codePoint,_this.fontFamily,_this.icon,_this.iconType);
}

@override
String toString() {
  final _this = this as IconFeature;
  return 'IconFeature(name: ${_this.name}, codePoint: ${_this.codePoint}, fontFamily: ${_this.fontFamily}, icon: ${_this.icon}, iconType: ${_this.iconType})';
}


}

/// @nodoc
abstract mixin class $IconFeatureCopyWith<$Res>  {
  factory $IconFeatureCopyWith(IconFeature value, $Res Function(IconFeature) _then) = _$IconFeatureCopyWithImpl;
@useResult
$Res call({
 String name, int codePoint, String? fontFamily, String icon, String iconType
});




}
/// @nodoc
class _$IconFeatureCopyWithImpl<$Res>
    implements $IconFeatureCopyWith<$Res> {
  _$IconFeatureCopyWithImpl(this._self, this._then);

  final IconFeature _self;
  final $Res Function(IconFeature) _then;

/// Create a copy of IconFeature
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? codePoint = null,Object? fontFamily = freezed,Object? icon = null,Object? iconType = null,}) {
  return _then(IconFeature(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,codePoint: null == codePoint ? _self.codePoint : codePoint // ignore: cast_nullable_to_non_nullable
as int,fontFamily: freezed == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as String?,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,iconType: null == iconType ? _self.iconType : iconType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [IconFeature].
extension IconFeaturePatterns on IconFeature {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IconFeature value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IconFeature() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IconFeature value)  $default,){
final _that = this;
switch (_that) {
case _IconFeature():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IconFeature value)?  $default,){
final _that = this;
switch (_that) {
case _IconFeature() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int codePoint,  String? fontFamily,  String icon,  String iconType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IconFeature() when $default != null:
return $default(_that.name,_that.codePoint,_that.fontFamily,_that.icon,_that.iconType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int codePoint,  String? fontFamily,  String icon,  String iconType)  $default,) {final _that = this;
switch (_that) {
case _IconFeature():
return $default(_that.name,_that.codePoint,_that.fontFamily,_that.icon,_that.iconType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int codePoint,  String? fontFamily,  String icon,  String iconType)?  $default,) {final _that = this;
switch (_that) {
case _IconFeature() when $default != null:
return $default(_that.name,_that.codePoint,_that.fontFamily,_that.icon,_that.iconType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IconFeature implements IconFeature {
  const _IconFeature({required this.name, required this.codePoint, this.fontFamily, required this.icon, required this.iconType});
  factory _IconFeature.fromJson(Map<String, dynamic> json) => _$IconFeatureFromJson(json);

@override final  String name;
@override final  int codePoint;
@override final  String? fontFamily;
@override final  String icon;
@override final  String iconType;

/// Create a copy of IconFeature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IconFeatureCopyWith<_IconFeature> get copyWith => __$IconFeatureCopyWithImpl<_IconFeature>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IconFeatureToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _IconFeature&&(identical(other.name, name) || other.name == name)&&(identical(other.codePoint, codePoint) || other.codePoint == codePoint)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.iconType, iconType) || other.iconType == iconType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,codePoint,fontFamily,icon,iconType);
}

@override
String toString() {
    return 'IconFeature(name: $name, codePoint: $codePoint, fontFamily: $fontFamily, icon: $icon, iconType: $iconType)';
}


}

/// @nodoc
abstract mixin class _$IconFeatureCopyWith<$Res> implements $IconFeatureCopyWith<$Res> {
  factory _$IconFeatureCopyWith(_IconFeature value, $Res Function(_IconFeature) _then) = __$IconFeatureCopyWithImpl;
@override @useResult
$Res call({
 String name, int codePoint, String? fontFamily, String icon, String iconType
});




}
/// @nodoc
class __$IconFeatureCopyWithImpl<$Res>
    implements _$IconFeatureCopyWith<$Res> {
  __$IconFeatureCopyWithImpl(this._self, this._then);

  final _IconFeature _self;
  final $Res Function(_IconFeature) _then;

/// Create a copy of IconFeature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? codePoint = null,Object? fontFamily = freezed,Object? icon = null,Object? iconType = null,}) {
  return _then(_IconFeature(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,codePoint: null == codePoint ? _self.codePoint : codePoint // ignore: cast_nullable_to_non_nullable
as int,fontFamily: freezed == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as String?,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,iconType: null == iconType ? _self.iconType : iconType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
