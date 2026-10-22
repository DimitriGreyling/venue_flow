import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_venue_request.freezed.dart';

part 'create_venue_request.g.dart';

@freezed
abstract class CreateVenueRequest with _$CreateVenueRequest {
  const factory CreateVenueRequest({
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
    String? orgId,
  }) = _CreateVenueRequest;

  factory CreateVenueRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateVenueRequestFromJson(json);
}
