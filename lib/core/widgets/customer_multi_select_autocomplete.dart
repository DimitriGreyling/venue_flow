
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/customers/data/customer_repository.dart';
import '../../features/customers/domain/customer.dart';

class CustomerMultiSelectAutoComplete extends ConsumerStatefulWidget {
  const CustomerMultiSelectAutoComplete({
    super.key,
    this.isDisabled = false,
    this.initialCustomers = const [],
    required this.onCustomersChanged,
  });

  final bool isDisabled;
  final List<Customer> initialCustomers;
  final ValueChanged<List<Customer>> onCustomersChanged;

  @override
  ConsumerState<CustomerMultiSelectAutoComplete> createState() =>
      _CustomerMultiSelectAutoCompleteState();
}

class _CustomerMultiSelectAutoCompleteState
    extends ConsumerState<CustomerMultiSelectAutoComplete> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<Customer> _selectedCustomers = [];
  List<Customer> _options = [];

  Timer? _debounceTimer;

  bool _isLoading = false;
  bool _showOptions = false;

  String _query = '';
  int _requestId = 0;

  @override
  void initState() {
    super.initState();

    _selectedCustomers.addAll(widget.initialCustomers);
    _controller.addListener(_onQueryChanged);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _controller
      ..removeListener(_onQueryChanged)
      ..dispose();
    _focusNode.dispose();

    super.dispose();
  }

  void _onQueryChanged() {
    final query = _controller.text.trim();

    if (query == _query) return;

    _query = query;
    _debounceTimer?.cancel();

    // Ignore results from previous searches.
    final requestId = ++_requestId;

    if (query.isEmpty || widget.isDisabled) {
      setState(() {
        _options = [];
        _isLoading = false;
        _showOptions = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _showOptions = true;
      _options = [];
    });

    _debounceTimer = Timer(
      const Duration(milliseconds: 500),
          () => _searchCustomers(query, requestId),
    );
  }

  Future<void> _searchCustomers(
      String query,
      int requestId,
      ) async {
    try {
      final repository = ref.read(customerRepositoryProvider);

      final customers = await repository.searchCustomers(
        searchTerm: query,
      );

      if (!mounted ||
          requestId != _requestId ||
          query != _query) {
        return;
      }

      final selectedIds =
      _selectedCustomers.map((c) => c.userId).toSet();

      setState(() {
        _options = customers
            .where((customer) => !selectedIds.contains(customer.userId))
            .toList();
        _isLoading = false;
        _showOptions = true;
      });
    } catch (error, stackTrace) {
      if (!mounted || requestId != _requestId) return;

      debugPrint('Customer search failed: $error');
      debugPrintStack(stackTrace: stackTrace);

      setState(() {
        _options = [];
        _isLoading = false;
        _showOptions = true;
      });
    }
  }

  void _selectCustomer(Customer customer) {
    if (widget.isDisabled) return;

    final alreadySelected = _selectedCustomers.any(
          (selected) => selected.userId == customer.userId,
    );

    if (alreadySelected) return;

    setState(() {
      _selectedCustomers.add(customer);
      _options.removeWhere(
            (option) => option.userId == customer.userId,
      );
      _showOptions = false;
    });

    // Return the complete list to the parent.
    widget.onCustomersChanged(
      List<Customer>.unmodifiable(_selectedCustomers),
    );

    // Clear the search so another customer can be searched.
    _controller.clear();

    _focusNode.requestFocus();
  }

  void _removeCustomer(Customer customer) {
    if (widget.isDisabled) return;

    setState(() {
      _selectedCustomers.removeWhere(
            (selected) => selected.userId == customer.userId,
      );
    });

    widget.onCustomersChanged(
      List<Customer>.unmodifiable(_selectedCustomers),
    );

    // Refresh results if there is still a search query.
    if (_query.isNotEmpty) {
      _searchAgain();
    }
  }

  void _searchAgain() {
    _debounceTimer?.cancel();

    final query = _query;
    if (query.isEmpty) return;

    final requestId = ++_requestId;

    setState(() {
      _isLoading = true;
      _showOptions = true;
      _options = [];
    });

    _debounceTimer = Timer(
      const Duration(milliseconds: 500),
          () => _searchCustomers(query, requestId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Selected customers.
        if (_selectedCustomers.isNotEmpty) ...[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _selectedCustomers.map((customer) {
              return InputChip(
                key: ValueKey('customer-${customer.userId}'),
                label: Text(customer.fullName),
                onDeleted: widget.isDisabled
                    ? null
                    : () => _removeCustomer(customer),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
        ],

        // Search field.
        TextField(
          controller: _controller,
          focusNode: _focusNode,
          enabled: !widget.isDisabled,
          decoration: InputDecoration(
            labelText: 'Search customers',
            hintText: 'Type a customer name...',
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _isLoading
                ? const Padding(
              padding: EdgeInsets.all(12),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            )
                : _controller.text.isNotEmpty
                ? IconButton(
              tooltip: 'Clear search',
              icon: const Icon(Icons.clear),
              onPressed: _controller.clear,
            )
                : null,
          ),
        ),

        // Suggestions are regular widgets, not an overlay.
        if (_showOptions && _query.isNotEmpty) ...[
          const SizedBox(height: 4),
          Material(
            elevation: 2,
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 240,
              ),
              child: _buildOptionsList(),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildOptionsList() {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (_options.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('No customers found'),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: _options.length,
      itemBuilder: (context, index) {
        final customer = _options[index];

        return ListTile(
          key: ValueKey('option-${customer.userId}'),
          leading: const CircleAvatar(
            child: Icon(Icons.person_outline),
          ),
          title: Text(customer.fullName),
          onTap: () {
            debugPrint('Customer tapped: ${customer.fullName}');
            _selectCustomer(customer);
          },
        );
      },
    );
  }
}
