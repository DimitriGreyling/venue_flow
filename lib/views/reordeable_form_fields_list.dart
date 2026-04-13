import 'package:flutter/material.dart';
import 'package:venue_flow_app/models/form_field_model.dart';
import 'package:venue_flow_app/views/reordeable_form_field_tile.dart';
import '../theme/editorial_theme_data.dart';

class ReorderableFormFieldsList extends StatefulWidget {
  final List<FormFieldModel> fields;
  final String? selectedFieldId;
  final Function(List<FormFieldModel> reorderedFields)? onReorder;
  final Function(FormFieldModel field)? onEditClicked;
  final Function(FormFieldModel field, int index)? onFieldDeleted;
  final Function(FormFieldModel field)? onFieldDuplicated;
  final ColorScheme colorScheme;
  final EditorialThemeData editorial;
  final bool? isClient;

  const ReorderableFormFieldsList({
    Key? key,
    required this.fields,
    required this.colorScheme,
    required this.editorial,
    this.selectedFieldId,
    this.onReorder,
    this.onEditClicked,
    this.onFieldDeleted,
    this.onFieldDuplicated,
    this.isClient = false,
  }) : super(key: key);

  @override
  State<ReorderableFormFieldsList> createState() =>
      _ReorderableFormFieldsListState();
}

class _ReorderableFormFieldsListState extends State<ReorderableFormFieldsList> {
  late List<FormFieldModel> _fields;

  @override
  void initState() {
    super.initState();
    _fields = List.from(widget.fields);
  }

  @override
  void didUpdateWidget(ReorderableFormFieldsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (widget.fields != oldWidget.fields) {
    _fields = List.from(widget.fields);
    // }
  }

  // void _handleReorder(int oldIndex, int newIndex) {
  //   setState(() {
  //     // Handle the reordering logic
  //     if (newIndex > oldIndex) {
  //       newIndex -= 1;
  //     }
  //     final item = _fields.removeAt(oldIndex);
  //     _fields.insert(newIndex, item);
  //   });

  //   // Call the callback
  //   widget.onReorder?.call(oldIndex, newIndex,);
  // }

  List<FormFieldModel> _reorderFields(
      List<FormFieldModel> fields, int oldIndex, int newIndex) {
    final List<FormFieldModel> reorderedFields = List.from(fields);

    // Handle the reordering logic
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final item = reorderedFields.removeAt(oldIndex);
    reorderedFields.insert(newIndex, item);

    return reorderedFields;
  }

  void _handleReorder(int oldIndex, int newIndex) {
    // Create reordered list
    final reorderedFields = _reorderFields(_fields, oldIndex, newIndex);

    setState(() {
      _fields = reorderedFields;
    });

    // ✅ Pass the reordered list to parent
    widget.onReorder?.call(reorderedFields);
  }

  @override
  Widget build(BuildContext context) {
    if (_fields.isEmpty) {
      return _buildEmptyState();
    }

    return ReorderableListView.builder(
      padding: const EdgeInsets.all(16),
      onReorder: _handleReorder,
      itemCount: _fields.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      buildDefaultDragHandles: false, // We'll build our own drag handles
      itemBuilder: (context, index) {
        final field = _fields[index];
        final isSelected = field.id == widget.selectedFieldId;

        return ReorderableDelayedDragStartListener(
          key:
              Key('${field.id ?? field.label ?? field.type.toString()}-$index'),
          index: index,
          child: ReorderableFormFieldTile(
            field: field,
            isSelected: isSelected,
            colorScheme: widget.colorScheme,
            editorial: widget.editorial,
            isClient: widget.isClient,
            onEditClicked: widget.isClient == true
                ? null
                : () => widget.onEditClicked?.call(field),
            onDelete: widget.isClient == true
                ? null
                : () => widget.onFieldDeleted?.call(field, index),
            onDuplicate: widget.isClient == true
                ? null
                : () => widget.onFieldDuplicated?.call(field),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Container(
      // padding: const EdgeInsets.all(48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.view_list,
            size: 64,
            color: widget.colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No form fields yet',
            style: widget.editorial.labelBold.copyWith(
              color: widget.colorScheme.onSurfaceVariant,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add fields from the sidebar to start building your form',
            style: widget.editorial.labelSubtle.copyWith(
              color: widget.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
