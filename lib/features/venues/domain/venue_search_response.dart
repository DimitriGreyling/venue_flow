import 'package:freezed_annotation/freezed_annotation.dart';

part 'venue_search_response.freezed.dart';
part 'venue_search_response.g.dart';

@freezed
abstract class VenueSearchResponse with _$VenueSearchResponse {
  const factory VenueSearchResponse({
    required String id,
    required String name,
    required String venueType,
    required String description,
  }) = _VenueSearchResponse;

  factory VenueSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$VenueSearchResponseFromJson(json);
}
