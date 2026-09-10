import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/features/venues/application/venues_controller.dart';

class VenuesScreen extends ConsumerWidget {
  const VenuesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final venuesState = ref.watch(venuesControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Venues')),
      body: venuesState.when(
        data: (venues) => ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: venues.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final venue = venues[index];
            return ListTile(
              title: Text(venue.name),
              subtitle: Text('ID: ${venue.id}'),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }
}
