import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/features/venues/data/venue_repository.dart';
import 'package:venue_flow_app/features/venues/domain/venue.dart';
import 'package:venue_flow_app/features/venues/domain/venue_search_response.dart';

import '../../features/customers/data/customer_repository.dart';
import '../../features/customers/domain/customer.dart';

class VenueAutoComplete extends ConsumerStatefulWidget {
  const VenueAutoComplete({
    super.key,
    this.isDisabled = false,
    required this.onVenueSelected,
  });

  final bool isDisabled;
  final ValueChanged<VenueSearchResponse?> onVenueSelected;

  @override
  ConsumerState<VenueAutoComplete> createState() => _VenueAutoCompleteState();
}

class _VenueAutoCompleteState extends ConsumerState<VenueAutoComplete> {
  // Timer used for debouncing
  Timer? _debounceTimer;

  // Local cache of options to return during the debounce wait period if needed,
  // or we can use a Completer to bridge the Future.
  List<VenueSearchResponse> _lastOptions = [];

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<VenueSearchResponse>(
      displayStringForOption: (VenueSearchResponse venue) => venue.name,

      optionsBuilder: (TextEditingValue textEditingValue) async {
        final query = textEditingValue.text.trim();

        if (query.isEmpty) {
          _debounceTimer?.cancel();
          _isLoading.value = false;
          return const Iterable<VenueSearchResponse>.empty();
        }

        // Cancel the previous timer if the user is still typing
        if (_debounceTimer?.isActive ?? false) {
          _debounceTimer!.cancel();
          _isLoading.value = false;
        }
        _isLoading.value = true;
        // Create a Completer to bridge the asynchronous Future with the debounce timer
        final completer = Completer<Iterable<VenueSearchResponse>>();

        _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
          try {
            final repository = ref.read(venueRepositoryProvider);
            final venues = await repository.searchVenues(searchTerm: query);
            _lastOptions = venues;
            completer.complete(venues);
          } catch (e) {
            _isLoading.value = false;
            debugPrint('Search error: $e');
            completer.complete(const Iterable<VenueSearchResponse>.empty());
          } finally {
            _isLoading.value = false;
          }
        });

        return completer.future;
      },

      onSelected: widget.isDisabled
          ? null
          : (VenueSearchResponse selection) {
              debugPrint('Selected: ${selection.name} ${selection.id}');
              widget.onVenueSelected(selection);
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
                    labelText: 'Search Venue',
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
                              widget.onVenueSelected(null);
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
