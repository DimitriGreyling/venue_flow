import 'package:flutter/material.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/models/form_field_model.dart';
import 'package:venue_flow_app/theme/editorial_theme_data.dart';

class FormFieldDialogResult {
  final String? id;
  final String label;
  final String? placeholder;
  final FieldType fieldType;
  final bool isRequired;
  final List<String>? options;
  final dynamic defaultValue;
  final List<dynamic>? validations;
  final dynamic visibility;

  const FormFieldDialogResult({
    required this.id,
    required this.label,
    required this.placeholder,
    required this.fieldType,
    required this.isRequired,
    required this.options,
    this.defaultValue,
    this.validations,
    this.visibility,
  });
}

Future<FormFieldDialogResult?> showFormFieldDialog({
  required BuildContext context,
  required EditorialThemeData editorial,
  required FieldType fieldType,
  FormFieldModel? selectedField,
  bool isEdit = false,
}) async {
  final nameController =
      TextEditingController(text: selectedField?.label ?? '');
  final placeholderController =
      TextEditingController(text: selectedField?.placeholder ?? '');
  final formKey = GlobalKey<FormState>();
  bool isRequired = selectedField?.required ?? false;

  final needsOptions = fieldType == FieldType.dropdown ||
      fieldType == FieldType.radio ||
      fieldType == FieldType.checkbox;

  final optionControllers = (selectedField?.options?.isNotEmpty ?? false)
      ? selectedField!.options!
          .map((value) => TextEditingController(text: value))
          .toList()
      : [TextEditingController()];

  return await showDialog<FormFieldDialogResult>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          void addOption() {
            setState(() {
              optionControllers.add(TextEditingController());
            });
          }

          void removeOption(int index) {
            if (optionControllers.length <= 1) {
              return;
            }

            final controller = optionControllers.removeAt(index);
            controller.dispose();
            setState(() {});
          }

          final screenSize = MediaQuery.of(context).size;
          final dialogWidth = screenSize.width > 768
              ? screenSize.width * 0.4
              : screenSize.width * 0.9;
          final dialogHeight = screenSize.height * 0.6;

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: dialogWidth,
              height: dialogHeight,
              padding: const EdgeInsets.all(24),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _iconForFieldType(fieldType),
                          color: Theme.of(context).colorScheme.primary,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          isEdit
                              ? 'Edit Field'
                              : 'Add ${_fieldTypeLabel(fieldType)}',
                          style: editorial.labelBold.copyWith(fontSize: 18),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildDialogTextField(
                              context,
                              label: 'Field Label',
                              controller: nameController,
                              hint: 'e.g., First Name',
                              validator: (value) {
                                if (value?.trim().isEmpty ?? true) {
                                  return 'Field label is required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            if (!needsOptions) ...[
                              _buildDialogTextField(
                                context,
                                label: 'Placeholder Text',
                                controller: placeholderController,
                                hint: 'e.g., Enter your first name',
                              ),
                              const SizedBox(height: 24),
                            ],
                            if (needsOptions) ...[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${fieldType.name.toUpperCase()} Options',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 1.3,
                                            ),
                                      ),
                                      TextButton.icon(
                                        onPressed: addOption,
                                        icon: const Icon(Icons.add, size: 16),
                                        label: const Text('Add Option'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  ...optionControllers
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    final index = entry.key;
                                    final controller = entry.value;

                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: controller,
                                              decoration: InputDecoration(
                                                hintText: 'Option ${index + 1}',
                                                filled: true,
                                                fillColor: Theme.of(context)
                                                    .colorScheme
                                                    .surfaceContainerLowest,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: BorderSide.none,
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 12,
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value?.trim().isEmpty ??
                                                    true) {
                                                  return 'Option cannot be empty';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          if (optionControllers.length > 1)
                                            IconButton(
                                              onPressed: () =>
                                                  removeOption(index),
                                              icon: const Icon(
                                                  Icons.remove_circle_outline),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .error,
                                            ),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                              const SizedBox(height: 24),
                            ],
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerLowest,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Theme.of(context).colorScheme.error,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Required Field',
                                      style: editorial.labelSubtle.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                  ),
                                  Switch(
                                    value: isRequired,
                                    onChanged: (value) {
                                      setState(() {
                                        isRequired = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: editorial.buttonTextStyle,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (!(formKey.currentState?.validate() ??
                                  false)) {
                                return;
                              }

                              final options = needsOptions
                                  ? optionControllers
                                      .map((controller) =>
                                          controller.text.trim())
                                      .where((value) => value.isNotEmpty)
                                      .toList()
                                  : null;

                              if (needsOptions &&
                                  (options == null || options.isEmpty)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                        'Please add at least one option'),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.error,
                                  ),
                                );
                                return;
                              }

                              Navigator.pop(
                                dialogContext,
                                FormFieldDialogResult(
                                  id: selectedField?.id,
                                  label: nameController.text.trim(),
                                  placeholder: needsOptions
                                      ? null
                                      : placeholderController.text.trim(),
                                  fieldType: fieldType,
                                  isRequired: isRequired,
                                  options: options,
                                  defaultValue: selectedField?.defaultValue,
                                  validations: selectedField?.validations,
                                  visibility: selectedField?.visibility,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              isEdit ? 'Update Field' : 'Add Field',
                              style: editorial.buttonTextStyle.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

Widget _buildDialogTextField(
  BuildContext context, {
  required String label,
  required TextEditingController controller,
  required String hint,
  String? Function(String?)? validator,
}) {
  final theme = Theme.of(context);
  final scheme = theme.colorScheme;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: scheme.outline,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.3,
          ),
        ),
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: controller,
        validator: validator,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: scheme.onSurface,
        ),
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: scheme.surfaceContainerLowest,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
          errorMaxLines: 2,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: scheme.primaryContainer.withOpacity(0.50),
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: scheme.error.withOpacity(0.80),
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: scheme.error,
              width: 2,
            ),
          ),
        ),
      ),
    ],
  );
}

IconData _iconForFieldType(FieldType fieldType) {
  switch (fieldType) {
    case FieldType.text:
      return Icons.short_text;
    case FieldType.textarea:
      return Icons.notes;
    case FieldType.dropdown:
      return Icons.arrow_drop_down_circle;
    case FieldType.radio:
      return Icons.radio_button_checked;
    case FieldType.checkbox:
      return Icons.check_box_outlined;
    case FieldType.date:
      return Icons.calendar_month;
  }
}

String _fieldTypeLabel(FieldType fieldType) {
  switch (fieldType) {
    case FieldType.text:
      return 'Text Input';
    case FieldType.dropdown:
      return 'Dropdown';
    case FieldType.checkbox:
      return 'Checkbox';
    case FieldType.textarea:
      return 'Text Area';
    case FieldType.radio:
      return 'Radio Button';
    case FieldType.date:
      return 'Date';
  }
}
