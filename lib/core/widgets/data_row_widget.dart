import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:venue_flow_app/features/customers/presentation/customer_controller.dart';

import '../../features/customers/data/customer_repository.dart';

class CustomerExtraDetailsCell extends ConsumerWidget {
  final String customerId;

  const CustomerExtraDetailsCell({super.key, required this.customerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // // Watch a provider that fetches specific details for this customer ID
    final repository = ref.read(customerRepositoryProvider);
    final detailsAsync = repository.getMemberDetailsById(customerId);

    return detailsAsync.when(
      data: (details) => Text(details.phone ?? 'No Phone'),
      loading: () =>
      const Skeletonizer(
        enabled: true,
        child: Text('Loading phone number...'),
      ),
      error: (_, __) => const Text('Failed to load'),
    );
  }
}
