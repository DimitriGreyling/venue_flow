import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/customers/data/customer_repository.dart';
import '../../features/customers/domain/customer.dart';

class CustomerAutoComplete extends ConsumerStatefulWidget {
  const CustomerAutoComplete({
    super.key,
    this.isDisabled = false,
    required this.onCustomerSelected,
  });

  final bool isDisabled;
  final ValueChanged<Customer?> onCustomerSelected;

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

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _isLoading.dispose();
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
          _isLoading.value = false;
          return const Iterable<Customer>.empty();
        }

        // Cancel the previous timer if the user is still typing
        if (_debounceTimer?.isActive ?? false) {
          _debounceTimer!.cancel();
          _isLoading.value = false;
        }
        _isLoading.value = true;
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
            _isLoading.value = false;
            debugPrint('Search error: $e');
            completer.complete(const Iterable<Customer>.empty());
          } finally {
            _isLoading.value = false;
          }
        });

        return completer.future;
      },

      onSelected: widget.isDisabled
          ? null
          : (Customer selection) {
              debugPrint('Selected: ${selection.fullName} ${selection.userId}');
              widget.onCustomerSelected(selection);
            },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
            return ValueListenableBuilder<TextEditingValue>(
              valueListenable: textEditingController,
              builder: (context, value, _) {
                return TextField(
                  enabled: !widget.isDisabled,
                  controller: textEditingController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: 'Search Customer',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: ValueListenableBuilder<bool>(
                      valueListenable: _isLoading,
                      builder: (context, isLoading, _) {
                        if (isLoading) {
                          return const Padding(
                            padding: EdgeInsets.all(12),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        }

                        if (value.text.isNotEmpty) {
                          return IconButton(
                            tooltip: 'Clear customer',
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              textEditingController.clear();
                              widget.onCustomerSelected(null);
                              focusNode.requestFocus();
                            },
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                );
              },
            );
          },
    );
  }
}
