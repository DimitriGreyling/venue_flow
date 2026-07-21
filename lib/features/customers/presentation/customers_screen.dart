import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/customers_controller.dart';
import 'customer_form_dialog.dart';

class CustomersScreen extends ConsumerStatefulWidget {
  const CustomersScreen({super.key});

  @override
  ConsumerState<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends ConsumerState<CustomersScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(customersControllerProvider.notifier).load());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customersControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton(
              onPressed: state.loading
                  ? null
                  : () => showDialog(
                        context: context,
                        builder: (_) => CustomerFormDialog(
                          onSubmit: (name, email, phone) {
                            return ref.read(customersControllerProvider.notifier).create(
                                  fullName: name,
                                  email: email,
                                  phone: phone,
                                );
                          },
                        ),
                      ),
              child: const Text('Add Customer'),
            ),
          ),
        ],
      ),
      body: state.loading && state.items.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text('Error: ${state.error}'))
              : ListView.separated(
                  itemCount: state.items.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, i) {
                    final c = state.items[i];
                    return ListTile(
                      title: Text(c.fullName),
                      subtitle: Text(c.email),
                      trailing: Text(c.phone ?? '-'),
                    );
                  },
                ),
    );
  }
}