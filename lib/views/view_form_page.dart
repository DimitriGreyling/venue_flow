import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/models/form_field_model.dart';
import 'package:venue_flow_app/models/form_page_model.dart';
import 'package:venue_flow_app/providers/viewmodel_provider.dart';

class ViewFormPage extends ConsumerStatefulWidget {
  final String? formId;
  const ViewFormPage({super.key, this.formId});

  @override
  ConsumerState<ViewFormPage> createState() => _ViewFormPageState();
}

class _ViewFormPageState extends ConsumerState<ViewFormPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _answers = {};
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(formViewBuilderViewModelProvider.notifier).loadForm(
          // formId: widget.formId ?? '',
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(formViewBuilderViewModelProvider);
    final form = formState.form.isNotEmpty ? formState.form.first : null;
    final pages = form?.schema ?? const <FormPageModel>[];

    log('LOADING :: ${formState.isLoading}');

    if (formState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (form == null || pages.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('No form available'),
        ),
      );
    }

    final currentPage = pages[_currentPageIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(form.name ?? 'Form Viewer'),
      ),
      body: Column(children: [
        if (form.schema != null)
          ...form.schema!.map((page) {
            return Container(
              child: Text(page.title ?? ''),
            );
          }),
      ]),
    );
  }

  String _fieldKey({
    required int pageIndex,
    required int fieldIndex,
    required FormFieldModel field,
  }) {
    return field.id ?? 'page_${pageIndex}_field_$fieldIndex';
  }

  Widget _buildField({
    required BuildContext context,
    required FormFieldModel field,
    required String fieldKey,
  }) {
    switch (field.type) {
      case FieldType.text:
        return TextFormField(
          initialValue: _answers[fieldKey]?.toString(),
          decoration: InputDecoration(
            labelText: field.label ?? 'Text field',
            hintText: field.placeholder,
            border: const OutlineInputBorder(),
          ),
          validator: (value) => _validateRequired(field, value),
          onChanged: (value) => _answers[fieldKey] = value,
        );

      case FieldType.textarea:
        return TextFormField(
          initialValue: _answers[fieldKey]?.toString(),
          maxLines: 4,
          decoration: InputDecoration(
            labelText: field.label ?? 'Text area',
            hintText: field.placeholder,
            border: const OutlineInputBorder(),
          ),
          validator: (value) => _validateRequired(field, value),
          onChanged: (value) => _answers[fieldKey] = value,
        );

      case FieldType.dropdown:
        final options = field.options ?? const <String>[];
        return DropdownButtonFormField<String>(
          value: _answers[fieldKey] as String?,
          decoration: InputDecoration(
            labelText: field.label ?? 'Select option',
            border: const OutlineInputBorder(),
          ),
          items: options
              .map(
                (option) => DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                ),
              )
              .toList(),
          validator: (value) => _validateRequired(field, value),
          onChanged: (value) {
            // setState(() {
            //   _answers[fieldKey] = value;
            // });
          },
        );

      case FieldType.radio:
        final options = field.options ?? const <String>[];
        final selectedValue = _answers[fieldKey] as String?;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              field.label ?? 'Choose one',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...options.map(
              (option) => RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: selectedValue,
                onChanged: (value) {
                  // setState(() {
                  //   _answers[fieldKey] = value;
                  // });
                },
              ),
            ),
            if (field.required == true && selectedValue == null)
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'This field is required',
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        );

      case FieldType.checkbox:
        final currentValue = (_answers[fieldKey] as bool?) ?? false;

        return CheckboxListTile(
          value: currentValue,
          onChanged: (value) {
            // setState(() {
            //   _answers[fieldKey] = value ?? false;
            // });
          },
          title: Text(field.label ?? 'Checkbox'),
          subtitle: field.placeholder != null ? Text(field.placeholder!) : null,
          controlAffinity: ListTileControlAffinity.leading,
        );

      case FieldType.date:
        final selectedDate = _answers[fieldKey] as DateTime?;

        return InkWell(
          onTap: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );

            if (pickedDate != null) {
              // setState(() {
              //   _answers[fieldKey] = pickedDate;
              // });
            }
          },
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: field.label ?? 'Select date',
              border: const OutlineInputBorder(),
              errorText: field.required == true && selectedDate == null
                  ? 'This field is required'
                  : null,
            ),
            child: Text(
              selectedDate == null
                  ? (field.placeholder ?? 'Choose a date')
                  : '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
            ),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  String? _validateRequired(FormFieldModel field, String? value) {
    if (field.required == true && (value == null || value.trim().isEmpty)) {
      return 'This field is required';
    }
    return null;
  }

  void _handleSubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    debugPrint('Submitted answers: $_answers');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form captured successfully'),
      ),
    );
  }
}
