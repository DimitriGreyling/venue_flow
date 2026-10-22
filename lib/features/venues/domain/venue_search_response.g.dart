// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VenueSearchResponse _$VenueSearchResponseFromJson(Map<String, dynamic> json) =>
    _VenueSearchResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      venueType: json['venueType'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$VenueSearchResponseToJson(
  _VenueSearchResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'venueType': instance.venueType,
  'description': instance.description,
};
