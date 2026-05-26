import 'package:flutter/material.dart';
import 'package:venue_flow_app/models/event_model.dart';

Future<bool> showDeleteEventDialog(
  BuildContext context, {
  required EventModel event,
}) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Delete Event'),
        content: Text(
          'Are you sure you want to delete "${event.name ?? 'this event'}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );

  return result ?? false;
}
