import 'package:venue_flow_app/features/bookings/domain/booking.dart';

abstract class BookingsRepository {
  Future<List<Booking>> list();
}
