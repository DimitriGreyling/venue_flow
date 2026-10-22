// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'venue_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VenueResponse {

 String get id; String get name; String? get description; String? get venueType; String get addressLine1; String? get addressLine2; String get suburb; String get city; String get province; String? get postalCode; String get country; int? get minimumCapacity; int? get maximumCapacity; String? get contactName; String? get contactEmail; String? get contactPhone; bool get isPublished; bool get isActive;
/// Create a copy of VenueResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VenueResponseCopyWith<VenueResponse> get copyWith => _$VenueResponseCopyWithImpl<VenueResponse>(this as VenueResponse, _$identity);

  /// Serializes this VenueResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VenueResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VenueResponse&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.venueType, _this.venueType) || other.venueType == _this.venueType)&&(identical(other.addressLine1, _this.addressLine1) || other.addressLine1 == _this.addressLine1)&&(identical(other.addressLine2, _this.addressLine2) || other.addressLine2 == _this.addressLine2)&&(identical(other.suburb, _this.suburb) || other.suburb == _this.suburb)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.province, _this.province) || other.province == _this.province)&&(identical(other.postalCode, _this.postalCode) || other.postalCode == _this.postalCode)&&(identical(other.country, _this.country) || other.country == _this.country)&&(identical(other.minimumCapacity, _this.minimumCapacity) || other.minimumCapacity == _this.minimumCapacity)&&(identical(other.maximumCapacity, _this.maximumCapacity) || other.maximumCapacity == _this.maximumCapacity)&&(identical(other.contactName, _this.contactName) || other.contactName == _this.contactName)&&(identical(other.contactEmail, _this.contactEmail) || other.contactEmail == _this.contactEmail)&&(identical(other.contactPhone, _this.contactPhone) || other.contactPhone == _this.contactPhone)&&(identical(other.isPublished, _this.isPublished) || other.isPublished == _this.isPublished)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VenueResponse;
  return Object.hash(runtimeType,_this.id,_this.name,_this.description,_this.venueType,_this.addressLine1,_this.addressLine2,_this.suburb,_this.city,_this.province,_this.postalCode,_this.country,_this.minimumCapacity,_this.maximumCapacity,_this.contactName,_this.contactEmail,_this.contactPhone,_this.isPublished,_this.isActive);
}

@override
String toString() {
  final _this = this as VenueResponse;
  return 'VenueResponse(id: ${_this.id}, name: ${_this.name}, description: ${_this.description}, venueType: ${_this.venueType}, addressLine1: ${_this.addressLine1}, addressLine2: ${_this.addressLine2}, suburb: ${_this.suburb}, city: ${_this.city}, province: ${_this.province}, postalCode: ${_this.postalCode}, country: ${_this.country}, minimumCapacity: ${_this.minimumCapacity}, maximumCapacity: ${_this.maximumCapacity}, contactName: ${_this.contactName}, contactEmail: ${_this.contactEmail}, contactPhone: ${_this.contactPhone}, isPublished: ${_this.isPublished}, isActive: ${_this.isActive})';
}


}

