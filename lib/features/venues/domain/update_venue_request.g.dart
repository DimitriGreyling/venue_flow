// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_venue_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateVenueRequest _$UpdateVenueRequestFromJson(Map<String, dynamic> json) =>
    _UpdateVenueRequest(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      venueType: json['venueType'] as String?,
      addressLine1: json['addressLine1'] as String,
      addressLine2: json['addressLine2'] as String?,
      suburb: json['suburb'] as String,
      city: json['city'] as String,
      province: json['province'] as String,
      postalCode: json['postalCode'] as String?,
      country: json['country'] as String,
      minimumCapacity: (json['minimumCapacity'] as num?)?.toInt(),
      maximumCapacity: (json['maximumCapacity'] as num?)?.toInt(),
      contactName: json['contactName'] as String?,
      contactEmail: json['contactEmail'] as String?,
      contactPhone: json['contactPhone'] as String?,
      isPublished: json['isPublished'] as bool,
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$UpdateVenueRequestToJson(_UpdateVenueRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'venueType': instance.venueType,
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'suburb': instance.suburb,
      'city': instance.city,
      'province': instance.province,
      'postalCode': instance.postalCode,
      'country': instance.country,
      'minimumCapacity': instance.minimumCapacity,
      'maximumCapacity': instance.maximumCapacity,
      'contactName': instance.contactName,
      'contactEmail': instance.contactEmail,
      'contactPhone': instance.contactPhone,
      'isPublished': instance.isPublished,
      'isActive': instance.isActive,
    };
