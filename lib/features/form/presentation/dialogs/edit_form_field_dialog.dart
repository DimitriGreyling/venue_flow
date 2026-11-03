import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/features/form/domain/form_field_schema.dart';
import '../../../../core/enums/form_field_type.dart';
import '../../../../core/theme/theme_x.dart' show ThemeX;

///
/// Dialog popup to edit a form name
///
class EditFormFieldDialog extends ConsumerStatefulWidget {
  const EditFormFieldDialog({
    super.key,
    required this.formFieldSchema,
    this.onFormFieldSchemaChanged,
  });

  final FormFieldSchema formFieldSchema;
  final ValueChanged<FormFieldSchema>? onFormFieldSchemaChanged;

  static Future<bool?> show(
    BuildContext context, {
    required FormFieldSchema? formFieldSchema,
    ValueChanged<FormFieldSchema>? onFormFieldSchemaChanged,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) => EditFormFieldDialog(
        formFieldSchema: formFieldSchema!,
        onFormFieldSchemaChanged: onFormFieldSchemaChanged,
      ),
    );
  }

  @override
  ConsumerState<EditFormFieldDialog> createState() =>
      _EditFormFieldDialogState();
}

class _EditFormFieldDialogState extends ConsumerState<EditFormFieldDialog>
    with TickerProviderStateMixin {
  //form keys
  final _formNameFormKey = GlobalKey<FormState>();

  final TextEditingController _formFieldTitle = TextEditingController();
  final TextEditingController _formFieldHintText = TextEditingController();
  final TextEditingController _formFieldType = TextEditingController();

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    _formFieldTitle.text = widget.formFieldSchema.title ?? '';
    _formFieldHintText.text = widget.formFieldSchema.hintText ?? '';
    _formFieldType.text = widget.formFieldSchema.fieldType.name;
  }

  @override
  void dispose() {
    _formFieldTitle.dispose();
    _formFieldHintText.dispose();
    _formFieldType.dispose();
    _formNameFormKey.currentState?.dispose();
    super.dispose();
  }

  void _save({required ColorScheme cs, required dynamic sem}) async {
    try {
      if (_isSaving) return;

      setState(() {
        _isSaving = true;
      });

      widget.onFormFieldSchemaChanged?.call(
        widget.formFieldSchema.copyWith(
          title: _formFieldTitle.text,
          hintText: _formFieldHintText.text,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: sem.success,
          content: const Text('Form details updated successfully'),
        ),
      );
      Navigator.of(context).pop(true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: cs.error,
          content: Text('Failed to update form details: $e'),
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
          constraints: BoxConstraints(maxHeight: screenSize.height * 0.4),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Edit Form Hint Text', style: textTheme.titleLarge),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formNameFormKey,
                      child: Column(
                        children: [
                          DropdownMenu(
                            dropdownMenuEntries: FormFieldType.values
                                .map(
                                  (type) => DropdownMenuEntry(
                                    value: type.name,
                                    label: type.name,
                                  ),
                                )
                                .toList(),
                            label: Text('Form Field Type'),
                            controller: _formFieldType,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _formFieldTitle,
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
                            controller: _formFieldHintText,
                            decoration: const InputDecoration(
                              labelText: 'Form Hint Text',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a form hint text';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
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
