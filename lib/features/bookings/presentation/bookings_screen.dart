import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/features/bookings/application/bookings_controller.dart';

class BookingsScreen extends ConsumerWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingsState = ref.watch(bookingsControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Bookings')),
      body: bookingsState.when(
        data: (bookings) => ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: bookings.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final booking = bookings[index];
            return ListTile(
              title: Text(booking.reference),
              subtitle: Text('ID: ${booking.id}'),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }
}
