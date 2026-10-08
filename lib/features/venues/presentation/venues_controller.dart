import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/venue_repository.dart';
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
}