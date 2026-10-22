// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_venue_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateVenueRequest {

 String get name; String? get description; String? get venueType; String get addressLine1; String? get addressLine2; String get suburb; String get city; String get province; String? get postalCode; String get country; int? get minimumCapacity; int? get maximumCapacity; String? get contactName; String? get contactEmail; String? get contactPhone; String? get orgId;
/// Create a copy of CreateVenueRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateVenueRequestCopyWith<CreateVenueRequest> get copyWith => _$CreateVenueRequestCopyWithImpl<CreateVenueRequest>(this as CreateVenueRequest, _$identity);

  /// Serializes this CreateVenueRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreateVenueRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateVenueRequest&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.venueType, _this.venueType) || other.venueType == _this.venueType)&&(identical(other.addressLine1, _this.addressLine1) || other.addressLine1 == _this.addressLine1)&&(identical(other.addressLine2, _this.addressLine2) || other.addressLine2 == _this.addressLine2)&&(identical(other.suburb, _this.suburb) || other.suburb == _this.suburb)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.province, _this.province) || other.province == _this.province)&&(identical(other.postalCode, _this.postalCode) || other.postalCode == _this.postalCode)&&(identical(other.country, _this.country) || other.country == _this.country)&&(identical(other.minimumCapacity, _this.minimumCapacity) || other.minimumCapacity == _this.minimumCapacity)&&(identical(other.maximumCapacity, _this.maximumCapacity) || other.maximumCapacity == _this.maximumCapacity)&&(identical(other.contactName, _this.contactName) || other.contactName == _this.contactName)&&(identical(other.contactEmail, _this.contactEmail) || other.contactEmail == _this.contactEmail)&&(identical(other.contactPhone, _this.contactPhone) || other.contactPhone == _this.contactPhone)&&(identical(other.orgId, _this.orgId) || other.orgId == _this.orgId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreateVenueRequest;
  return Object.hash(runtimeType,_this.name,_this.description,_this.venueType,_this.addressLine1,_this.addressLine2,_this.suburb,_this.city,_this.province,_this.postalCode,_this.country,_this.minimumCapacity,_this.maximumCapacity,_this.contactName,_this.contactEmail,_this.contactPhone,_this.orgId);
}

@override
String toString() {
  final _this = this as CreateVenueRequest;
  return 'CreateVenueRequest(name: ${_this.name}, description: ${_this.description}, venueType: ${_this.venueType}, addressLine1: ${_this.addressLine1}, addressLine2: ${_this.addressLine2}, suburb: ${_this.suburb}, city: ${_this.city}, province: ${_this.province}, postalCode: ${_this.postalCode}, country: ${_this.country}, minimumCapacity: ${_this.minimumCapacity}, maximumCapacity: ${_this.maximumCapacity}, contactName: ${_this.contactName}, contactEmail: ${_this.contactEmail}, contactPhone: ${_this.contactPhone}, orgId: ${_this.orgId})';
}


}