/// @nodoc
abstract mixin class $VenueResponseCopyWith<$Res>  {
  factory $VenueResponseCopyWith(VenueResponse value, $Res Function(VenueResponse) _then) = _$VenueResponseCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, String? venueType, String addressLine1, String? addressLine2, String suburb, String city, String province, String? postalCode, String country, int? minimumCapacity, int? maximumCapacity, String? contactName, String? contactEmail, String? contactPhone, bool isPublished, bool isActive
});




}
/// @nodoc
class _$VenueResponseCopyWithImpl<$Res>
    implements $VenueResponseCopyWith<$Res> {
  _$VenueResponseCopyWithImpl(this._self, this._then);

  final VenueResponse _self;
  final $Res Function(VenueResponse) _then;

/// Create a copy of VenueResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? venueType = freezed,Object? addressLine1 = null,Object? addressLine2 = freezed,Object? suburb = null,Object? city = null,Object? province = null,Object? postalCode = freezed,Object? country = null,Object? minimumCapacity = freezed,Object? maximumCapacity = freezed,Object? contactName = freezed,Object? contactEmail = freezed,Object? contactPhone = freezed,Object? isPublished = null,Object? isActive = null,}) {
  return _then(VenueResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
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
as String?,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VenueResponse].
extension VenueResponsePatterns on VenueResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VenueResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VenueResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VenueResponse value)  $default,){
final _that = this;
switch (_that) {
case _VenueResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VenueResponse value)?  $default,){
final _that = this;
switch (_that) {
case _VenueResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  String? venueType,  String addressLine1,  String? addressLine2,  String suburb,  String city,  String province,  String? postalCode,  String country,  int? minimumCapacity,  int? maximumCapacity,  String? contactName,  String? contactEmail,  String? contactPhone,  bool isPublished,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VenueResponse() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.venueType,_that.addressLine1,_that.addressLine2,_that.suburb,_that.city,_that.province,_that.postalCode,_that.country,_that.minimumCapacity,_that.maximumCapacity,_that.contactName,_that.contactEmail,_that.contactPhone,_that.isPublished,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  String? venueType,  String addressLine1,  String? addressLine2,  String suburb,  String city,  String province,  String? postalCode,  String country,  int? minimumCapacity,  int? maximumCapacity,  String? contactName,  String? contactEmail,  String? contactPhone,  bool isPublished,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _VenueResponse():
return $default(_that.id,_that.name,_that.description,_that.venueType,_that.addressLine1,_that.addressLine2,_that.suburb,_that.city,_that.province,_that.postalCode,_that.country,_that.minimumCapacity,_that.maximumCapacity,_that.contactName,_that.contactEmail,_that.contactPhone,_that.isPublished,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  String? venueType,  String addressLine1,  String? addressLine2,  String suburb,  String city,  String province,  String? postalCode,  String country,  int? minimumCapacity,  int? maximumCapacity,  String? contactName,  String? contactEmail,  String? contactPhone,  bool isPublished,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _VenueResponse() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.venueType,_that.addressLine1,_that.addressLine2,_that.suburb,_that.city,_that.province,_that.postalCode,_that.country,_that.minimumCapacity,_that.maximumCapacity,_that.contactName,_that.contactEmail,_that.contactPhone,_that.isPublished,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VenueResponse implements VenueResponse {
  const _VenueResponse({required this.id, required this.name, this.description, this.venueType, required this.addressLine1, this.addressLine2, required this.suburb, required this.city, required this.province, this.postalCode, required this.country, this.minimumCapacity, this.maximumCapacity, this.contactName, this.contactEmail, this.contactPhone, required this.isPublished, required this.isActive});
  factory _VenueResponse.fromJson(Map<String, dynamic> json) => _$VenueResponseFromJson(json);

@override final  String id;
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
@override final  bool isPublished;
@override final  bool isActive;

/// Create a copy of VenueResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VenueResponseCopyWith<_VenueResponse> get copyWith => __$VenueResponseCopyWithImpl<_VenueResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VenueResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VenueResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.venueType, venueType) || other.venueType == venueType)&&(identical(other.addressLine1, addressLine1) || other.addressLine1 == addressLine1)&&(identical(other.addressLine2, addressLine2) || other.addressLine2 == addressLine2)&&(identical(other.suburb, suburb) || other.suburb == suburb)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.country, country) || other.country == country)&&(identical(other.minimumCapacity, minimumCapacity) || other.minimumCapacity == minimumCapacity)&&(identical(other.maximumCapacity, maximumCapacity) || other.maximumCapacity == maximumCapacity)&&(identical(other.contactName, contactName) || other.contactName == contactName)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,description,venueType,addressLine1,addressLine2,suburb,city,province,postalCode,country,minimumCapacity,maximumCapacity,contactName,contactEmail,contactPhone,isPublished,isActive);
}

@override
String toString() {
    return 'VenueResponse(id: $id, name: $name, description: $description, venueType: $venueType, addressLine1: $addressLine1, addressLine2: $addressLine2, suburb: $suburb, city: $city, province: $province, postalCode: $postalCode, country: $country, minimumCapacity: $minimumCapacity, maximumCapacity: $maximumCapacity, contactName: $contactName, contactEmail: $contactEmail, contactPhone: $contactPhone, isPublished: $isPublished, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$VenueResponseCopyWith<$Res> implements $VenueResponseCopyWith<$Res> {
  factory _$VenueResponseCopyWith(_VenueResponse value, $Res Function(_VenueResponse) _then) = __$VenueResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, String? venueType, String addressLine1, String? addressLine2, String suburb, String city, String province, String? postalCode, String country, int? minimumCapacity, int? maximumCapacity, String? contactName, String? contactEmail, String? contactPhone, bool isPublished, bool isActive
});




}
/// @nodoc
class __$VenueResponseCopyWithImpl<$Res>
    implements _$VenueResponseCopyWith<$Res> {
  __$VenueResponseCopyWithImpl(this._self, this._then);

  final _VenueResponse _self;
  final $Res Function(_VenueResponse) _then;

/// Create a copy of VenueResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? venueType = freezed,Object? addressLine1 = null,Object? addressLine2 = freezed,Object? suburb = null,Object? city = null,Object? province = null,Object? postalCode = freezed,Object? country = null,Object? minimumCapacity = freezed,Object? maximumCapacity = freezed,Object? contactName = freezed,Object? contactEmail = freezed,Object? contactPhone = freezed,Object? isPublished = null,Object? isActive = null,}) {
  return _then(_VenueResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
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
as String?,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
