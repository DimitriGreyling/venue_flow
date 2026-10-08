import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'venues_controller.dart';

class VenueListScreen extends ConsumerWidget {
  const VenueListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final venuesAsync = ref.watch(venuesControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Venues')),
      body: venuesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Failed to load venues:\n$error'),
          ),
        ),
        data: (venues) => RefreshIndicator(
          onRefresh: () => ref.read(venuesControllerProvider.notifier).refresh(),
          child: ListView.separated(
            itemCount: venues.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final v = venues[index];
              return ListTile(
                title: Text(v.name),
                subtitle: Text(v.address ?? 'No address'),
                trailing: v.capacity != null ? Text('${v.capacity}') : null,
              );
            },
          ),
        ),
      ),
    );
  }
}