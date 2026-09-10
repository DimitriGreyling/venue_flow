import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/features/customers/application/customers_controller.dart';

class CustomersScreen extends ConsumerWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customersState = ref.watch(customersControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Customers')),
      body: customersState.when(
        data: (customers) => ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: customers.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final customer = customers[index];
            return ListTile(
              title: Text(customer.name),
              subtitle: Text('ID: ${customer.id}'),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }
}
