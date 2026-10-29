// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice_number_reservation_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InvoiceNumberReservationResponse {

 String get reservationId; String get invoiceNumber; DateTime get expiresAtUtc;
/// Create a copy of InvoiceNumberReservationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvoiceNumberReservationResponseCopyWith<InvoiceNumberReservationResponse> get copyWith => _$InvoiceNumberReservationResponseCopyWithImpl<InvoiceNumberReservationResponse>(this as InvoiceNumberReservationResponse, _$identity);

  /// Serializes this InvoiceNumberReservationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as InvoiceNumberReservationResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvoiceNumberReservationResponse&&(identical(other.reservationId, _this.reservationId) || other.reservationId == _this.reservationId)&&(identical(other.invoiceNumber, _this.invoiceNumber) || other.invoiceNumber == _this.invoiceNumber)&&(identical(other.expiresAtUtc, _this.expiresAtUtc) || other.expiresAtUtc == _this.expiresAtUtc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as InvoiceNumberReservationResponse;
  return Object.hash(runtimeType,_this.reservationId,_this.invoiceNumber,_this.expiresAtUtc);
}

@override
String toString() {
  final _this = this as InvoiceNumberReservationResponse;
  return 'InvoiceNumberReservationResponse(reservationId: ${_this.reservationId}, invoiceNumber: ${_this.invoiceNumber}, expiresAtUtc: ${_this.expiresAtUtc})';
}


}

/// @nodoc
abstract mixin class $InvoiceNumberReservationResponseCopyWith<$Res>  {
  factory $InvoiceNumberReservationResponseCopyWith(InvoiceNumberReservationResponse value, $Res Function(InvoiceNumberReservationResponse) _then) = _$InvoiceNumberReservationResponseCopyWithImpl;
@useResult
$Res call({
 String reservationId, String invoiceNumber, DateTime expiresAtUtc
});




}
/// @nodoc
class _$InvoiceNumberReservationResponseCopyWithImpl<$Res>
    implements $InvoiceNumberReservationResponseCopyWith<$Res> {
  _$InvoiceNumberReservationResponseCopyWithImpl(this._self, this._then);

  final InvoiceNumberReservationResponse _self;
  final $Res Function(InvoiceNumberReservationResponse) _then;

/// Create a copy of InvoiceNumberReservationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reservationId = null,Object? invoiceNumber = null,Object? expiresAtUtc = null,}) {
  return _then(InvoiceNumberReservationResponse(
reservationId: null == reservationId ? _self.reservationId : reservationId // ignore: cast_nullable_to_non_nullable
as String,invoiceNumber: null == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String,expiresAtUtc: null == expiresAtUtc ? _self.expiresAtUtc : expiresAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [InvoiceNumberReservationResponse].
extension InvoiceNumberReservationResponsePatterns on InvoiceNumberReservationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvoiceNumberReservationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvoiceNumberReservationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvoiceNumberReservationResponse value)  $default,){
final _that = this;
switch (_that) {
case _InvoiceNumberReservationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvoiceNumberReservationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _InvoiceNumberReservationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String reservationId,  String invoiceNumber,  DateTime expiresAtUtc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvoiceNumberReservationResponse() when $default != null:
return $default(_that.reservationId,_that.invoiceNumber,_that.expiresAtUtc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String reservationId,  String invoiceNumber,  DateTime expiresAtUtc)  $default,) {final _that = this;
switch (_that) {
case _InvoiceNumberReservationResponse():
return $default(_that.reservationId,_that.invoiceNumber,_that.expiresAtUtc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String reservationId,  String invoiceNumber,  DateTime expiresAtUtc)?  $default,) {final _that = this;
switch (_that) {
case _InvoiceNumberReservationResponse() when $default != null:
return $default(_that.reservationId,_that.invoiceNumber,_that.expiresAtUtc);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InvoiceNumberReservationResponse implements InvoiceNumberReservationResponse {
  const _InvoiceNumberReservationResponse({required this.reservationId, required this.invoiceNumber, required this.expiresAtUtc});
  factory _InvoiceNumberReservationResponse.fromJson(Map<String, dynamic> json) => _$InvoiceNumberReservationResponseFromJson(json);

@override final  String reservationId;
@override final  String invoiceNumber;
@override final  DateTime expiresAtUtc;

/// Create a copy of InvoiceNumberReservationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvoiceNumberReservationResponseCopyWith<_InvoiceNumberReservationResponse> get copyWith => __$InvoiceNumberReservationResponseCopyWithImpl<_InvoiceNumberReservationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvoiceNumberReservationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvoiceNumberReservationResponse&&(identical(other.reservationId, reservationId) || other.reservationId == reservationId)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber)&&(identical(other.expiresAtUtc, expiresAtUtc) || other.expiresAtUtc == expiresAtUtc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,reservationId,invoiceNumber,expiresAtUtc);
}

@override
String toString() {
    return 'InvoiceNumberReservationResponse(reservationId: $reservationId, invoiceNumber: $invoiceNumber, expiresAtUtc: $expiresAtUtc)';
}


}

/// @nodoc
abstract mixin class _$InvoiceNumberReservationResponseCopyWith<$Res> implements $InvoiceNumberReservationResponseCopyWith<$Res> {
  factory _$InvoiceNumberReservationResponseCopyWith(_InvoiceNumberReservationResponse value, $Res Function(_InvoiceNumberReservationResponse) _then) = __$InvoiceNumberReservationResponseCopyWithImpl;
@override @useResult
$Res call({
 String reservationId, String invoiceNumber, DateTime expiresAtUtc
});




}
/// @nodoc
class __$InvoiceNumberReservationResponseCopyWithImpl<$Res>
    implements _$InvoiceNumberReservationResponseCopyWith<$Res> {
  __$InvoiceNumberReservationResponseCopyWithImpl(this._self, this._then);

  final _InvoiceNumberReservationResponse _self;
  final $Res Function(_InvoiceNumberReservationResponse) _then;

/// Create a copy of InvoiceNumberReservationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reservationId = null,Object? invoiceNumber = null,Object? expiresAtUtc = null,}) {
  return _then(_InvoiceNumberReservationResponse(
reservationId: null == reservationId ? _self.reservationId : reservationId // ignore: cast_nullable_to_non_nullable
as String,invoiceNumber: null == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String,expiresAtUtc: null == expiresAtUtc ? _self.expiresAtUtc : expiresAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
