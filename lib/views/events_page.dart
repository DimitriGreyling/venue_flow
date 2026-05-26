import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/models/event_model.dart';
import 'package:venue_flow_app/providers/viewmodel_provider.dart';
import 'package:venue_flow_app/theme/spacing.dart';
import 'package:venue_flow_app/theme/theme.dart';
import 'package:venue_flow_app/views/side_nav_widget.dart';
import 'package:venue_flow_app/views/top_bar_widget.dart';
import 'package:venue_flow_app/views/widgets/table_widget.dart';

class EventsPage extends ConsumerStatefulWidget {
  const EventsPage({super.key});

  @override
  ConsumerState<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends ConsumerState<EventsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(eventListViewModelProvider.notifier).loadEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final state = ref.watch(eventListViewModelProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Row(
        children: [
          const SideNavWidget(),
          Expanded(
            child: Column(
              children: [
                const TopBarWidget(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(EditorialSpacing.spacing8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   'Events',
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .displaySmall
                        //       ?.copyWith(fontWeight: FontWeight.w900),
                        // ),
                        // const SizedBox(height: EditorialSpacing.spacing2),
                        // Text(
                        //   'Schedule and manage your upcoming venue events.',
                        //   style: context.editorial.metadataStyle,
                        // ),
                        // const SizedBox(height: EditorialSpacing.spacing8),
                        // _buildCard(
                        //   context,
                        //   title: 'Upcoming',
                        //   value: '12',
                        //   subtitle: 'Events in next 30 days',
                        //   icon: Icons.event_available_outlined,
                        // ),
                        // const SizedBox(height: EditorialSpacing.spacing4),
                        // _buildCard(
                        //   context,
                        //   title: 'Pending Confirmation',
                        //   value: '4',
                        //   subtitle: 'Waiting on client response',
                        //   icon: Icons.pending_actions_outlined,
                        // ),

                        GenericDataTable(
                          columns: [
                            GenericTableColumn(
                                header: 'Name',
                                cellBuilder: (context, row) {
                                  row as EventModel;

                                  log('Building cell for row: $row');
                                  return Text(row.name ?? 'UNKNOWN');
                                }),
                            GenericTableColumn(
                                header: 'Guest Count',
                                cellBuilder: (context, row) {
                                  row as EventModel;
                                  log('Building cell for row: $row');
                                  return Text(
                                      row.guestCount?.toString() ?? 'UNKNOWN');
                                }),
                            GenericTableColumn(
                                header: 'Event Date',
                                cellBuilder: (context, row) {
                                  row as EventModel;
                                  final dateFormatted = row.eventDate != null
                                      ? '${row.eventDate!.month}/${row.eventDate!.day}/${row.eventDate!.year}'
                                      : 'UNKNOWN';
                                  log('Building cell for row: $row');
                                  return Text(dateFormatted);
                                }),
                            GenericTableColumn(
                                header: 'Status',
                                cellBuilder: (context, row) {
                                  row as EventModel;
                                  log('Building cell for row: $row');
                                  return Text(
                                      row.status?.toString() ?? 'UNKNOWN');
                                }),
                          ],
                          rows: state.events.isNotEmpty
                              ? state.events
                              : List.generate(10, (index) => 'Row $index'),
                          isLoading: state.isLoading,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(EditorialSpacing.spacing6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(EditorialSpacing.spacing3),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: colorScheme.onPrimaryContainer),
          ),
          const SizedBox(width: EditorialSpacing.spacing4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(subtitle, style: context.editorial.metadataStyle),
              ],
            ),
          ),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
