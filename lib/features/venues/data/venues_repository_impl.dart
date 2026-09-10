import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/features/venues/domain/venue.dart';
import 'package:venue_flow_app/features/venues/domain/venues_repository.dart';

final venuesRepositoryProvider = Provider<VenuesRepository>((ref) {
  return _VenuesRepositoryImpl();
});

class _VenuesRepositoryImpl implements VenuesRepository {
  @override
  Future<List<Venue>> list() async {
    return const [
      Venue(id: '1', name: 'Grand Hall'),
      Venue(id: '2', name: 'North Tower'),
    ];
  }
}
