import 'package:venue_flow_app/features/venues/domain/venue.dart';

abstract class VenuesRepository {
  Future<List<Venue>> list();
}
