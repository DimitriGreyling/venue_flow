import 'package:flutter/material.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/models/form_field_model.dart';
import '../theme/editorial_theme_data.dart';

class ReorderableFormFieldTile extends StatelessWidget {
  final FormFieldModel field;
  final int pageIndex;
  final int fieldIndex;
  final bool isSelected;
  final dynamic currentValue;
  final ValueChanged<dynamic>? onValueChanged;
  final ValueChanged<dynamic>? onValueSaved;
  final VoidCallback? onEditClicked;
  final VoidCallback? onDelete;
  final VoidCallback? onDuplicate;
  final ColorScheme colorScheme;
  final EditorialThemeData editorial;
  final bool? isClient;

  const ReorderableFormFieldTile({
    Key? key,
    required this.field,
    required this.pageIndex,
    required this.fieldIndex,
    required this.isSelected,
    this.currentValue,
    this.onValueChanged,
    this.onValueSaved,
    required this.colorScheme,
    required this.editorial,
    this.onEditClicked,
    this.onDelete,
    this.onDuplicate,
    this.isClient = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          // onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? colorScheme.secondary.withOpacity(0.5) : Colors.transparent,
                width: 0.5, //isSelected ? 1 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: colorScheme.secondary.withOpacity(0.1),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with label and actions
                Row(
                  children: [
                    // Field type icon
                    // Container(
                    //   padding: const EdgeInsets.all(8),
                    //   decoration: BoxDecoration(
                    //     color: _getFieldTypeColor().withOpacity(0.1),
                    //     borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   child: Icon(
                    //     _getFieldTypeIcon(),
                    //     size: 16,
                    //     color: _getFieldTypeColor(),
                    //   ),
                    // ),
                    // const SizedBox(width: 12),

                    // Field label
                    // Expanded(
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         field.label ?? '',
                    //         style: editorial.labelBold.copyWith(
                    //           color: colorScheme.onSurface,
                    //           fontSize: 15,
                    //         ),
                    //       ),
                    //       if (field.required ?? false)
                    //         Text(
                    //           'Required',
                    //           style: editorial.labelSubtle.copyWith(
                    //             color: colorScheme.error,
                    //             fontSize: 12,
                    //           ),
                    //         ),
                    //     ],
                    //   ),
                    // ),
                    const Spacer(),

                    // Action buttons (show only when selected)
                    if (isSelected && (isClient == false)) ...[
                      IconButton(
                        onPressed: onEditClicked,
                        icon: const Icon(Icons.edit, size: 18),
                        color: colorScheme.outline,
                        tooltip: 'Edit',
                      ),
                      IconButton(
                        onPressed: onDuplicate,
                        icon: const Icon(Icons.content_copy, size: 18),
                        color: colorScheme.outline,
                        tooltip: 'Duplicate',
                      ),
                      IconButton(
                        onPressed: onDelete,
                        icon: const Icon(Icons.delete_outline, size: 18),
                        color: colorScheme.error,
                        tooltip: 'Delete',
                      ),
                    ],

                    if (isClient == false)
                      // Reorder handle
                      ReorderableDragStartListener(
                        index: 0, // This will be set by the parent
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.drag_indicator,
                            color: colorScheme.outline,
                            size: 20,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 16),

                // Preview of the field
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    // border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _determinFieldToShow(
                          context: context,
                        ),
                        //  Text(
                        //   field.placeholder ?? '',
                        //   style: editorial.placeholderStyle.copyWith(
                        //     color: colorScheme.onSurfaceVariant,
                        //     fontStyle: FontStyle.italic,
                        //   ),
                        // ),
                      ),
                      // if (_hasTrailingIcon())
                      //   Icon(
                      //     _getTrailingIcon(),
                      //     color: colorScheme.onSurfaceVariant,
                      //     size: 20,
                      //   ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getFieldTypeColor() {
    switch (field.type) {
      case FieldType.text:
        return colorScheme.primary;
      case FieldType.dropdown:
        return Colors.purple;
      case FieldType.checkbox:
        return Colors.green;
      case FieldType.date:
        return colorScheme.tertiary;
      case FieldType.textarea:
        return colorScheme.secondary;
      case FieldType.radio:
        return Colors.orange;
      default:
        return colorScheme.primary;
    }
  }

  IconData _getFieldTypeIcon() {
    switch (field.type) {
      case FieldType.text:
        return Icons.short_text;
      case FieldType.dropdown:
        return Icons.arrow_drop_down_circle;
      case FieldType.checkbox:
        return Icons.check_box_outlined;
      case FieldType.date:
        return Icons.calendar_month;
      case FieldType.textarea:
        return Icons.text_fields;
      case FieldType.radio:
        return Icons.radio_button_checked;
      default:
        return Icons.short_text;
    }
  }

  bool _hasTrailingIcon() {
    switch (field.type) {
      case FieldType.date:
      case FieldType.dropdown:
        return true;
      default:
        return false;
    }
  }

  IconData _getTrailingIcon() {
    switch (field.type) {
      case FieldType.date:
        return Icons.calendar_today;
      case FieldType.dropdown:
        return Icons.arrow_drop_down;
      default:
        return Icons.help;
    }
  }

  Widget _determinFieldToShow({
    required BuildContext context,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final resolvedValue = currentValue ?? field.defaultValue;
    final isInteractive = isClient == true;

    switch (field.type) {
      case FieldType.text:
        return _buildTextField(
          context,
          initialValue: resolvedValue?.toString(),
          hint: field.placeholder,
          enabled: isInteractive,
          onChanged: onValueChanged,
          onSaved: onValueSaved,
          validator: _validateTextValue,
        );
      case FieldType.dropdown:
        return _buildDropDownField(
          context,
          options: field.options,
          selectedValue: resolvedValue?.toString(),
          onChanged: (value) => onValueChanged?.call(value),
          onSaved: (value) => onValueSaved?.call(value),
          validator: _validateSelection,
          enabled: isInteractive,
        );
      case FieldType.checkbox:
        return _buildCheckboxField(
          context,
          value: resolvedValue is bool ? resolvedValue : false,
          onChanged: (value) => onValueChanged?.call(value ?? false),
          onSaved: (value) => onValueSaved?.call(value ?? false),
          validator: _validateCheckbox,
          enabled: isInteractive,
        );
      case FieldType.date:
        return _buildDateField(
          context,
          selectedDate: _parseDateValue(resolvedValue),
          onChanged: (value) => onValueChanged?.call(value),
          onSaved: (value) => onValueSaved?.call(value?.toIso8601String()),
          validator: _validateDate,
          enabled: isInteractive,
        );
      case FieldType.textarea:
        return _buildTextAreaField(
          context,
          initialValue: resolvedValue?.toString(),
          enabled: isInteractive,
          onChanged: onValueChanged,
          onSaved: onValueSaved,
          validator: _validateTextValue,
        );
      case FieldType.radio:
        return _buildRadioField(
          context,
          selectedValue: resolvedValue?.toString(),
          onChanged: (value) => onValueChanged?.call(value),
          onSaved: (value) => onValueSaved?.call(value),
          validator: _validateSelection,
          enabled: isInteractive,
        );
      default:
        return Text(
          'Unsupported field type: ${field.type}',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontStyle: FontStyle.italic,
          ),
        );
    }
  }

  DateTime? _parseDateValue(dynamic value) {
    if (value is DateTime) {
      return value;
    }

    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }

    return null;
  }