/// @nodoc
abstract mixin class $CreateVenueRequestCopyWith<$Res>  {
  factory $CreateVenueRequestCopyWith(CreateVenueRequest value, $Res Function(CreateVenueRequest) _then) = _$CreateVenueRequestCopyWithImpl;
@useResult
$Res call({
 String name, String? description, String? venueType, String addressLine1, String? addressLine2, String suburb, String city, String province, String? postalCode, String country, int? minimumCapacity, int? maximumCapacity, String? contactName, String? contactEmail, String? contactPhone, String? orgId
});




}
/// @nodoc
class _$CreateVenueRequestCopyWithImpl<$Res>
    implements $CreateVenueRequestCopyWith<$Res> {
  _$CreateVenueRequestCopyWithImpl(this._self, this._then);

  final CreateVenueRequest _self;
  final $Res Function(CreateVenueRequest) _then;

/// Create a copy of CreateVenueRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = freezed,Object? venueType = freezed,Object? addressLine1 = null,Object? addressLine2 = freezed,Object? suburb = null,Object? city = null,Object? province = null,Object? postalCode = freezed,Object? country = null,Object? minimumCapacity = freezed,Object? maximumCapacity = freezed,Object? contactName = freezed,Object? contactEmail = freezed,Object? contactPhone = freezed,Object? orgId = freezed,}) {
  return _then(CreateVenueRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,venueType: freezed == venueType ? _self.venueType : venueType // ignore: cast_nullable_to_non_nullable
as String?,addressLine1: null == addressLine1 ? _self.addressLine1 : addressLine1 // ignore: cast_nullable_to_non_nullable
as String,addressLine2: freezed == addressLine2 ? _self.addressLine2 : addressLine2 // ignore: cast_nullable_to_non_nullable
as String?,suburb: null == suburb ? _self.suburb : suburb // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,minimumCapacity: freezed == minimumCapacity ? _self.minimumCapacity : minimumCapacity // ignore: cast_nullable_to_non_nullable
as int?,maximumCapacity: freezed == maximumCapacity ? _self.maximumCapacity : maximumCapacity // ignore: cast_nullable_to_non_nullable
as int?,contactName: freezed == contactName ? _self.contactName : contactName // ignore: cast_nullable_to_non_nullable
as String?,contactEmail: freezed == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String?,contactPhone: freezed == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String?,orgId: freezed == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateVenueRequest].
extension CreateVenueRequestPatterns on CreateVenueRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateVenueRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateVenueRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateVenueRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateVenueRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateVenueRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateVenueRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? description,  String? venueType,  String addressLine1,  String? addressLine2,  String suburb,  String city,  String province,  String? postalCode,  String country,  int? minimumCapacity,  int? maximumCapacity,  String? contactName,  String? contactEmail,  String? contactPhone,  String? orgId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateVenueRequest() when $default != null:
return $default(_that.name,_that.description,_that.venueType,_that.addressLine1,_that.addressLine2,_that.suburb,_that.city,_that.province,_that.postalCode,_that.country,_that.minimumCapacity,_that.maximumCapacity,_that.contactName,_that.contactEmail,_that.contactPhone,_that.orgId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? description,  String? venueType,  String addressLine1,  String? addressLine2,  String suburb,  String city,  String province,  String? postalCode,  String country,  int? minimumCapacity,  int? maximumCapacity,  String? contactName,  String? contactEmail,  String? contactPhone,  String? orgId)  $default,) {final _that = this;
switch (_that) {
case _CreateVenueRequest():
return $default(_that.name,_that.description,_that.venueType,_that.addressLine1,_that.addressLine2,_that.suburb,_that.city,_that.province,_that.postalCode,_that.country,_that.minimumCapacity,_that.maximumCapacity,_that.contactName,_that.contactEmail,_that.contactPhone,_that.orgId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? description,  String? venueType,  String addressLine1,  String? addressLine2,  String suburb,  String city,  String province,  String? postalCode,  String country,  int? minimumCapacity,  int? maximumCapacity,  String? contactName,  String? contactEmail,  String? contactPhone,  String? orgId)?  $default,) {final _that = this;
switch (_that) {
case _CreateVenueRequest() when $default != null:
return $default(_that.name,_that.description,_that.venueType,_that.addressLine1,_that.addressLine2,_that.suburb,_that.city,_that.province,_that.postalCode,_that.country,_that.minimumCapacity,_that.maximumCapacity,_that.contactName,_that.contactEmail,_that.contactPhone,_that.orgId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateVenueRequest implements CreateVenueRequest {
  const _CreateVenueRequest({required this.name, this.description, this.venueType, required this.addressLine1, this.addressLine2, required this.suburb, required this.city, required this.province, this.postalCode, required this.country, this.minimumCapacity, this.maximumCapacity, this.contactName, this.contactEmail, this.contactPhone, this.orgId});
  factory _CreateVenueRequest.fromJson(Map<String, dynamic> json) => _$CreateVenueRequestFromJson(json);

@override final  String name;
@override final  String? description;
@override final  String? venueType;
@override final  String addressLine1;
@override final  String? addressLine2;
@override final  String suburb;
@override final  String city;
@override final  String province;
@override final  String? postalCode;
@override final  String country;
@override final  int? minimumCapacity;
@override final  int? maximumCapacity;
@override final  String? contactName;
@override final  String? contactEmail;
@override final  String? contactPhone;
@override final  String? orgId;

/// Create a copy of CreateVenueRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateVenueRequestCopyWith<_CreateVenueRequest> get copyWith => __$CreateVenueRequestCopyWithImpl<_CreateVenueRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateVenueRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateVenueRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.venueType, venueType) || other.venueType == venueType)&&(identical(other.addressLine1, addressLine1) || other.addressLine1 == addressLine1)&&(identical(other.addressLine2, addressLine2) || other.addressLine2 == addressLine2)&&(identical(other.suburb, suburb) || other.suburb == suburb)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.country, country) || other.country == country)&&(identical(other.minimumCapacity, minimumCapacity) || other.minimumCapacity == minimumCapacity)&&(identical(other.maximumCapacity, maximumCapacity) || other.maximumCapacity == maximumCapacity)&&(identical(other.contactName, contactName) || other.contactName == contactName)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&(identical(other.orgId, orgId) || other.orgId == orgId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,description,venueType,addressLine1,addressLine2,suburb,city,province,postalCode,country,minimumCapacity,maximumCapacity,contactName,contactEmail,contactPhone,orgId);
}

@override
String toString() {
    return 'CreateVenueRequest(name: $name, description: $description, venueType: $venueType, addressLine1: $addressLine1, addressLine2: $addressLine2, suburb: $suburb, city: $city, province: $province, postalCode: $postalCode, country: $country, minimumCapacity: $minimumCapacity, maximumCapacity: $maximumCapacity, contactName: $contactName, contactEmail: $contactEmail, contactPhone: $contactPhone, orgId: $orgId)';
}


}

/// @nodoc
abstract mixin class _$CreateVenueRequestCopyWith<$Res> implements $CreateVenueRequestCopyWith<$Res> {
  factory _$CreateVenueRequestCopyWith(_CreateVenueRequest value, $Res Function(_CreateVenueRequest) _then) = __$CreateVenueRequestCopyWithImpl;
@override @useResult
$Res call({
 String name, String? description, String? venueType, String addressLine1, String? addressLine2, String suburb, String city, String province, String? postalCode, String country, int? minimumCapacity, int? maximumCapacity, String? contactName, String? contactEmail, String? contactPhone, String? orgId
});




}
/// @nodoc
class __$CreateVenueRequestCopyWithImpl<$Res>
    implements _$CreateVenueRequestCopyWith<$Res> {
  __$CreateVenueRequestCopyWithImpl(this._self, this._then);

  final _CreateVenueRequest _self;
  final $Res Function(_CreateVenueRequest) _then;

/// Create a copy of CreateVenueRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = freezed,Object? venueType = freezed,Object? addressLine1 = null,Object? addressLine2 = freezed,Object? suburb = null,Object? city = null,Object? province = null,Object? postalCode = freezed,Object? country = null,Object? minimumCapacity = freezed,Object? maximumCapacity = freezed,Object? contactName = freezed,Object? contactEmail = freezed,Object? contactPhone = freezed,Object? orgId = freezed,}) {
  return _then(_CreateVenueRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,venueType: freezed == venueType ? _self.venueType : venueType // ignore: cast_nullable_to_non_nullable
as String?,addressLine1: null == addressLine1 ? _self.addressLine1 : addressLine1 // ignore: cast_nullable_to_non_nullable
as String,addressLine2: freezed == addressLine2 ? _self.addressLine2 : addressLine2 // ignore: cast_nullable_to_non_nullable
as String?,suburb: null == suburb ? _self.suburb : suburb // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,minimumCapacity: freezed == minimumCapacity ? _self.minimumCapacity : minimumCapacity // ignore: cast_nullable_to_non_nullable
as int?,maximumCapacity: freezed == maximumCapacity ? _self.maximumCapacity : maximumCapacity // ignore: cast_nullable_to_non_nullable
as int?,contactName: freezed == contactName ? _self.contactName : contactName // ignore: cast_nullable_to_non_nullable
as String?,contactEmail: freezed == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String?,contactPhone: freezed == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String?,orgId: freezed == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
