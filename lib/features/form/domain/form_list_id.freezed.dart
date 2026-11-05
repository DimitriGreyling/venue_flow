// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_list_id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FormListId {

 String get id;
/// Create a copy of FormListId
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormListIdCopyWith<FormListId> get copyWith => _$FormListIdCopyWithImpl<FormListId>(this as FormListId, _$identity);

  /// Serializes this FormListId to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FormListId;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormListId&&(identical(other.id, _this.id) || other.id == _this.id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FormListId;
  return Object.hash(runtimeType,_this.id);
}

@override
String toString() {
  final _this = this as FormListId;
  return 'FormListId(id: ${_this.id})';
}


}

/// @nodoc
abstract mixin class $FormListIdCopyWith<$Res>  {
  factory $FormListIdCopyWith(FormListId value, $Res Function(FormListId) _then) = _$FormListIdCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$FormListIdCopyWithImpl<$Res>
    implements $FormListIdCopyWith<$Res> {
  _$FormListIdCopyWithImpl(this._self, this._then);

  final FormListId _self;
  final $Res Function(FormListId) _then;

/// Create a copy of FormListId
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(FormListId(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FormListId].
extension FormListIdPatterns on FormListId {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FormListId value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FormListId() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FormListId value)  $default,){
final _that = this;
switch (_that) {
case _FormListId():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FormListId value)?  $default,){
final _that = this;
switch (_that) {
case _FormListId() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FormListId() when $default != null:
return $default(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id)  $default,) {final _that = this;
switch (_that) {
case _FormListId():
return $default(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id)?  $default,) {final _that = this;
switch (_that) {
case _FormListId() when $default != null:
return $default(_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FormListId implements FormListId {
  const _FormListId({required this.id});
  factory _FormListId.fromJson(Map<String, dynamic> json) => _$FormListIdFromJson(json);

@override final  String id;

/// Create a copy of FormListId
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormListIdCopyWith<_FormListId> get copyWith => __$FormListIdCopyWithImpl<_FormListId>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormListIdToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormListId&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id);
}

@override
String toString() {
    return 'FormListId(id: $id)';
}


}

/// @nodoc
abstract mixin class _$FormListIdCopyWith<$Res> implements $FormListIdCopyWith<$Res> {
  factory _$FormListIdCopyWith(_FormListId value, $Res Function(_FormListId) _then) = __$FormListIdCopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class __$FormListIdCopyWithImpl<$Res>
    implements _$FormListIdCopyWith<$Res> {
  __$FormListIdCopyWithImpl(this._self, this._then);

  final _FormListId _self;
  final $Res Function(_FormListId) _then;

/// Create a copy of FormListId
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_FormListId(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
