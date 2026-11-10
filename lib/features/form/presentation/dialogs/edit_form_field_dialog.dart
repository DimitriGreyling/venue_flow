import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/theme/app_theme.dart';
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
      barrierDismissible: false,
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
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _formFieldTitle = TextEditingController();
  final TextEditingController _formFieldHintText = TextEditingController();
  final TextEditingController _formFieldType = TextEditingController();

  bool _isSaving = false;
  bool _isRequiredField = false;

  @override
  void initState() {
    super.initState();

    _isRequiredField = widget.formFieldSchema.isRequired ?? false;
    _formFieldTitle.text = widget.formFieldSchema.title ?? '';
    _formFieldHintText.text = widget.formFieldSchema.hintText ?? '';
    _formFieldType.text = widget.formFieldSchema.fieldType.name;
    print('EditFormFieldDialog initialized with field: ${_formFieldType.text}');
  }

  @override
  void dispose() {
    _formFieldTitle.dispose();
    _formFieldHintText.dispose();
    _formFieldType.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void _save({required ColorScheme cs, required dynamic sem}) async {
    try {
      if (!_formKey.currentState!.validate()) return;

      if (_isSaving) return;

      setState(() {
        _isSaving = true;
      });

      widget.onFormFieldSchemaChanged?.call(
        widget.formFieldSchema.copyWith(
          title: _formFieldTitle.text,
          hintText: _formFieldHintText.text,
          fieldType: FormFieldType.values.firstWhere(
            (type) => type.name == _formFieldType.text,
          ),
          isRequired: _isRequiredField,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Edit Form Field', style: textTheme.titleLarge),
                    IconButton(
                      tooltip: 'Close remove form',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close,color: cs.error,),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildForm(cs: cs, sem: sem,dialogWidth: dialogWidth),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        // Removes solid background
                        shadowColor: Colors.transparent,
                        // Removes shadow elevation
                        side: BorderSide(color: cs.error, width: 1.5),
                        // Adds outline
                        foregroundColor: cs.onError, // Text colour
                      ),
                      onPressed: _isSaving
                          ? null
                          : () => Navigator.of(context).pop(false),
                      child: Text('Cancel', style: TextStyle(color: cs.error)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        // Removes solid background
                        shadowColor: Colors.transparent,
                        // Removes shadow elevation
                        side: BorderSide(color: cs.primary, width: 1.5),
                        // Adds outline
                        foregroundColor: cs.onPrimary, // Text colour
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
                          : Text('Update',style: TextStyle(color: cs.primary)),
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

  Widget _buildForm({
    required ColorScheme cs,
    required AppSemanticColors sem,
    double? dialogWidth,
  }) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FormField<String>(
                  validator: (_) {
                    if (_formFieldType.text.trim().isEmpty) {
                      return 'Please select a form field type';
                    }

                    return null;
                  },
                  builder: (state) {
                    return DropdownMenu<String>(
                      width: dialogWidth,
                      dropdownMenuEntries: FormFieldType.values
                          .map(
                            (type) => DropdownMenuEntry<String>(
                              value: type.name,
                              label: type.name,
                            ),
                          )
                          .toList(),
                      label: const Text('Form Field Type *'),
                      controller: _formFieldType,
                      onSelected: (value) {
                        state.didChange(value);
                        state.validate();
                      },
                      errorText: state.errorText,
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _formFieldTitle,
            decoration: const InputDecoration(
              labelText: 'Form Name *',
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
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            value: _isRequiredField,
            onChanged: (value) {
              setState(() {
                _isRequiredField = value ?? false;
              });
            },
            title: const Text('Required Field'),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
