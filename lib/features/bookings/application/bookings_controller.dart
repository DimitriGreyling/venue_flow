import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/features/bookings/data/bookings_repository_impl.dart';
import 'package:venue_flow_app/features/bookings/domain/booking.dart';

final bookingsControllerProvider =
    AsyncNotifierProvider<BookingsController, List<Booking>>(
      BookingsController.new,
    );

class BookingsController extends AsyncNotifier<List<Booking>> {
  @override
  Future<List<Booking>> build() async {
    final repository = ref.read(bookingsRepositoryProvider);
    return repository.list();
  }
}
