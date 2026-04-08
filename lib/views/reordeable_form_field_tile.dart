import 'package:flutter/material.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/models/form_field_model.dart';
import '../theme/editorial_theme_data.dart';

class ReorderableFormFieldTile extends StatelessWidget {
  final FormFieldModel field;
  final bool isSelected;
  final VoidCallback? onTap;
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
    this.onTap,
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
          onTap: onTap,
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
                   const  Spacer(),

                    // Action buttons (show only when selected)
                    if (isSelected) ...[
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
        return colorScheme.primary;
      // case 'email':
      //   return colorScheme.secondary;
      // case 'date':
      //   return colorScheme.tertiary;
      // case 'select':
      //   return Colors.purple;
      // case 'checkbox':
      //   return Colors.green;
      // case 'file':
      //   return Colors.orange;
      default:
        return colorScheme.primary;
    }
  }

  IconData _getFieldTypeIcon() {
    switch (field.type) {
      case FieldType.text:
        return Icons.short_text;
      case FieldType.dropdown:
        return Icons.drafts;
      // case 'email':
      //   return Icons.email;
      // case 'date':
      //   return Icons.calendar_month;
      // case 'select':
      //   return Icons.list;
      // case 'checkbox':
      //   return Icons.check_box_outlined;
      // case 'file':
      //   return Icons.upload_file;
      default:
        return Icons.short_text;
    }
  }

  bool _hasTrailingIcon() {
    switch (field.type) {
      case 'date':
      case 'select':
        return true;
      default:
        return false;
    }
  }

  IconData _getTrailingIcon() {
    switch (field.type) {
      case 'date':
        return Icons.calendar_today;
      case 'select':
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
      default:
        return Text('No field to show');
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
}
