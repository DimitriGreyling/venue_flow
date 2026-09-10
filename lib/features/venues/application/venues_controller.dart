import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/features/venues/data/venues_repository_impl.dart';
import 'package:venue_flow_app/features/venues/domain/venue.dart';

final venuesControllerProvider =
    AsyncNotifierProvider<VenuesController, List<Venue>>(VenuesController.new);

class VenuesController extends AsyncNotifier<List<Venue>> {
  @override
  Future<List<Venue>> build() async {
    final repository = ref.read(venuesRepositoryProvider);
    return repository.list();
  }
}
