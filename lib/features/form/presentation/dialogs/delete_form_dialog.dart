import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/theme/app_theme.dart';
import 'package:venue_flow_app/features/customers/domain/register_customer.dart';
import 'package:venue_flow_app/features/customers/presentation/customer_controller.dart';
import '../../../../core/theme/theme_x.dart';
import '../../../../core/widgets/customer_auto_complete.dart';
import '../../data/form_controller.dart';
import '../../domain/form_list_item.dart';

///
/// Dialog popup for confirming to remove a customer from a organization
///
class DeleteFormDialog extends ConsumerStatefulWidget {
  const DeleteFormDialog({super.key, required this.formListItem});

  final FormListItem formListItem;

  static Future<bool?> show(BuildContext context, FormListItem formListItem) {
    return showDialog<bool>(
      context: context,
      builder: (_) => DeleteFormDialog(formListItem: formListItem),
    );
  }

  @override
  ConsumerState<DeleteFormDialog> createState() => _DeleteCustomerDialogState();
}

class _DeleteCustomerDialogState extends ConsumerState<DeleteFormDialog> {
  bool _isSaving = false;

  FormListItem? _selectedCustomer;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _remove({
    required ColorScheme cs,
    required AppSemanticColors sem,
  }) async {
    try {
      if (_isSaving) return;

      setState(() {
        _isSaving = true;
      });

      final repo = ref.watch(formControllerProvider.notifier);

      await repo.deleteForm(formId: widget.formListItem.id);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: sem.success,
          content: Text('Form removed successfully'),
        ),
      );

      Navigator.of(context).pop(true);
    } catch (e) {
      setState(() {
        _isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: cs.error,
          content: Text('An error occurred: $e'),
        ),
      );
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    final textTheme = Theme.of(context).textTheme;

    final dialogWidth = screenSize.width > 800
        ? screenSize.width * 0.6
        : screenSize.width * 0.9;

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: SizedBox(
        width: dialogWidth,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: screenSize.height * 0.8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Remove Customer', style: textTheme.headlineSmall),
                const SizedBox(height: 16),

                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Are you sure you want to remove the form "${widget.formListItem.name}" from the organization? This action cannot be undone.',
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cs.error,
                        foregroundColor: cs.onError,
                      ),
                      onPressed: _isSaving
                          ? null
                          : () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cs.primary,
                        foregroundColor: cs.onPrimary,
                      ),
                      onPressed: _isSaving
                          ? null
                          : () => _remove(cs: cs, sem: sem),
                      child: _isSaving
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
