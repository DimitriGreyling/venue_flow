import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:venue_flow_app/features/venues/domain/venue_id_response.dart';
import 'package:venue_flow_app/features/venues/domain/venue_response.dart';
import 'package:venue_flow_app/features/venues/domain/venue_search_response.dart';

import '../../../core/domain/paged_response.dart';
import '../domain/create_venue_request.dart';
import 'venue_repository.dart';
import '../domain/venue.dart';

part 'venues_controller.g.dart';

@riverpod
class VenuesController extends _$VenuesController {
  @override
  Future<List<Venue>> build() async {
    return ref.watch(venueRepositoryProvider).getVenues();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(venueRepositoryProvider).getVenues(),
    );
  }

  Future<List<VenueSearchResponse>> searchVenues({
    required String searchTerm,
  }) async {
    final repository = ref.watch(venueRepositoryProvider);
    return repository.searchVenues(searchTerm: searchTerm);
  }

  ///
  /// Get Venues for an organization
  ///
  Future<PagedResponse<VenueIdResponse>> getVenuesForOrganization({
    int page = 1,
    int pageSize = 10,
  }) async {
    final repository = ref.watch(venueRepositoryProvider);
    return repository.getVenuesForOrganization(page: page, pageSize: pageSize);
  }

  ///
  /// Get Venues details by id
  ///
  Future<VenueResponse> getVenueDetailsById({required String venueId}) async {
    final repository = ref.watch(venueRepositoryProvider);
    return repository.getVenueDetailsById(venueId: venueId);
  }

  ///
  /// Add a new Venue
  ///
  Future<VenueResponse> addVenue({required CreateVenueRequest request}) async {
    final repository = ref.watch(venueRepositoryProvider);
    return repository.addVenue(request: request);
  }

  ///
  /// Remove a Venue
  ///
  Future<void> removeVenue({required String venueId}) async {
    final repository = ref.watch(venueRepositoryProvider);
    await repository.removeVenue(venueId: venueId);
  }
}

@riverpod
class VenueDetails extends _$VenueDetails {
  @override
  Future<VenueResponse> build(String venueId) async {
    final repository = ref.watch(venueRepositoryProvider);
    return repository.getVenueDetailsById(venueId: venueId);
  }
}