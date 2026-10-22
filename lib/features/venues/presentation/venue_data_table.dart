import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:venue_flow_app/core/widgets/dialog/details_popup.dart';
import 'package:venue_flow_app/features/venues/data/venues_controller.dart';
import 'package:venue_flow_app/features/venues/domain/venue_id_response.dart';
import 'package:venue_flow_app/features/venues/domain/venue_response.dart';
import 'package:venue_flow_app/features/venues/presentation/dialogs/delete_venue_dialog.dart';
import 'package:venue_flow_app/features/venues/presentation/dialogs/edit_venue_dialog.dart';
import '../../../core/domain/paged_response.dart';

class VenueDataTable extends ConsumerStatefulWidget {
  const VenueDataTable({
    super.key,
    required this.columns,
    required this.venues,
    required this.constraints,
    required this.isLoading,
    required this.onPageChanged,
    this.requiresRefresh,
  });

  final List<DataColumn> columns;
  final PagedResponse<VenueIdResponse> venues;
  final BoxConstraints constraints;
  final bool isLoading;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<bool>? requiresRefresh;

  @override
  ConsumerState<VenueDataTable> createState() => _VenueDataTableState();
}

class _VenueDataTableState extends ConsumerState<VenueDataTable> {
  final venueDetailsProvider = FutureProvider.family<VenueResponse, String>((
    ref,
    venueId,
  ) async {
    final controller = ref.read(venuesControllerProvider.notifier);

    return controller.getVenueDetailsById(venueId: venueId);
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      height: widget.constraints.maxHeight * 0.8,
      width: widget.constraints.maxWidth,
      child: Card(
        elevation: 2,
        // clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: widget.constraints.maxWidth,
                    ),
                    child: DataTable(
                      columns: widget.columns,
                      rows: widget.isLoading
                          ? _buildLoadingRows(cs)
                          : widget.venues.items.map((venue) {
                              return buildAsyncDataRow<VenueResponse>(
                                cs: cs,
                                value: ref.watch(
                                  venueDetailsProvider(venue.venueId),
                                ),
                                cellCount: widget.columns.length,
                                buildCells: (venue) => [
                                  DataCell(Text(venue.name)),
                                  DataCell(Text(venue.venueType ?? '')),
                                  DataCell(
                                    Row(
                                      children: [
                                        Text('${venue.contactName}'),
                                        IconButton(
                                          tooltip:
                                              'View Contact Information for ${venue.name}',
                                          onPressed: () {
                                            showDetailsPopup(
                                              context: context,
                                              title:
                                                  'Contact Information for ${venue.name}',
                                              details:
                                                  'Name: ${venue.contactName}\nPhone: ${venue.contactPhone}\nEmail: ${venue.contactEmail}',
                                            );
                                          },
                                          icon: Icon(
                                            Mdi.information,
                                            color: cs.outline.withValues(
                                              alpha: 0.5,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      children: [
                                        Text('min: ${venue.minimumCapacity}'),
                                        SizedBox(width: 8),
                                        Text('max: ${venue.maximumCapacity}'),
                                      ],
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            await EditVenueDialog.show(
                                              context,
                                              venue: venue,
                                            );

                                            if (!mounted) return;

                                            widget.requiresRefresh?.call(true);

                                            ref.invalidate(
                                              venueDetailsProvider(venue.id),
                                            );
                                          },
                                          tooltip: 'Edit ${venue.name}',
                                          icon: Icon(
                                            Mdi.pencil,
                                            color: cs.secondary,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await DeleteVenueDialog.show(
                                              context,
                                              venue,
                                            );

                                            if (!mounted) return;

                                            widget.requiresRefresh?.call(true);

                                            ref.invalidate(
                                              venueDetailsProvider(venue.id),
                                            );
                                          },
                                          tooltip: 'Remove ${venue.name}',
                                          icon: Icon(
                                            Mdi.delete,
                                            color: cs.error,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            const Divider(height: 1),
            _buildPaginationControls(cs),
          ],
        ),
      ),
    );
  }

  List<DataRow> _buildLoadingRows(ColorScheme cs) {
    return List.generate(
      widget.venues.pageSize.clamp(1, 6),
      (_) => DataRow(
        cells: List.generate(
          widget.columns.length,
          (_) => DataCell(
            Skeletonizer(
              enabled: true,
              effect: ShimmerEffect(
                baseColor: cs.surfaceContainerLow,
                highlightColor: cs.surface,
              ),
              child: const Text('Loading placeholder'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaginationControls(ColorScheme cs) {
    final result = widget.venues;
    final page = result.page;
    final pageSize = result.pageSize;
    final totalCount = result.totalCount;
    final totalPages = result.totalPages;

    final start = totalCount == 0 ? 0 : (page - 1) * pageSize + 1;
    final end = (page * pageSize).clamp(0, totalCount);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$start–$end of $totalCount members',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          IconButton(
            tooltip: 'Previous page',
            onPressed: !widget.isLoading && page > 1
                ? () => widget.onPageChanged(page - 1)
                : null,
            icon: const Icon(Icons.chevron_left),
          ),
          Text(
            '${totalPages == 0 ? 0 : page} / $totalPages',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          IconButton(
            tooltip: 'Next page',
            onPressed: !widget.isLoading && page < totalPages
                ? () => widget.onPageChanged(page + 1)
                : null,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }

  DataRow buildAsyncDataRow<T>({
    required AsyncValue<T> value,
    required int cellCount,
    required List<DataCell> Function(T data) buildCells,
    required ColorScheme cs,
  }) {
    return value.when(
      loading: () => DataRow(
        cells: List.generate(
          cellCount,
          (_) => DataCell(
            Skeletonizer(
              enabled: true,
              effect: ShimmerEffect(
                baseColor: cs.surfaceContainerLow,
                highlightColor: cs.surface,
              ),
              child: const Text('Loading placeholder'),
            ),
          ),
        ),
      ),
      error: (error, stackTrace) => DataRow(
        cells: List.generate(
          cellCount,
          (index) => DataCell(Text(index == 0 ? 'Failed to load' : '-')),
        ),
      ),
      data: (data) => DataRow(cells: buildCells(data)),
    );
  }
}
