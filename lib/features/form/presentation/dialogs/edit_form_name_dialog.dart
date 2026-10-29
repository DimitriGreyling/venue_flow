import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme_x.dart' show ThemeX;

///
/// Dialog popup to edit a form name
///
class EditFormNameDialog extends ConsumerStatefulWidget {
  const EditFormNameDialog({
    super.key,
    this.formName,
    this.formDescription,
    this.onFormNameChanged,
    this.onFormDescriptionChanged,
  });

  final String? formName;
  final String? formDescription;
  final ValueChanged<String?>? onFormNameChanged;
  final ValueChanged<String?>? onFormDescriptionChanged;

  static Future<bool?> show(
    BuildContext context, {
    String? formName,
    String? formDescription,
    ValueChanged<String?>? onFormNameChanged,
    ValueChanged<String?>? onFormDescriptionChanged,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) => EditFormNameDialog(
        formName: formName,
        formDescription: formDescription,
        onFormNameChanged: onFormNameChanged,
        onFormDescriptionChanged: onFormDescriptionChanged,
      ),
    );
  }

  @override
  ConsumerState<EditFormNameDialog> createState() => _EditFormNameDialogState();
}

class _EditFormNameDialogState extends ConsumerState<EditFormNameDialog>
    with TickerProviderStateMixin {
  //form keys
  final _formNameFormKey = GlobalKey<FormState>();

  final TextEditingController _formNameController = TextEditingController();
  final TextEditingController _formDescriptionController =
      TextEditingController();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    _formNameController.text = widget.formName ?? '';
    _formDescriptionController.text = widget.formDescription ?? '';
  }

  @override
  void dispose() {
    _formNameController.dispose();
    _formDescriptionController.dispose();
    _formNameFormKey.currentState?.dispose();
    super.dispose();
  }

  void _save({required ColorScheme cs, required dynamic sem}) async {
    try {
      if (_isSaving) return;

      setState(() {
        _isSaving = true;
      });

      widget.onFormNameChanged?.call(_formNameController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: sem.success,
          content: const Text('Form name updated successfully'),
        ),
      );
      Navigator.of(context).pop(true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: cs.error,
          content: Text('Failed to update form name: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
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
          constraints: BoxConstraints(
            maxHeight: screenSize.height * 0.4,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Edit Form Name', style: textTheme.titleLarge),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formNameFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _formNameController,
                            decoration: const InputDecoration(
                              labelText: 'Form Name',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a form name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            maxLines: 5,
                            minLines: 3,
                            keyboardType: TextInputType.multiline,
                            controller: _formDescriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Form Description',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a form description';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
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
                          : () => _save(cs: cs, sem: sem),
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
