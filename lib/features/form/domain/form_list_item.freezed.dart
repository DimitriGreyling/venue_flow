// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_list_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FormListItem {

 String get id; String get name; String? get description; String? get formType; String? get currentPublishedVersionId; DateTime? get createAt; DateTime? get updatedAt;
/// Create a copy of FormListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormListItemCopyWith<FormListItem> get copyWith => _$FormListItemCopyWithImpl<FormListItem>(this as FormListItem, _$identity);

  /// Serializes this FormListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FormListItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormListItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.formType, _this.formType) || other.formType == _this.formType)&&(identical(other.currentPublishedVersionId, _this.currentPublishedVersionId) || other.currentPublishedVersionId == _this.currentPublishedVersionId)&&(identical(other.createAt, _this.createAt) || other.createAt == _this.createAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FormListItem;
  return Object.hash(runtimeType,_this.id,_this.name,_this.description,_this.formType,_this.currentPublishedVersionId,_this.createAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as FormListItem;
  return 'FormListItem(id: ${_this.id}, name: ${_this.name}, description: ${_this.description}, formType: ${_this.formType}, currentPublishedVersionId: ${_this.currentPublishedVersionId}, createAt: ${_this.createAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $FormListItemCopyWith<$Res>  {
  factory $FormListItemCopyWith(FormListItem value, $Res Function(FormListItem) _then) = _$FormListItemCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, String? formType, String? currentPublishedVersionId, DateTime? createAt, DateTime? updatedAt
});




}
/// @nodoc
class _$FormListItemCopyWithImpl<$Res>
    implements $FormListItemCopyWith<$Res> {
  _$FormListItemCopyWithImpl(this._self, this._then);

  final FormListItem _self;
  final $Res Function(FormListItem) _then;

/// Create a copy of FormListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? formType = freezed,Object? currentPublishedVersionId = freezed,Object? createAt = freezed,Object? updatedAt = freezed,}) {
  return _then(FormListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,formType: freezed == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as String?,currentPublishedVersionId: freezed == currentPublishedVersionId ? _self.currentPublishedVersionId : currentPublishedVersionId // ignore: cast_nullable_to_non_nullable
as String?,createAt: freezed == createAt ? _self.createAt : createAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [FormListItem].
extension FormListItemPatterns on FormListItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FormListItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FormListItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FormListItem value)  $default,){
final _that = this;
switch (_that) {
case _FormListItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FormListItem value)?  $default,){
final _that = this;
switch (_that) {
case _FormListItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  String? formType,  String? currentPublishedVersionId,  DateTime? createAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FormListItem() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.formType,_that.currentPublishedVersionId,_that.createAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  String? formType,  String? currentPublishedVersionId,  DateTime? createAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _FormListItem():
return $default(_that.id,_that.name,_that.description,_that.formType,_that.currentPublishedVersionId,_that.createAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  String? formType,  String? currentPublishedVersionId,  DateTime? createAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _FormListItem() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.formType,_that.currentPublishedVersionId,_that.createAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FormListItem implements FormListItem {
  const _FormListItem({required this.id, required this.name, this.description, this.formType, this.currentPublishedVersionId, this.createAt, this.updatedAt});
  factory _FormListItem.fromJson(Map<String, dynamic> json) => _$FormListItemFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
@override final  String? formType;
@override final  String? currentPublishedVersionId;
@override final  DateTime? createAt;
@override final  DateTime? updatedAt;

/// Create a copy of FormListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormListItemCopyWith<_FormListItem> get copyWith => __$FormListItemCopyWithImpl<_FormListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormListItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.formType, formType) || other.formType == formType)&&(identical(other.currentPublishedVersionId, currentPublishedVersionId) || other.currentPublishedVersionId == currentPublishedVersionId)&&(identical(other.createAt, createAt) || other.createAt == createAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,description,formType,currentPublishedVersionId,createAt,updatedAt);
}

@override
String toString() {
    return 'FormListItem(id: $id, name: $name, description: $description, formType: $formType, currentPublishedVersionId: $currentPublishedVersionId, createAt: $createAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$FormListItemCopyWith<$Res> implements $FormListItemCopyWith<$Res> {
  factory _$FormListItemCopyWith(_FormListItem value, $Res Function(_FormListItem) _then) = __$FormListItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, String? formType, String? currentPublishedVersionId, DateTime? createAt, DateTime? updatedAt
});




}
/// @nodoc
class __$FormListItemCopyWithImpl<$Res>
    implements _$FormListItemCopyWith<$Res> {
  __$FormListItemCopyWithImpl(this._self, this._then);

  final _FormListItem _self;
  final $Res Function(_FormListItem) _then;

/// Create a copy of FormListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? formType = freezed,Object? currentPublishedVersionId = freezed,Object? createAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_FormListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,formType: freezed == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as String?,currentPublishedVersionId: freezed == currentPublishedVersionId ? _self.currentPublishedVersionId : currentPublishedVersionId // ignore: cast_nullable_to_non_nullable
as String?,createAt: freezed == createAt ? _self.createAt : createAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
