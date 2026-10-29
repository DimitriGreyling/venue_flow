// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_schema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FormSchema {

 int get version; List<FormPageSchema> get pages;
/// Create a copy of FormSchema
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormSchemaCopyWith<FormSchema> get copyWith => _$FormSchemaCopyWithImpl<FormSchema>(this as FormSchema, _$identity);

  /// Serializes this FormSchema to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FormSchema;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormSchema&&(identical(other.version, _this.version) || other.version == _this.version)&&const DeepCollectionEquality().equals(other.pages, _this.pages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FormSchema;
  return Object.hash(runtimeType,_this.version,const DeepCollectionEquality().hash(_this.pages));
}

@override
String toString() {
  final _this = this as FormSchema;
  return 'FormSchema(version: ${_this.version}, pages: ${_this.pages})';
}


}

/// @nodoc
abstract mixin class $FormSchemaCopyWith<$Res>  {
  factory $FormSchemaCopyWith(FormSchema value, $Res Function(FormSchema) _then) = _$FormSchemaCopyWithImpl;
@useResult
$Res call({
 int version, List<FormPageSchema> pages
});




}
/// @nodoc
class _$FormSchemaCopyWithImpl<$Res>
    implements $FormSchemaCopyWith<$Res> {
  _$FormSchemaCopyWithImpl(this._self, this._then);

  final FormSchema _self;
  final $Res Function(FormSchema) _then;

/// Create a copy of FormSchema
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? pages = null,}) {
  return _then(FormSchema(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,pages: null == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as List<FormPageSchema>,
  ));
}

}


/// Adds pattern-matching-related methods to [FormSchema].
extension FormSchemaPatterns on FormSchema {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FormSchema value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FormSchema() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FormSchema value)  $default,){
final _that = this;
switch (_that) {
case _FormSchema():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FormSchema value)?  $default,){
final _that = this;
switch (_that) {
case _FormSchema() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int version,  List<FormPageSchema> pages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FormSchema() when $default != null:
return $default(_that.version,_that.pages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int version,  List<FormPageSchema> pages)  $default,) {final _that = this;
switch (_that) {
case _FormSchema():
return $default(_that.version,_that.pages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int version,  List<FormPageSchema> pages)?  $default,) {final _that = this;
switch (_that) {
case _FormSchema() when $default != null:
return $default(_that.version,_that.pages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FormSchema implements FormSchema {
  const _FormSchema({this.version = 1,  List<FormPageSchema> pages = const []}): _pages = pages;
  factory _FormSchema.fromJson(Map<String, dynamic> json) => _$FormSchemaFromJson(json);

@override@JsonKey() final  int version;
 final  List<FormPageSchema> _pages;
@override@JsonKey() List<FormPageSchema> get pages {
  if (_pages is EqualUnmodifiableListView) return _pages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pages);
}


/// Create a copy of FormSchema
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormSchemaCopyWith<_FormSchema> get copyWith => __$FormSchemaCopyWithImpl<_FormSchema>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormSchemaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormSchema&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other.pages, _pages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,version,const DeepCollectionEquality().hash(_pages));
}

@override
String toString() {
    return 'FormSchema(version: $version, pages: $pages)';
}


}

/// @nodoc
abstract mixin class _$FormSchemaCopyWith<$Res> implements $FormSchemaCopyWith<$Res> {
  factory _$FormSchemaCopyWith(_FormSchema value, $Res Function(_FormSchema) _then) = __$FormSchemaCopyWithImpl;
@override @useResult
$Res call({
 int version, List<FormPageSchema> pages
});




}
/// @nodoc
class __$FormSchemaCopyWithImpl<$Res>
    implements _$FormSchemaCopyWith<$Res> {
  __$FormSchemaCopyWithImpl(this._self, this._then);

  final _FormSchema _self;
  final $Res Function(_FormSchema) _then;

/// Create a copy of FormSchema
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? pages = null,}) {
  return _then(_FormSchema(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,pages: null == pages ? _self._pages : pages // ignore: cast_nullable_to_non_nullable
as List<FormPageSchema>,
  ));
}


}

// dart format on
