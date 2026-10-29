// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_invoice_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListInvoiceResponse {

 String get invoiceId;
/// Create a copy of ListInvoiceResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListInvoiceResponseCopyWith<ListInvoiceResponse> get copyWith => _$ListInvoiceResponseCopyWithImpl<ListInvoiceResponse>(this as ListInvoiceResponse, _$identity);

  /// Serializes this ListInvoiceResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ListInvoiceResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListInvoiceResponse&&(identical(other.invoiceId, _this.invoiceId) || other.invoiceId == _this.invoiceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ListInvoiceResponse;
  return Object.hash(runtimeType,_this.invoiceId);
}

@override
String toString() {
  final _this = this as ListInvoiceResponse;
  return 'ListInvoiceResponse(invoiceId: ${_this.invoiceId})';
}


}

/// @nodoc
abstract mixin class $ListInvoiceResponseCopyWith<$Res>  {
  factory $ListInvoiceResponseCopyWith(ListInvoiceResponse value, $Res Function(ListInvoiceResponse) _then) = _$ListInvoiceResponseCopyWithImpl;
@useResult
$Res call({
 String invoiceId
});




}
/// @nodoc
class _$ListInvoiceResponseCopyWithImpl<$Res>
    implements $ListInvoiceResponseCopyWith<$Res> {
  _$ListInvoiceResponseCopyWithImpl(this._self, this._then);

  final ListInvoiceResponse _self;
  final $Res Function(ListInvoiceResponse) _then;

/// Create a copy of ListInvoiceResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? invoiceId = null,}) {
  return _then(ListInvoiceResponse(
invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ListInvoiceResponse].
extension ListInvoiceResponsePatterns on ListInvoiceResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListInvoiceResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListInvoiceResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListInvoiceResponse value)  $default,){
final _that = this;
switch (_that) {
case _ListInvoiceResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListInvoiceResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ListInvoiceResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String invoiceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListInvoiceResponse() when $default != null:
return $default(_that.invoiceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String invoiceId)  $default,) {final _that = this;
switch (_that) {
case _ListInvoiceResponse():
return $default(_that.invoiceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String invoiceId)?  $default,) {final _that = this;
switch (_that) {
case _ListInvoiceResponse() when $default != null:
return $default(_that.invoiceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListInvoiceResponse implements ListInvoiceResponse {
  const _ListInvoiceResponse({required this.invoiceId});
  factory _ListInvoiceResponse.fromJson(Map<String, dynamic> json) => _$ListInvoiceResponseFromJson(json);

@override final  String invoiceId;

/// Create a copy of ListInvoiceResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListInvoiceResponseCopyWith<_ListInvoiceResponse> get copyWith => __$ListInvoiceResponseCopyWithImpl<_ListInvoiceResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListInvoiceResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListInvoiceResponse&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,invoiceId);
}

@override
String toString() {
    return 'ListInvoiceResponse(invoiceId: $invoiceId)';
}


}

/// @nodoc
abstract mixin class _$ListInvoiceResponseCopyWith<$Res> implements $ListInvoiceResponseCopyWith<$Res> {
  factory _$ListInvoiceResponseCopyWith(_ListInvoiceResponse value, $Res Function(_ListInvoiceResponse) _then) = __$ListInvoiceResponseCopyWithImpl;
@override @useResult
$Res call({
 String invoiceId
});




}
/// @nodoc
class __$ListInvoiceResponseCopyWithImpl<$Res>
    implements _$ListInvoiceResponseCopyWith<$Res> {
  __$ListInvoiceResponseCopyWithImpl(this._self, this._then);

  final _ListInvoiceResponse _self;
  final $Res Function(_ListInvoiceResponse) _then;

/// Create a copy of ListInvoiceResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? invoiceId = null,}) {
  return _then(_ListInvoiceResponse(
invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
