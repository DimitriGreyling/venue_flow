import 'package:freezed_annotation/freezed_annotation.dart';

part 'venue_response.freezed.dart';
part 'venue_response.g.dart';

@freezed
abstract class VenueResponse with _$VenueResponse {
  const factory VenueResponse({
    required String id,
    required String name,
    String? description,
    String? venueType,
    required String addressLine1,
    String? addressLine2,
    required String suburb,
    required String city,
    required String province,
    String? postalCode,
    required String country,
    int? minimumCapacity,
    int? maximumCapacity,
    String? contactName,
    String? contactEmail,
    String? contactPhone,
    required bool isPublished,
    required bool isActive,
  }) = _VenueResponse;

  factory VenueResponse.fromJson(Map<String, dynamic> json) =>
      _$VenueResponseFromJson(json);
}
