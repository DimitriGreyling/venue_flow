import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/features/bookings/domain/booking.dart';
import 'package:venue_flow_app/features/bookings/domain/bookings_repository.dart';

final bookingsRepositoryProvider = Provider<BookingsRepository>((ref) {
  return _BookingsRepositoryImpl();
});

class _BookingsRepositoryImpl implements BookingsRepository {
  @override
  Future<List<Booking>> list() async {
    return const [
      Booking(id: '1', reference: 'BK-1001'),
      Booking(id: '2', reference: 'BK-1002'),
    ];
  }
}
