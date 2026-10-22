import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_venue_request.freezed.dart';
part 'update_venue_request.g.dart';

@freezed
abstract class UpdateVenueRequest with _$UpdateVenueRequest {
  const factory UpdateVenueRequest({
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
  }) = _UpdateVenueRequest;

  factory UpdateVenueRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateVenueRequestFromJson(json);
}
