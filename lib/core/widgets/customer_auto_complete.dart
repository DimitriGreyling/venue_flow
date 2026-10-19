import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/customers/data/customer_repository.dart';
import '../../features/customers/domain/customer.dart';

class CustomerAutoComplete extends ConsumerStatefulWidget {
  const CustomerAutoComplete({super.key, this.isDisabled = false});

  final bool isDisabled;

  @override
  ConsumerState<CustomerAutoComplete> createState() =>
      _CustomerAutoCompleteState();
}

class _CustomerAutoCompleteState extends ConsumerState<CustomerAutoComplete> {
  // Timer used for debouncing
  Timer? _debounceTimer;

  // Local cache of options to return during the debounce wait period if needed,
  // or we can use a Completer to bridge the Future.
  List<Customer> _lastOptions = [];

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Customer>(
      displayStringForOption: (Customer customer) => customer.fullName,

      optionsBuilder: (TextEditingValue textEditingValue) async {
        final query = textEditingValue.text.trim();

        if (query.isEmpty) {
          _debounceTimer?.cancel();
          return const Iterable<Customer>.empty();
        }

        // Cancel the previous timer if the user is still typing
        if (_debounceTimer?.isActive ?? false) {
          _debounceTimer!.cancel();
        }

        // Create a Completer to bridge the asynchronous Future with the debounce timer
        final completer = Completer<Iterable<Customer>>();

        _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
          try {
            final repository = ref.read(customerRepositoryProvider);
            final customers = await repository.searchCustomers(
              searchTerm: query,
            );
            _lastOptions = customers;
            completer.complete(customers);
          } catch (e) {
            debugPrint('Search error: $e');
            completer.complete(const Iterable<Customer>.empty());
          }
        });

        return completer.future;
      },

      onSelected: widget.isDisabled
          ? null
          : (Customer selection) {
              debugPrint('Selected: ${selection.fullName} ${selection.userId}');
            },

      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
            return TextField(
              enabled: !widget.isDisabled,
              controller: textEditingController,
              focusNode: focusNode,
              decoration: const InputDecoration(
                labelText: 'Search Customer',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            );
          },
    );
  }
}
