// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field_validation_rules.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FieldValidationRules {

 int? get minLength; int? get maxLength; String? get pattern;
/// Create a copy of FieldValidationRules
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FieldValidationRulesCopyWith<FieldValidationRules> get copyWith => _$FieldValidationRulesCopyWithImpl<FieldValidationRules>(this as FieldValidationRules, _$identity);

  /// Serializes this FieldValidationRules to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FieldValidationRules;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FieldValidationRules&&(identical(other.minLength, _this.minLength) || other.minLength == _this.minLength)&&(identical(other.maxLength, _this.maxLength) || other.maxLength == _this.maxLength)&&(identical(other.pattern, _this.pattern) || other.pattern == _this.pattern));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FieldValidationRules;
  return Object.hash(runtimeType,_this.minLength,_this.maxLength,_this.pattern);
}

@override
String toString() {
  final _this = this as FieldValidationRules;
  return 'FieldValidationRules(minLength: ${_this.minLength}, maxLength: ${_this.maxLength}, pattern: ${_this.pattern})';
}


}

/// @nodoc
abstract mixin class $FieldValidationRulesCopyWith<$Res>  {
  factory $FieldValidationRulesCopyWith(FieldValidationRules value, $Res Function(FieldValidationRules) _then) = _$FieldValidationRulesCopyWithImpl;
@useResult
$Res call({
 int? minLength, int? maxLength, String? pattern
});




}
/// @nodoc
class _$FieldValidationRulesCopyWithImpl<$Res>
    implements $FieldValidationRulesCopyWith<$Res> {
  _$FieldValidationRulesCopyWithImpl(this._self, this._then);

  final FieldValidationRules _self;
  final $Res Function(FieldValidationRules) _then;

/// Create a copy of FieldValidationRules
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minLength = freezed,Object? maxLength = freezed,Object? pattern = freezed,}) {
  return _then(FieldValidationRules(
minLength: freezed == minLength ? _self.minLength : minLength // ignore: cast_nullable_to_non_nullable
as int?,maxLength: freezed == maxLength ? _self.maxLength : maxLength // ignore: cast_nullable_to_non_nullable
as int?,pattern: freezed == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FieldValidationRules].
extension FieldValidationRulesPatterns on FieldValidationRules {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FieldValidationRules value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FieldValidationRules() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FieldValidationRules value)  $default,){
final _that = this;
switch (_that) {
case _FieldValidationRules():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FieldValidationRules value)?  $default,){
final _that = this;
switch (_that) {
case _FieldValidationRules() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? minLength,  int? maxLength,  String? pattern)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FieldValidationRules() when $default != null:
return $default(_that.minLength,_that.maxLength,_that.pattern);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? minLength,  int? maxLength,  String? pattern)  $default,) {final _that = this;
switch (_that) {
case _FieldValidationRules():
return $default(_that.minLength,_that.maxLength,_that.pattern);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? minLength,  int? maxLength,  String? pattern)?  $default,) {final _that = this;
switch (_that) {
case _FieldValidationRules() when $default != null:
return $default(_that.minLength,_that.maxLength,_that.pattern);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FieldValidationRules implements FieldValidationRules {
  const _FieldValidationRules({this.minLength, this.maxLength, this.pattern});
  factory _FieldValidationRules.fromJson(Map<String, dynamic> json) => _$FieldValidationRulesFromJson(json);

@override final  int? minLength;
@override final  int? maxLength;
@override final  String? pattern;

/// Create a copy of FieldValidationRules
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FieldValidationRulesCopyWith<_FieldValidationRules> get copyWith => __$FieldValidationRulesCopyWithImpl<_FieldValidationRules>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FieldValidationRulesToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FieldValidationRules&&(identical(other.minLength, minLength) || other.minLength == minLength)&&(identical(other.maxLength, maxLength) || other.maxLength == maxLength)&&(identical(other.pattern, pattern) || other.pattern == pattern));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,minLength,maxLength,pattern);
}

@override
String toString() {
    return 'FieldValidationRules(minLength: $minLength, maxLength: $maxLength, pattern: $pattern)';
}


}

/// @nodoc
abstract mixin class _$FieldValidationRulesCopyWith<$Res> implements $FieldValidationRulesCopyWith<$Res> {
  factory _$FieldValidationRulesCopyWith(_FieldValidationRules value, $Res Function(_FieldValidationRules) _then) = __$FieldValidationRulesCopyWithImpl;
@override @useResult
$Res call({
 int? minLength, int? maxLength, String? pattern
});




}
/// @nodoc
class __$FieldValidationRulesCopyWithImpl<$Res>
    implements _$FieldValidationRulesCopyWith<$Res> {
  __$FieldValidationRulesCopyWithImpl(this._self, this._then);

  final _FieldValidationRules _self;
  final $Res Function(_FieldValidationRules) _then;

/// Create a copy of FieldValidationRules
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minLength = freezed,Object? maxLength = freezed,Object? pattern = freezed,}) {
  return _then(_FieldValidationRules(
minLength: freezed == minLength ? _self.minLength : minLength // ignore: cast_nullable_to_non_nullable
as int?,maxLength: freezed == maxLength ? _self.maxLength : maxLength // ignore: cast_nullable_to_non_nullable
as int?,pattern: freezed == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
