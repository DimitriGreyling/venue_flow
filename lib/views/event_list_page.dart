import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/models/event_model.dart';
import 'package:venue_flow_app/providers/viewmodel_provider.dart';
import 'package:venue_flow_app/shared/helpers/date_extensions.dart';
import 'package:venue_flow_app/theme/elevation.dart';
import 'package:venue_flow_app/theme/spacing.dart';
import 'package:venue_flow_app/viewmodels/event_list_viewmodel.dart';
import 'package:venue_flow_app/views/dynamic_table_widget.dart';
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SideNavWidget(),
          Expanded(child: LayoutBuilder(
            builder: (context, constraints) {
              const pagePadding = 16.0;
              final availableWidth = constraints.maxWidth - (pagePadding * 2);
              final availableHeight = constraints.maxHeight - (pagePadding * 2);
              final tableWidth = constraints.maxWidth >= 900
                  ? availableWidth * 0.8
                  : availableWidth;
              final tableHeight = constraints.maxHeight >= 900
                  ? availableHeight * 0.8
                  : availableHeight;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(pagePadding),
                child: Center(
                  child: SizedBox(
                      width: tableWidth,
                      height: tableHeight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Events',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Manage all venue events from one place.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                          ),
                          const SizedBox(height: 24),
                          _buildTable(
                            context: context,
                            state: state,
                            tableWidth: tableWidth,
                            tableHeight: tableHeight,
                          ),
                        ],
                      )),
                ),
              );
            },
          ))
        ],
      ),
    );
  }

  Widget _buildTable({
    required BuildContext context,
    required EventListState state,
    required double tableWidth,
    required double tableHeight,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    const actionWidth = 20.0;
    final contentWidth = tableWidth - actionWidth;
    final nameWidth = contentWidth * 0.45;
    final dateWidth = contentWidth * 0.30;
    final statusWidth = contentWidth * 0.25;

    final editorial = context.editorial;
    final textStyle = editorial.metadataStyle.copyWith(fontSize: 12);

    return DynamicTable(
      isLoading: state.isLoading,
      headerHeight: 50,
      rowHeight: 100,
      rows: state.events,
      columns: [
        DynamicTableColumn(
          title: 'Name',
          minWidth: 30,
          flex: 1,
          cellBuilder: (context, row) {
            return Container(
              child: Text((row as EventModel).name ?? '', style: textStyle,),
            );
          },
        ),
        DynamicTableColumn(
          title: 'Event Date',
          minWidth: 30,
          flex: 1,
          cellBuilder: (context, row) {
            return Container(
              child: Text((row as EventModel).eventDate.toDateString(), style: textStyle,),
            );
          },
        ),
        DynamicTableColumn(
          title: 'Status',
          minWidth: 30,
          flex: 1,
          cellBuilder: (context, row) {
            final status = (row as EventModel).status;
            final statusColor =
                _getStatusColor(status: status ?? EventStatus.unknown);
            final colorScheme = Theme.of(context).colorScheme;
            final editorial = context.editorial;

            return SizedBox(
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
                    status?.name.toUpperCase() ?? 'UNKNOWN',
                    // style: editorial.metadataStyle.copyWith(
                    //   color: statusColor,
                    //   fontSize: 10,
                    //   fontWeight: FontWeight.bold,
                    // ),

                    style: textStyle,
                  ),
                ),
              ),
            );
          },
        ),
      ],
      height: tableHeight * 0.5,
    );
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
