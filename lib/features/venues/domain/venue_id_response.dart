import 'package:freezed_annotation/freezed_annotation.dart';

part 'venue_id_response.freezed.dart';
part 'venue_id_response.g.dart';

@freezed
abstract class VenueIdResponse with _$VenueIdResponse {
  const factory VenueIdResponse({
    required String venueId,
  }) = _VenueIdResponse;

  factory VenueIdResponse.fromJson(Map<String, dynamic> json) => _$VenueIdResponseFromJson(json);
}