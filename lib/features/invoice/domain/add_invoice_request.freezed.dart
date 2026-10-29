// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_invoice_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddInvoiceRequest {

 String? get id; String get invoiceNumber; DateTime get invoiceDate; double get totalAmount; String get venueId; String get customerId; String get notes; DateTime? get createdAt; DateTime? get updatedAt; bool get isDeleted; String? get createdByUserId; String? get updatedByUserId; String? get invoiceStatus; String? get email;
/// Create a copy of AddInvoiceRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddInvoiceRequestCopyWith<AddInvoiceRequest> get copyWith => _$AddInvoiceRequestCopyWithImpl<AddInvoiceRequest>(this as AddInvoiceRequest, _$identity);

  /// Serializes this AddInvoiceRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AddInvoiceRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddInvoiceRequest&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.invoiceNumber, _this.invoiceNumber) || other.invoiceNumber == _this.invoiceNumber)&&(identical(other.invoiceDate, _this.invoiceDate) || other.invoiceDate == _this.invoiceDate)&&(identical(other.totalAmount, _this.totalAmount) || other.totalAmount == _this.totalAmount)&&(identical(other.venueId, _this.venueId) || other.venueId == _this.venueId)&&(identical(other.customerId, _this.customerId) || other.customerId == _this.customerId)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.isDeleted, _this.isDeleted) || other.isDeleted == _this.isDeleted)&&(identical(other.createdByUserId, _this.createdByUserId) || other.createdByUserId == _this.createdByUserId)&&(identical(other.updatedByUserId, _this.updatedByUserId) || other.updatedByUserId == _this.updatedByUserId)&&(identical(other.invoiceStatus, _this.invoiceStatus) || other.invoiceStatus == _this.invoiceStatus)&&(identical(other.email, _this.email) || other.email == _this.email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AddInvoiceRequest;
  return Object.hash(runtimeType,_this.id,_this.invoiceNumber,_this.invoiceDate,_this.totalAmount,_this.venueId,_this.customerId,_this.notes,_this.createdAt,_this.updatedAt,_this.isDeleted,_this.createdByUserId,_this.updatedByUserId,_this.invoiceStatus,_this.email);
}

@override
String toString() {
  final _this = this as AddInvoiceRequest;
  return 'AddInvoiceRequest(id: ${_this.id}, invoiceNumber: ${_this.invoiceNumber}, invoiceDate: ${_this.invoiceDate}, totalAmount: ${_this.totalAmount}, venueId: ${_this.venueId}, customerId: ${_this.customerId}, notes: ${_this.notes}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, isDeleted: ${_this.isDeleted}, createdByUserId: ${_this.createdByUserId}, updatedByUserId: ${_this.updatedByUserId}, invoiceStatus: ${_this.invoiceStatus}, email: ${_this.email})';
}


}