  String? _validateTextValue(String? value) {
    if (field.required == true && (value == null || value.trim().isEmpty)) {
      return '${field.label ?? 'This field'} is required.';
    }

    return null;
  }

  String? _validateSelection(String? value) {
    if (field.required == true && (value == null || value.isEmpty)) {
      return 'Please select ${field.label ?? 'a value'}.';
    }

    return null;
  }

  String? _validateCheckbox(bool? value) {
    if (field.required == true && value != true) {
      return 'Please confirm ${field.label ?? 'this option'}.';
    }

    return null;
  }

  String? _validateDate(DateTime? value) {
    if (field.required == true && value == null) {
      return 'Please select ${field.label ?? 'a date'}.';
    }

    return null;
  }

  Widget _buildTextField(
    BuildContext context, {
    String? initialValue,
    String? hint,
    IconData? icon,
    bool? enabled,
    bool obscureText = false,
    Widget? suffix,
    TextInputAction? textInputAction,
    void Function(String)? onFieldSubmitted,
    ValueChanged<String>? onChanged,
    FormFieldSetter<String>? onSaved,
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
            field.label ?? '',
            style: theme.textTheme.labelMedium?.copyWith(
              color: scheme.outline,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.3,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          enabled: enabled,
          obscureText: obscureText,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          onSaved: onSaved,
          validator: validator,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: scheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: icon != null
                ? Icon(
                    icon,
                    color: scheme.onSurfaceVariant,
                    size: 20,
                  )
                : null,
            suffixIcon: suffix,
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

  Widget _buildDropDownField(
    BuildContext context, {
    String? selectedValue,
    List<String>? options,
    ValueChanged<String?>? onChanged,
    FormFieldSetter<String>? onSaved,
    String? Function(String?)? validator,
    bool enabled = true,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    // Get options from field.options or use default
    List<String> dropdownOptions;
    if (field.options != null && field.options!.isNotEmpty) {
      dropdownOptions = field.options!;
    } else if (options != null && options.isNotEmpty) {
      dropdownOptions = options;
    } else {
      dropdownOptions = ['Option 1', 'Option 2', 'Option 3'];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            field.label ?? '',
            style: theme.textTheme.labelMedium?.copyWith(
              color: scheme.outline,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.3,
            ),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedValue,
          onChanged: enabled ? (onChanged ?? (val) {}) : null,
          onSaved: onSaved,
          validator: validator,
          items: dropdownOptions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: scheme.onSurface,
                ),
              ),
            );
          }).toList(),
          decoration: InputDecoration(
            hintText: field.placeholder ?? 'Select an option',
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
          icon: Icon(
            Icons.arrow_drop_down,
            color: scheme.onSurfaceVariant,
          ),
          dropdownColor: scheme.surfaceContainer,
        ),
      ],
    );
  }

  Widget _buildCheckboxField(
    BuildContext context, {
    bool? value,
    ValueChanged<bool?>? onChanged,
    FormFieldSetter<bool>? onSaved,
    String? Function(bool?)? validator,
    bool enabled = true,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return FormField<bool>(
      initialValue: value ?? false,
      validator: validator,
      onSaved: onSaved,
      builder: (fieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: fieldState.value ?? false,
                    onChanged: enabled
                        ? (nextValue) {
                            fieldState.didChange(nextValue ?? false);
                            onChanged?.call(nextValue ?? false);
                          }
                        : null,
                    activeColor: scheme.primary,
                    checkColor: scheme.onPrimary,
                    side: BorderSide(
                      color: scheme.outline,
                      width: 2,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      field.label ?? '',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: scheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (field.placeholder != null && field.placeholder!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 4),
                child: Text(
                  field.placeholder!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            if (fieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Text(
                  fieldState.errorText ?? '',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.error,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildDateField(
    BuildContext context, {
    DateTime? selectedDate,
    ValueChanged<DateTime?>? onChanged,
    FormFieldSetter<DateTime>? onSaved,
    String? Function(DateTime?)? validator,
    bool enabled = true,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return FormField<DateTime>(
      initialValue: selectedDate,
      validator: validator,
      onSaved: onSaved,
      builder: (fieldState) {
        final activeDate = fieldState.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                field.label ?? '',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: scheme.outline,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: enabled
                  ? () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: activeDate ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        builder: (context, child) {
                          return Theme(
                            data: theme.copyWith(
                              colorScheme: scheme,
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (date != null) {
                        fieldState.didChange(date);
                        onChanged?.call(date);
                      }
                    }
                  : null,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: scheme.onSurfaceVariant,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        activeDate != null
                            ? '${activeDate.day}/${activeDate.month}/${activeDate.year}'
                            : field.placeholder ?? 'Select date',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: activeDate != null
                              ? scheme.onSurface
                              : scheme.onSurfaceVariant,
                          fontStyle: activeDate != null
                              ? FontStyle.normal
                              : FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (fieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Text(
                  fieldState.errorText ?? '',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.error,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildTextAreaField(
    BuildContext context, {
    String? initialValue,
    String? Function(String?)? validator,
    bool enabled = true,
    ValueChanged<String>? onChanged,
    FormFieldSetter<String>? onSaved,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            field.label ?? '',
            style: theme.textTheme.labelMedium?.copyWith(
              color: scheme.outline,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.3,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          enabled: enabled,
          maxLines: 4,
          minLines: 3,
          onChanged: onChanged,
          onSaved: onSaved,
          validator: validator,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: scheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: field.placeholder ?? 'Enter text...',
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

  Widget _buildRadioField(
    BuildContext context, {
    String? selectedValue,
    List<String>? options,
    ValueChanged<String?>? onChanged,
    FormFieldSetter<String>? onSaved,
    String? Function(String?)? validator,
    bool enabled = true,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final radioOptions = field.options ?? ['Option 1', 'Option 2', 'Option 3'];

    return FormField<String>(
      initialValue: selectedValue,
      validator: validator,
      onSaved: onSaved,
      builder: (fieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                field.label ?? '',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: scheme.outline,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: radioOptions.map((String option) {
                  return RadioListTile<String>(
                    value: option,
                    groupValue: fieldState.value,
                    onChanged: enabled
                        ? (value) {
                            fieldState.didChange(value);
                            onChanged?.call(value);
                          }
                        : null,
                    title: Text(
                      option,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurface,
                      ),
                    ),
                    activeColor: scheme.primary,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  );
                }).toList(),
              ),
            ),
            if (fieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Text(
                  fieldState.errorText ?? '',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.error,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
