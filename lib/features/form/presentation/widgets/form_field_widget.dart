import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/enums/form_field_type.dart';
import 'package:venue_flow_app/core/theme/app_theme.dart';
import 'package:venue_flow_app/features/form/data/form_validation_provider.dart';
import 'package:venue_flow_app/features/form/domain/form_field_schema.dart';
import '../../../../../core/theme/theme_x.dart';

class FormFieldWidget extends ConsumerStatefulWidget {
  const FormFieldWidget({
    super.key,
    required this.formFieldSchema,
    this.isLoading = false,
  });

  final FormFieldSchema formFieldSchema;
  final bool isLoading;

  @override
  ConsumerState<FormFieldWidget> createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends ConsumerState<FormFieldWidget> {
  TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _editingController.text = widget.formFieldSchema.value ?? '';
  }

  String? _validateField(String? value) {
    final validationService = ref.read(formValidationServiceProvider);

    return validationService.validate(
      field: widget.formFieldSchema,
      value: value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    const _wideBreakpoint = 1000.0;
    final wide = MediaQuery.of(context).size.width >= _wideBreakpoint;

    return Column(
      children: [_determineFieldType(cs: cs, sem: sem)],
    );
  }

  Widget _determineFieldType({
    required ColorScheme cs,
    required AppSemanticColors sem,
  }) {
    switch (widget.formFieldSchema.fieldType) {
      case FormFieldType.Text:
        return _buildTextField(cs: cs, sem: sem);
      case FormFieldType.IntField:
        return _buildIntField(cs: cs, sem: sem);
      case FormFieldType.DatePicker:
        return _buildDateField(cs: cs, sem: sem);
      case FormFieldType.TextArea:
        return _buildTextAreaField(cs: cs, sem: sem);
      default:
        throw new UnimplementedError(
          'FormFieldType ${widget.formFieldSchema.fieldType} is not implemented yet',
        );
    }
  }

  Widget _buildDateField({
    required ColorScheme cs,
    required AppSemanticColors sem,
  }) {
    return TextFormField(
      enabled: !widget.isLoading,
      controller: _editingController,
      readOnly: true,
      decoration: _buildInputDecoration(
        label: widget.formFieldSchema.title ?? '',
        cs: cs,
        hintText: widget.formFieldSchema.hintText ?? 'Select a date',
        prefixIcon: Icons.calendar_today_rounded,
      ),
      validator: _validateField,
      onTap: () async {
        final now = DateTime.now();

        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.tryParse(_editingController.text) ?? now,
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(colorScheme: cs),
              child: child!,
            );
          },
        );

        if (selectedDate != null) {
          setState(() {
            _editingController.text =
                '${selectedDate.year.toString().padLeft(4, '0')}-'
                '${selectedDate.month.toString().padLeft(2, '0')}-'
                '${selectedDate.day.toString().padLeft(2, '0')}';
          });
        }
      },
    );
  }

  Widget _buildIntField({
    required ColorScheme cs,
    required AppSemanticColors sem,
  }) {
    return TextFormField(
      enabled: !widget.isLoading,
      controller: _editingController,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: _buildInputDecoration(
        label: widget.formFieldSchema.title ?? '',
        cs: cs,
        hintText: widget.formFieldSchema.hintText,
        prefixIcon: Icons.numbers,
      ),
      validator: _validateField,
    );
  }

  Widget _buildTextField({
    required ColorScheme cs,
    required AppSemanticColors sem,
  }) {
    return TextFormField(
      enabled: !widget.isLoading,
      controller: _editingController,
      keyboardType: TextInputType.emailAddress,
      decoration: _buildInputDecoration(
        label: widget.formFieldSchema.title ?? '',
        cs: cs,
        hintText: widget.formFieldSchema.hintText,
        prefixIcon: Icons.mail_outline_rounded,
      ),
      validator: _validateField,
    );
  }

  Widget _buildTextAreaField({
    required ColorScheme cs,
    required AppSemanticColors sem,
  }) {
    return TextFormField(
      maxLines: 3,
      minLines: 2,
      enabled: !widget.isLoading,
      controller: _editingController,
      keyboardType: TextInputType.emailAddress,
      decoration: _buildInputDecoration(
        label: widget.formFieldSchema.title ?? '',
        cs: cs,
        hintText: widget.formFieldSchema.hintText,
        prefixIcon: Icons.mail_outline_rounded,
      ),
      validator: _validateField,
    );
  }

  InputDecoration _buildInputDecoration({
    required ColorScheme cs,
    String? hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
    required String label,
  }) {
    return InputDecoration(
      label: Text(label),
      hintText: hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintStyle: TextStyle(
        color: cs.onSurface.withValues(alpha: 0.6),
        fontSize: 14,
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: cs.onSurface.withValues(alpha: 0.6),
        size: 20,
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: cs.inversePrimary.withValues(alpha: 0.05),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: cs.onSurface.withValues(alpha: 0.1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: cs.onSurface.withValues(alpha: 0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: cs.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: cs.error, width: 2),
      ),
    );
  }
}
