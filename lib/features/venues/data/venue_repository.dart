import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:venue_flow_app/core/domain/paged_response.dart';
import 'package:venue_flow_app/features/venues/domain/update_venue_request.dart';
import 'package:venue_flow_app/features/venues/domain/venue_id_response.dart';
import 'package:venue_flow_app/features/venues/domain/venue_search_response.dart';
import '../../../core/network/dio_client.dart';
import '../domain/venue.dart';
import '../domain/venue_response.dart';

part 'venue_repository.g.dart';

class VenueRepository {
  VenueRepository(this._dio);

  final Dio _dio;

  Future<List<Venue>> getVenues() async {
    final response = await _dio.get('/venues');
    final list = (response.data as List<dynamic>);
    return list
        .map((item) => Venue.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<VenueSearchResponse>> searchVenues({
    required String searchTerm,
  }) async {
    final response = await _dio.get(
      '/venues/search',
      queryParameters: {'searchTerm': searchTerm},
    );

    print('RESPONSE: ${response}');

    final list = (response.data as List<dynamic>);
    return list
        .map(
          (item) => VenueSearchResponse.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }

  ///
  /// Get Venues for an organization
  ///
  Future<PagedResponse<VenueIdResponse>> getVenuesForOrganization({
    int page = 1,
    int pageSize = 10,
  }) async {
    final response = await _dio.get(
      '/venues/venues',
      queryParameters: {'page': page, 'pageSize': pageSize},
    );

    final data = response.data as Map<String, dynamic>;
    return PagedResponse<VenueIdResponse>.fromJson(
      data,
      (item) => VenueIdResponse.fromJson(item as Map<String, dynamic>),
    );
  }

  ///
  /// Get Venues details by id
  ///
  Future<VenueResponse> getVenueDetailsById({required String venueId}) async {
    final response = await _dio.get('/venues/$venueId');

    final data = response.data;
    return VenueResponse.fromJson(data as Map<String, dynamic>);
  }

  ///
  /// Get Venues details by id
  ///
  Future<VenueResponse> updateVenueDetails({
    required UpdateVenueRequest request,
  }) async {
    final response = await _dio.put(
      '/venues/${request.id}',
      data: request.toJson(),
    );

    final data = response.data;
    return VenueResponse.fromJson(data as Map<String, dynamic>);
  }
}

@riverpod
VenueRepository venueRepository(Ref ref) {
  return VenueRepository(ref.watch(dioProvider));
}