/// @nodoc
abstract mixin class $AddInvoiceRequestCopyWith<$Res>  {
  factory $AddInvoiceRequestCopyWith(AddInvoiceRequest value, $Res Function(AddInvoiceRequest) _then) = _$AddInvoiceRequestCopyWithImpl;
@useResult
$Res call({
 String? id, String invoiceNumber, DateTime invoiceDate, double totalAmount, String venueId, String customerId, String notes, DateTime? createdAt, DateTime? updatedAt, bool isDeleted, String? createdByUserId, String? updatedByUserId, String? invoiceStatus, String? email
});




}
/// @nodoc
class _$AddInvoiceRequestCopyWithImpl<$Res>
    implements $AddInvoiceRequestCopyWith<$Res> {
  _$AddInvoiceRequestCopyWithImpl(this._self, this._then);

  final AddInvoiceRequest _self;
  final $Res Function(AddInvoiceRequest) _then;

/// Create a copy of AddInvoiceRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? invoiceNumber = null,Object? invoiceDate = null,Object? totalAmount = null,Object? venueId = null,Object? customerId = null,Object? notes = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isDeleted = null,Object? createdByUserId = freezed,Object? updatedByUserId = freezed,Object? invoiceStatus = freezed,Object? email = freezed,}) {
  return _then(AddInvoiceRequest(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,invoiceNumber: null == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String,invoiceDate: null == invoiceDate ? _self.invoiceDate : invoiceDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,venueId: null == venueId ? _self.venueId : venueId // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,createdByUserId: freezed == createdByUserId ? _self.createdByUserId : createdByUserId // ignore: cast_nullable_to_non_nullable
as String?,updatedByUserId: freezed == updatedByUserId ? _self.updatedByUserId : updatedByUserId // ignore: cast_nullable_to_non_nullable
as String?,invoiceStatus: freezed == invoiceStatus ? _self.invoiceStatus : invoiceStatus // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AddInvoiceRequest].
extension AddInvoiceRequestPatterns on AddInvoiceRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddInvoiceRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddInvoiceRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddInvoiceRequest value)  $default,){
final _that = this;
switch (_that) {
case _AddInvoiceRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddInvoiceRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AddInvoiceRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String invoiceNumber,  DateTime invoiceDate,  double totalAmount,  String venueId,  String customerId,  String notes,  DateTime? createdAt,  DateTime? updatedAt,  bool isDeleted,  String? createdByUserId,  String? updatedByUserId,  String? invoiceStatus,  String? email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddInvoiceRequest() when $default != null:
return $default(_that.id,_that.invoiceNumber,_that.invoiceDate,_that.totalAmount,_that.venueId,_that.customerId,_that.notes,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.createdByUserId,_that.updatedByUserId,_that.invoiceStatus,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String invoiceNumber,  DateTime invoiceDate,  double totalAmount,  String venueId,  String customerId,  String notes,  DateTime? createdAt,  DateTime? updatedAt,  bool isDeleted,  String? createdByUserId,  String? updatedByUserId,  String? invoiceStatus,  String? email)  $default,) {final _that = this;
switch (_that) {
case _AddInvoiceRequest():
return $default(_that.id,_that.invoiceNumber,_that.invoiceDate,_that.totalAmount,_that.venueId,_that.customerId,_that.notes,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.createdByUserId,_that.updatedByUserId,_that.invoiceStatus,_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String invoiceNumber,  DateTime invoiceDate,  double totalAmount,  String venueId,  String customerId,  String notes,  DateTime? createdAt,  DateTime? updatedAt,  bool isDeleted,  String? createdByUserId,  String? updatedByUserId,  String? invoiceStatus,  String? email)?  $default,) {final _that = this;
switch (_that) {
case _AddInvoiceRequest() when $default != null:
return $default(_that.id,_that.invoiceNumber,_that.invoiceDate,_that.totalAmount,_that.venueId,_that.customerId,_that.notes,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.createdByUserId,_that.updatedByUserId,_that.invoiceStatus,_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddInvoiceRequest implements AddInvoiceRequest {
  const _AddInvoiceRequest({this.id, required this.invoiceNumber, required this.invoiceDate, required this.totalAmount, required this.venueId, required this.customerId, required this.notes, this.createdAt, this.updatedAt, required this.isDeleted, this.createdByUserId, this.updatedByUserId, this.invoiceStatus, this.email});
  factory _AddInvoiceRequest.fromJson(Map<String, dynamic> json) => _$AddInvoiceRequestFromJson(json);

@override final  String? id;
@override final  String invoiceNumber;
@override final  DateTime invoiceDate;
@override final  double totalAmount;
@override final  String venueId;
@override final  String customerId;
@override final  String notes;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override final  bool isDeleted;
@override final  String? createdByUserId;
@override final  String? updatedByUserId;
@override final  String? invoiceStatus;
@override final  String? email;

/// Create a copy of AddInvoiceRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddInvoiceRequestCopyWith<_AddInvoiceRequest> get copyWith => __$AddInvoiceRequestCopyWithImpl<_AddInvoiceRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddInvoiceRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddInvoiceRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber)&&(identical(other.invoiceDate, invoiceDate) || other.invoiceDate == invoiceDate)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.venueId, venueId) || other.venueId == venueId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.createdByUserId, createdByUserId) || other.createdByUserId == createdByUserId)&&(identical(other.updatedByUserId, updatedByUserId) || other.updatedByUserId == updatedByUserId)&&(identical(other.invoiceStatus, invoiceStatus) || other.invoiceStatus == invoiceStatus)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,invoiceNumber,invoiceDate,totalAmount,venueId,customerId,notes,createdAt,updatedAt,isDeleted,createdByUserId,updatedByUserId,invoiceStatus,email);
}

@override
String toString() {
    return 'AddInvoiceRequest(id: $id, invoiceNumber: $invoiceNumber, invoiceDate: $invoiceDate, totalAmount: $totalAmount, venueId: $venueId, customerId: $customerId, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted, createdByUserId: $createdByUserId, updatedByUserId: $updatedByUserId, invoiceStatus: $invoiceStatus, email: $email)';
}


}

/// @nodoc
abstract mixin class _$AddInvoiceRequestCopyWith<$Res> implements $AddInvoiceRequestCopyWith<$Res> {
  factory _$AddInvoiceRequestCopyWith(_AddInvoiceRequest value, $Res Function(_AddInvoiceRequest) _then) = __$AddInvoiceRequestCopyWithImpl;
@override @useResult
$Res call({
 String? id, String invoiceNumber, DateTime invoiceDate, double totalAmount, String venueId, String customerId, String notes, DateTime? createdAt, DateTime? updatedAt, bool isDeleted, String? createdByUserId, String? updatedByUserId, String? invoiceStatus, String? email
});




}
/// @nodoc
class __$AddInvoiceRequestCopyWithImpl<$Res>
    implements _$AddInvoiceRequestCopyWith<$Res> {
  __$AddInvoiceRequestCopyWithImpl(this._self, this._then);

  final _AddInvoiceRequest _self;
  final $Res Function(_AddInvoiceRequest) _then;

/// Create a copy of AddInvoiceRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? invoiceNumber = null,Object? invoiceDate = null,Object? totalAmount = null,Object? venueId = null,Object? customerId = null,Object? notes = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isDeleted = null,Object? createdByUserId = freezed,Object? updatedByUserId = freezed,Object? invoiceStatus = freezed,Object? email = freezed,}) {
  return _then(_AddInvoiceRequest(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,invoiceNumber: null == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String,invoiceDate: null == invoiceDate ? _self.invoiceDate : invoiceDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,venueId: null == venueId ? _self.venueId : venueId // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,createdByUserId: freezed == createdByUserId ? _self.createdByUserId : createdByUserId // ignore: cast_nullable_to_non_nullable
as String?,updatedByUserId: freezed == updatedByUserId ? _self.updatedByUserId : updatedByUserId // ignore: cast_nullable_to_non_nullable
as String?,invoiceStatus: freezed == invoiceStatus ? _self.invoiceStatus : invoiceStatus // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
