import 'package:flutter/material.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/models/form_field_model.dart';
import '../theme/editorial_theme_data.dart';

class ReorderableFormFieldTile extends StatelessWidget {
  final FormFieldModel field;
  final bool isSelected;
  final VoidCallback? onEditClicked;
  final VoidCallback? onDelete;
  final VoidCallback? onDuplicate;
  final ColorScheme colorScheme;
  final EditorialThemeData editorial;

  const ReorderableFormFieldTile({
    Key? key,
    required this.field,
    required this.isSelected,
    required this.colorScheme,
    required this.editorial,
    this.onEditClicked,
    this.onDelete,
    this.onDuplicate,
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
                color: isSelected ? colorScheme.secondary : Colors.transparent,
                width: isSelected ? 2 : 1,
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
                    if (isSelected) ...[
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
                    border: Border.all(color: colorScheme.outlineVariant),
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
                      if (_hasTrailingIcon())
                        Icon(
                          _getTrailingIcon(),
                          color: colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
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

    switch (field.type) {
      case FieldType.text:
        return _buildTextField(context);
      case FieldType.dropdown:
        return _buildDropDownField(context);
      case FieldType.checkbox:
        return _buildCheckboxField(context);
      case FieldType.date:
        return _buildDateField(context);
      case FieldType.textarea:
        return _buildTextAreaField(context);
      case FieldType.radio:
        return _buildRadioField(context);
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

  Widget _buildTextField(
    BuildContext context, {
    TextEditingController? controller,
    FocusNode? focusNode,
    String? hint,
    IconData? icon,
    bool? enabled,
    bool obscureText = false,
    Widget? suffix,
    TextInputAction? textInputAction,
    void Function(String)? onFieldSubmitted,
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
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          obscureText: obscureText,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
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
    String? Function(String?)? validator,
    bool enabled = true,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    // Get options from field.options or use default
    final dropdownOptions = field.options ?? ['Option 1', 'Option 2', 'Option 3'];

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
          onChanged: enabled ? onChanged : null,
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
    bool enabled = true,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

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
                value: value ?? false,
                onChanged: enabled ? onChanged : null,
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
      ],
    );
  }

  Widget _buildDateField(
    BuildContext context, {
    DateTime? selectedDate,
    ValueChanged<DateTime?>? onChanged,
    String? Function(DateTime?)? validator,
    bool enabled = true,
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
        InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: enabled
              ? () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
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
                  if (date != null && onChanged != null) {
                    onChanged(date);
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
                    selectedDate != null
                        ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
                        : field.placeholder ?? 'Select date',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: selectedDate != null
                          ? scheme.onSurface
                          : scheme.onSurfaceVariant,
                      fontStyle: selectedDate != null
                          ? FontStyle.normal
                          : FontStyle.italic,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: scheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextAreaField(
    BuildContext context, {
    TextEditingController? controller,
    FocusNode? focusNode,
    String? Function(String?)? validator,
    bool enabled = true,
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
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          maxLines: 4,
          minLines: 3,
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
    bool enabled = true,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    // Get options from field.options or use default
    final radioOptions = field.options ?? ['Option 1', 'Option 2', 'Option 3'];

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
                groupValue: selectedValue,
                onChanged: enabled ? onChanged : null,
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
      ],
    );
  }
}
