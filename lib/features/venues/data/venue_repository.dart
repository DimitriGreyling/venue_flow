import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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
}

@riverpod
VenueRepository venueRepository(Ref ref) {
  return VenueRepository(ref.watch(dioProvider));
}