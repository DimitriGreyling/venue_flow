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
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _getFieldTypeColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getFieldTypeIcon(),
                        size: 16,
                        color: _getFieldTypeColor(),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Field label
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            field.label ?? '',
                            style: editorial.labelBold.copyWith(
                              color: colorScheme.onSurface,
                              fontSize: 15,
                            ),
                          ),
                          if (field.required ?? false)
                            Text(
                              'Required',
                              style: editorial.labelSubtle.copyWith(
                                color: colorScheme.error,
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    ),

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
                        child: Text(
                          field.placeholder ?? 'No placeholder...',
                          style: editorial.placeholderStyle.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
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
}
