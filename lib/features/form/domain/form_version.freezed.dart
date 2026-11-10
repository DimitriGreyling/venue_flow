// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_version.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FormVersion {

 String get id; String get formDefinitionId; int? get versionNumber; String? get status; String? get schemaJson; DateTime? get createdAt; DateTime? get updatedAt; DateTime? get submittedAt; DateTime? get reviewedAt;
/// Create a copy of FormVersion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormVersionCopyWith<FormVersion> get copyWith => _$FormVersionCopyWithImpl<FormVersion>(this as FormVersion, _$identity);

  /// Serializes this FormVersion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FormVersion;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormVersion&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.formDefinitionId, _this.formDefinitionId) || other.formDefinitionId == _this.formDefinitionId)&&(identical(other.versionNumber, _this.versionNumber) || other.versionNumber == _this.versionNumber)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.schemaJson, _this.schemaJson) || other.schemaJson == _this.schemaJson)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.submittedAt, _this.submittedAt) || other.submittedAt == _this.submittedAt)&&(identical(other.reviewedAt, _this.reviewedAt) || other.reviewedAt == _this.reviewedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FormVersion;
  return Object.hash(runtimeType,_this.id,_this.formDefinitionId,_this.versionNumber,_this.status,_this.schemaJson,_this.createdAt,_this.updatedAt,_this.submittedAt,_this.reviewedAt);
}

@override
String toString() {
  final _this = this as FormVersion;
  return 'FormVersion(id: ${_this.id}, formDefinitionId: ${_this.formDefinitionId}, versionNumber: ${_this.versionNumber}, status: ${_this.status}, schemaJson: ${_this.schemaJson}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, submittedAt: ${_this.submittedAt}, reviewedAt: ${_this.reviewedAt})';
}


}

/// @nodoc
abstract mixin class $FormVersionCopyWith<$Res>  {
  factory $FormVersionCopyWith(FormVersion value, $Res Function(FormVersion) _then) = _$FormVersionCopyWithImpl;
@useResult
$Res call({
 String id, String formDefinitionId, int? versionNumber, String? status, String? schemaJson, DateTime? createdAt, DateTime? updatedAt, DateTime? submittedAt, DateTime? reviewedAt
});




}
/// @nodoc
class _$FormVersionCopyWithImpl<$Res>
    implements $FormVersionCopyWith<$Res> {
  _$FormVersionCopyWithImpl(this._self, this._then);

  final FormVersion _self;
  final $Res Function(FormVersion) _then;

/// Create a copy of FormVersion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? formDefinitionId = null,Object? versionNumber = freezed,Object? status = freezed,Object? schemaJson = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? submittedAt = freezed,Object? reviewedAt = freezed,}) {
  return _then(FormVersion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,formDefinitionId: null == formDefinitionId ? _self.formDefinitionId : formDefinitionId // ignore: cast_nullable_to_non_nullable
as String,versionNumber: freezed == versionNumber ? _self.versionNumber : versionNumber // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,schemaJson: freezed == schemaJson ? _self.schemaJson : schemaJson // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [FormVersion].
extension FormVersionPatterns on FormVersion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FormVersion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FormVersion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FormVersion value)  $default,){
final _that = this;
switch (_that) {
case _FormVersion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FormVersion value)?  $default,){
final _that = this;
switch (_that) {
case _FormVersion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String formDefinitionId,  int? versionNumber,  String? status,  String? schemaJson,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? submittedAt,  DateTime? reviewedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FormVersion() when $default != null:
return $default(_that.id,_that.formDefinitionId,_that.versionNumber,_that.status,_that.schemaJson,_that.createdAt,_that.updatedAt,_that.submittedAt,_that.reviewedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String formDefinitionId,  int? versionNumber,  String? status,  String? schemaJson,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? submittedAt,  DateTime? reviewedAt)  $default,) {final _that = this;
switch (_that) {
case _FormVersion():
return $default(_that.id,_that.formDefinitionId,_that.versionNumber,_that.status,_that.schemaJson,_that.createdAt,_that.updatedAt,_that.submittedAt,_that.reviewedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String formDefinitionId,  int? versionNumber,  String? status,  String? schemaJson,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? submittedAt,  DateTime? reviewedAt)?  $default,) {final _that = this;
switch (_that) {
case _FormVersion() when $default != null:
return $default(_that.id,_that.formDefinitionId,_that.versionNumber,_that.status,_that.schemaJson,_that.createdAt,_that.updatedAt,_that.submittedAt,_that.reviewedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FormVersion implements FormVersion {
  const _FormVersion({required this.id, required this.formDefinitionId, this.versionNumber, this.status, this.schemaJson, this.createdAt, this.updatedAt, this.submittedAt, this.reviewedAt});
  factory _FormVersion.fromJson(Map<String, dynamic> json) => _$FormVersionFromJson(json);

@override final  String id;
@override final  String formDefinitionId;
@override final  int? versionNumber;
@override final  String? status;
@override final  String? schemaJson;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override final  DateTime? submittedAt;
@override final  DateTime? reviewedAt;

/// Create a copy of FormVersion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormVersionCopyWith<_FormVersion> get copyWith => __$FormVersionCopyWithImpl<_FormVersion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormVersionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormVersion&&(identical(other.id, id) || other.id == id)&&(identical(other.formDefinitionId, formDefinitionId) || other.formDefinitionId == formDefinitionId)&&(identical(other.versionNumber, versionNumber) || other.versionNumber == versionNumber)&&(identical(other.status, status) || other.status == status)&&(identical(other.schemaJson, schemaJson) || other.schemaJson == schemaJson)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,formDefinitionId,versionNumber,status,schemaJson,createdAt,updatedAt,submittedAt,reviewedAt);
}

@override
String toString() {
    return 'FormVersion(id: $id, formDefinitionId: $formDefinitionId, versionNumber: $versionNumber, status: $status, schemaJson: $schemaJson, createdAt: $createdAt, updatedAt: $updatedAt, submittedAt: $submittedAt, reviewedAt: $reviewedAt)';
}


}

/// @nodoc
abstract mixin class _$FormVersionCopyWith<$Res> implements $FormVersionCopyWith<$Res> {
  factory _$FormVersionCopyWith(_FormVersion value, $Res Function(_FormVersion) _then) = __$FormVersionCopyWithImpl;
@override @useResult
$Res call({
 String id, String formDefinitionId, int? versionNumber, String? status, String? schemaJson, DateTime? createdAt, DateTime? updatedAt, DateTime? submittedAt, DateTime? reviewedAt
});




}
/// @nodoc
class __$FormVersionCopyWithImpl<$Res>
    implements _$FormVersionCopyWith<$Res> {
  __$FormVersionCopyWithImpl(this._self, this._then);

  final _FormVersion _self;
  final $Res Function(_FormVersion) _then;

/// Create a copy of FormVersion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? formDefinitionId = null,Object? versionNumber = freezed,Object? status = freezed,Object? schemaJson = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? submittedAt = freezed,Object? reviewedAt = freezed,}) {
  return _then(_FormVersion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,formDefinitionId: null == formDefinitionId ? _self.formDefinitionId : formDefinitionId // ignore: cast_nullable_to_non_nullable
as String,versionNumber: freezed == versionNumber ? _self.versionNumber : versionNumber // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,schemaJson: freezed == schemaJson ? _self.schemaJson : schemaJson // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
