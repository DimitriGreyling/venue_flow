import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:venue_flow_app/features/venues/domain/venue_search_response.dart';
import '../../../core/network/dio_client.dart';
import '../domain/venue.dart';

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
}

@riverpod
VenueRepository venueRepository(Ref ref) {
  return VenueRepository(ref.watch(dioProvider));
}
