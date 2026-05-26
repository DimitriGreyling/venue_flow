import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/models/event_model.dart';
import 'package:venue_flow_app/models/popup_position.dart';
import 'package:venue_flow_app/providers/viewmodel_provider.dart';
import 'package:venue_flow_app/shared/helpers/global_popup_service.dart';
import 'package:venue_flow_app/theme/spacing.dart';
import 'package:venue_flow_app/theme/theme.dart';
import 'package:venue_flow_app/views/dialogs/event_dialogs.dart';
import 'package:venue_flow_app/views/side_nav_widget.dart';
import 'package:venue_flow_app/views/top_bar_widget.dart';
import 'package:venue_flow_app/views/widgets/generic_table_widget.dart';

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

  Future<void> _openCreateDialog() async {
    final model = await showEventDialog(context: context, isEdit: false);
    if (model == null) return;

    await ref.read(eventListViewModelProvider.notifier).addEvent(model);

    final error = ref.read(eventListViewModelProvider).error;
    if (error == null) {
      ref.read(eventListViewModelProvider.notifier).loadEvents();
      GlobalPopupService.showSuccess(
        title: 'Event created',
        message: 'Your event was added successfully.',
        position: PopupPosition.bottomRight,
      );
    } else {
      GlobalPopupService.showError(
        title: 'Create failed',
        message: error,
        position: PopupPosition.bottomRight,
      );
    }
  }

  Future<void> _openEditDialog(EventModel event) async {
    final model = await showEventDialog(
      context: context,
      existingEvent: event,
      isEdit: true,
    );
    if (model == null) return;

    await ref.read(eventListViewModelProvider.notifier).updateEvent(model);

    final error = ref.read(eventListViewModelProvider).error;
    if (error == null) {
      ref.read(eventListViewModelProvider.notifier).loadEvents();
      GlobalPopupService.showSuccess(
        title: 'Event updated',
        message: 'Your event was updated successfully.',
        position: PopupPosition.bottomRight,
      );
    } else {
      GlobalPopupService.showError(
        title: 'Update failed',
        message: error,
        position: PopupPosition.bottomRight,
      );
    }
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
                        Row(
                          children: [
                            Text(
                              'Events',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(fontWeight: FontWeight.w900),
                            ),
                            const Spacer(),
                            ElevatedButton.icon(
                              onPressed: _openCreateDialog,
                              icon: const Icon(Icons.add),
                              label: const Text('Add Event'),
                            ),
                          ],
                        ),
                        const SizedBox(height: EditorialSpacing.spacing6),
                        GenericDataTable<EventModel>(
                          columns: [
                            GenericTableColumn<EventModel>(
                              header: 'Name',
                              cellBuilder: (context, row) =>
                                  Text(row.name ?? 'UNKNOWN'),
                            ),
                            GenericTableColumn<EventModel>(
                              header: 'Guest Count',
                              cellBuilder: (context, row) =>
                                  Text(row.guestCount?.toString() ?? 'UNKNOWN'),
                            ),
                            GenericTableColumn<EventModel>(
                              header: 'Event Date',
                              cellBuilder: (context, row) {
                                final date = row.eventDate;
                                final text = date == null
                                    ? 'UNKNOWN'
                                    : '${date.month}/${date.day}/${date.year}';
                                return Text(text);
                              },
                            ),
                            GenericTableColumn<EventModel>(
                              header: 'Status',
                              cellBuilder: (context, row) => Text(
                                  row.status?.name.toUpperCase() ?? 'UNKNOWN'),
                            ),
                          ],
                          rows: state.events,
                          isLoading: state.isLoading,
                          emptyMessage: state.error ?? 'No events found',
                          onRowTap: _openEditDialog,
                        ),
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
}
