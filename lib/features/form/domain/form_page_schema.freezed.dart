// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_page_schema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FormPageSchema {

 String get id; String get title; String? get description; int get orderNumber; List<FormFieldSchema> get fields;
/// Create a copy of FormPageSchema
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormPageSchemaCopyWith<FormPageSchema> get copyWith => _$FormPageSchemaCopyWithImpl<FormPageSchema>(this as FormPageSchema, _$identity);

  /// Serializes this FormPageSchema to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FormPageSchema;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormPageSchema&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.orderNumber, _this.orderNumber) || other.orderNumber == _this.orderNumber)&&const DeepCollectionEquality().equals(other.fields, _this.fields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FormPageSchema;
  return Object.hash(runtimeType,_this.id,_this.title,_this.description,_this.orderNumber,const DeepCollectionEquality().hash(_this.fields));
}

@override
String toString() {
  final _this = this as FormPageSchema;
  return 'FormPageSchema(id: ${_this.id}, title: ${_this.title}, description: ${_this.description}, orderNumber: ${_this.orderNumber}, fields: ${_this.fields})';
}


}

/// @nodoc
abstract mixin class $FormPageSchemaCopyWith<$Res>  {
  factory $FormPageSchemaCopyWith(FormPageSchema value, $Res Function(FormPageSchema) _then) = _$FormPageSchemaCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description, int orderNumber, List<FormFieldSchema> fields
});




}
/// @nodoc
class _$FormPageSchemaCopyWithImpl<$Res>
    implements $FormPageSchemaCopyWith<$Res> {
  _$FormPageSchemaCopyWithImpl(this._self, this._then);

  final FormPageSchema _self;
  final $Res Function(FormPageSchema) _then;

/// Create a copy of FormPageSchema
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? orderNumber = null,Object? fields = null,}) {
  return _then(FormPageSchema(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as int,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as List<FormFieldSchema>,
  ));
}

}


/// Adds pattern-matching-related methods to [FormPageSchema].
extension FormPageSchemaPatterns on FormPageSchema {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FormPageSchema value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FormPageSchema() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FormPageSchema value)  $default,){
final _that = this;
switch (_that) {
case _FormPageSchema():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FormPageSchema value)?  $default,){
final _that = this;
switch (_that) {
case _FormPageSchema() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  int orderNumber,  List<FormFieldSchema> fields)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FormPageSchema() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.orderNumber,_that.fields);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  int orderNumber,  List<FormFieldSchema> fields)  $default,) {final _that = this;
switch (_that) {
case _FormPageSchema():
return $default(_that.id,_that.title,_that.description,_that.orderNumber,_that.fields);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? description,  int orderNumber,  List<FormFieldSchema> fields)?  $default,) {final _that = this;
switch (_that) {
case _FormPageSchema() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.orderNumber,_that.fields);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FormPageSchema implements FormPageSchema {
  const _FormPageSchema({required this.id, required this.title, this.description, this.orderNumber = 0,  List<FormFieldSchema> fields = const []}): _fields = fields;
  factory _FormPageSchema.fromJson(Map<String, dynamic> json) => _$FormPageSchemaFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? description;
@override@JsonKey() final  int orderNumber;
 final  List<FormFieldSchema> _fields;
@override@JsonKey() List<FormFieldSchema> get fields {
  if (_fields is EqualUnmodifiableListView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fields);
}


/// Create a copy of FormPageSchema
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormPageSchemaCopyWith<_FormPageSchema> get copyWith => __$FormPageSchemaCopyWithImpl<_FormPageSchema>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormPageSchemaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormPageSchema&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&const DeepCollectionEquality().equals(other.fields, _fields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,description,orderNumber,const DeepCollectionEquality().hash(_fields));
}

@override
String toString() {
    return 'FormPageSchema(id: $id, title: $title, description: $description, orderNumber: $orderNumber, fields: $fields)';
}


}

/// @nodoc
abstract mixin class _$FormPageSchemaCopyWith<$Res> implements $FormPageSchemaCopyWith<$Res> {
  factory _$FormPageSchemaCopyWith(_FormPageSchema value, $Res Function(_FormPageSchema) _then) = __$FormPageSchemaCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description, int orderNumber, List<FormFieldSchema> fields
});




}
/// @nodoc
class __$FormPageSchemaCopyWithImpl<$Res>
    implements _$FormPageSchemaCopyWith<$Res> {
  __$FormPageSchemaCopyWithImpl(this._self, this._then);

  final _FormPageSchema _self;
  final $Res Function(_FormPageSchema) _then;

/// Create a copy of FormPageSchema
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? orderNumber = null,Object? fields = null,}) {
  return _then(_FormPageSchema(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as int,fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as List<FormFieldSchema>,
  ));
}


}

// dart format on
