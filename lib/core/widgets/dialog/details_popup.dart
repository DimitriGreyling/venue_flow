import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void showDetailsPopup({
  required BuildContext context,
  required String title,
  required String details,
}) {
  showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(title),
        content: SelectableText(details),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await Clipboard.setData(
                ClipboardData(text: details),
              );

              if (!dialogContext.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Copied to clipboard'),
                ),
              );
            },
            icon: const Icon(Icons.copy),
            label: const Text('Copy'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}