import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/providers/viewmodel_provider.dart';
import 'package:venue_flow_app/theme/elevation.dart';
import 'package:venue_flow_app/theme/spacing.dart';
import 'package:venue_flow_app/viewmodels/event_list_viewmodel.dart';
import 'package:venue_flow_app/views/side_nav_widget.dart';
import '../theme/theme.dart';

class EventListPage extends ConsumerStatefulWidget {
  const EventListPage({super.key});

  @override
  ConsumerState<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends ConsumerState<EventListPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(eventListViewModelProvider.notifier).loadEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(eventListViewModelProvider);

    return Scaffold(
      body: Row(
        children: [
          const SideNavWidget(),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                const pagePadding = 16.0;
                final availableWidth = constraints.maxWidth - (pagePadding * 2);
                final tableWidth =
                    constraints.maxWidth >= 900 ? availableWidth * 0.8 : availableWidth;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(pagePadding),
                  child: Center(
                    child: SizedBox(
                      width: tableWidth,
                      child: _buildTable(
                        context: context,
                        state: state,
                        tableWidth: tableWidth,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable({
    required BuildContext context,
    required EventListState state,
    required double tableWidth,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial;

    final actionWidth = 72.0;
    final contentWidth = tableWidth - actionWidth;
    final nameWidth = contentWidth * 0.45;
    final dateWidth = contentWidth * 0.30;
    final statusWidth = contentWidth * 0.25;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.08),
        ),
        boxShadow: EditorialElevation.cardShadow(
          colorScheme.brightness == Brightness.dark,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 0,
            horizontalMargin: 16,
            headingRowColor: WidgetStatePropertyAll(
              colorScheme.surfaceContainerLow,
            ),
            dataRowColor: WidgetStateProperty.resolveWith<Color?>((states) {
              if (states.contains(WidgetState.selected)) {
                return colorScheme.primaryContainer.withOpacity(0.25);
              }
              return colorScheme.surface;
            }),
            headingTextStyle: editorial.metadataStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
            dataTextStyle: editorial.metadataStyle.copyWith(
              fontSize: 12,
              color: colorScheme.onSurfaceVariant,
            ),
            dividerThickness: 0.6,
            dataRowMinHeight: 60,
            dataRowMaxHeight: 72,
            columns: [
              DataColumn(
                label: SizedBox(
                  width: nameWidth,
                  child: const Text('Name'),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: dateWidth,
                  child: const Text('Event Date'),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: statusWidth,
                  child: const Text('Status'),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: actionWidth,
                  child: const SizedBox.shrink(),
                ),
              ),
            ],
            rows: _buildRows(
              context: context,
              state: state,
              nameWidth: nameWidth,
              dateWidth: dateWidth,
              statusWidth: statusWidth,
              actionWidth: actionWidth,
            ),
          ),
        ),
      ),
    );
  }

  List<DataRow> _buildRows({
    required BuildContext context,
    required EventListState state,
    required double nameWidth,
    required double dateWidth,
    required double statusWidth,
    required double actionWidth,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial;

    if (state.isLoading) {
      return [
        DataRow(
          cells: [
            DataCell(
              SizedBox(
                width: nameWidth,
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
            ),
            DataCell(
              SizedBox(
                width: dateWidth,
                child: Text(
                  'Loading events...',
                  style: editorial.metadataStyle.copyWith(fontSize: 12),
                ),
              ),
            ),
            DataCell(
              SizedBox(
                width: statusWidth,
                child: const SizedBox.shrink(),
              ),
            ),
            DataCell(
              SizedBox(
                width: actionWidth,
                child: const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ];
    }

    if (state.error != null) {
      return [
        DataRow(
          cells: [
            DataCell(
              SizedBox(
                width: nameWidth,
                child: Text(
                  'Unable to load events',
                  style: editorial.metadataStyle.copyWith(
                    fontSize: 12,
                    color: colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            DataCell(
              SizedBox(
                width: dateWidth,
                child: Text(
                  state.error!,
                  overflow: TextOverflow.ellipsis,
                  style: editorial.metadataStyle.copyWith(
                    fontSize: 12,
                    color: colorScheme.error,
                  ),
                ),
              ),
            ),
            DataCell(
              SizedBox(
                width: statusWidth,
                child: const SizedBox.shrink(),
              ),
            ),
            DataCell(
              SizedBox(
                width: actionWidth,
                child: const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ];
    }

    if (state.events.isEmpty) {
      return [
        DataRow(
          cells: [
            DataCell(
              SizedBox(
                width: nameWidth,
                child: Text(
                  'No events found',
                  style: editorial.metadataStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            DataCell(
              SizedBox(
                width: dateWidth,
                child: Text(
                  'Create an event to see results here',
                  overflow: TextOverflow.ellipsis,
                  style: editorial.metadataStyle.copyWith(fontSize: 12),
                ),
              ),
            ),
            DataCell(
              SizedBox(
                width: statusWidth,
                child: const SizedBox.shrink(),
              ),
            ),
            DataCell(
              SizedBox(
                width: actionWidth,
                child: const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ];
    }

    return state.events.map((event) {
      final status = event.status ?? EventStatus.unknown;
      final statusColor = _getStatusColor(status: status);

      return DataRow(
        cells: [
          DataCell(
            SizedBox(
              width: nameWidth,
              child: Text(event.name ?? 'Unknown'),
            ),
          ),
          DataCell(
            SizedBox(
              width: dateWidth,
              child: Text(event.eventDate?.toIso8601String() ?? '-'),
            ),
          ),
          DataCell(
            SizedBox(
              width: statusWidth,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: EditorialSpacing.spacing3,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status.name.toUpperCase(),
                    style: editorial.metadataStyle.copyWith(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          DataCell(
            SizedBox(
              width: actionWidth,
              child: Align(
                alignment: Alignment.centerRight,
                child: PopupMenuButton<String>(
                  onSelected: (value) {},
                  itemBuilder: (context) {
                    return const [
                      PopupMenuItem<String>(
                        value: 'update',
                        child: Text('Update'),
                      ),
                    ];
                  },
                ),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  Color _getStatusColor({
    required EventStatus status,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (status) {
      case EventStatus.booked:
        return colorScheme.primary;
      case EventStatus.inprogress:
        return colorScheme.secondary;
      case EventStatus.draft:
        return colorScheme.outline;
      default:
        return colorScheme.inversePrimary;
    }
  }
}