import 'package:venue_flow_app/core/enums/form_field_type.dart';
import 'package:venue_flow_app/features/form/domain/form_field_schema.dart';

class FormValidationService {
  const FormValidationService();

  String? validate({required FormFieldSchema field, required String? value}) {
    final input = value?.trim() ?? '';

    // Required validation applies to every field type.
    if ((field.isRequired ?? false) && input.isEmpty) {
      return '${field.title ?? 'This field'} is required.';
    }

    // Optional fields may remain empty.
    if (input.isEmpty) {
      return null;
    }

    switch (field.fieldType) {
      case FormFieldType.Text:
        return _validateText(field, input);

      // Add cases for Email, Number, Phone, etc.
      // when those values exist in your FormFieldType enum.
      default:
        return null;
    }
  }

  String? _validateText(FormFieldSchema field, String value) {
    // Add text-specific rules here.
    return null;
  }
}
