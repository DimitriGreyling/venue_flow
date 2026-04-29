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
  int? _sortColumnIndex;
  bool _sortAscending = true;

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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Center(
                  child: _buildTable(state: state),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable({
    required EventListState state,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            // color: Colors.red, //colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.outline.withOpacity(0.05),
            ),
            boxShadow: EditorialElevation.cardShadow(
              colorScheme.brightness == Brightness.dark,
            ),
          ),
          child: DataTable(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            headingTextStyle: editorial.metadataStyle.copyWith(fontSize: 16),
            dataTextStyle: editorial.metadataStyle.copyWith(fontSize: 12),
            dataRowColor: WidgetStateProperty.resolveWith<Color?>((states) {
              // if (states.contains(WidgetState.selected))
              //   return Colors.blue.withOpacity(0.08);
              // return null; // Default color

              return colorScheme.surface;
            }),
            columns: const [
              DataColumn(
                label: Expanded(
                  flex: 3,
                  child: Text(
                    'Name',
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Event Date',
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Status',
                  ),
                ),
              ),
            ],
            rows: state.isLoading
                ? const [
                    DataRow(
                      cells: [
                        DataCell(
                          Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                          ),
                        ),
                        DataCell(
                          Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                          ),
                        ),
                        DataCell(
                          Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                          ),
                        ),
                      ],
                    )
                  ]
                : (state.events.isEmpty)
                    ? const [
                        DataRow(
                          cells: [
                            DataCell(
                              Text(''),
                            ),
                            DataCell(
                              Text(''),
                            ),
                            DataCell(
                              Text(''),
                            ),
                          ],
                        )
                      ]
                    : state.events.map((event) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                event.name ?? 'Unknown',
                              ),
                            ),
                            DataCell(
                              Text(
                                event.eventDate?.toIso8601String() ?? '-',
                              ),
                            ),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: EditorialSpacing.spacing3,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: (_getStatusColor(
                                          status: event.status ??
                                              EventStatus.unknown))
                                      .withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  event.status?.name.toUpperCase() ?? '',
                                  style: editorial.metadataStyle.copyWith(
                                    color: _getStatusColor(
                                        status: event.status ??
                                            EventStatus.unknown),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor({
    required EventStatus status,
  }) {
    switch (status) {
      case EventStatus.booked:
        return Theme.of(context).colorScheme.primary;
      case EventStatus.inprogress:
        return Theme.of(context).colorScheme.secondary;
      case EventStatus.draft:
        return Theme.of(context).colorScheme.outline;
      default:
        return Theme.of(context).colorScheme.inversePrimary;
    }
  }
}
