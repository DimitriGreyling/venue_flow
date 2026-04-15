import 'package:venue_flow_app/models/dynamic_form_model.dart';
import 'package:venue_flow_app/models/user_model.dart';

class FormSubmission {
  String? formId;
  String? userId;
  int? formVersion;
  Map<String, dynamic>? data;
  DateTime? createdAt;

  FormSubmission({
     this.formId,
     this.userId,
     this.formVersion,
     this.data,
     this.createdAt,
  });

  factory FormSubmission.fromFormValues({
    required DynamicFormModel form,
    required UserModel user,
    required Map<String, dynamic> values,
  }) {
    return FormSubmission(
      formId: form.id,
      userId: user.id,
      formVersion: form.version,
      data: {
        'responses': _normalizeValues(values),
        'fields': _buildFieldSnapshots(form, values),
      },
      createdAt: DateTime.now(),
    );
  }

  static Map<String, dynamic> _normalizeValues(Map<String, dynamic> values) {
    final normalized = <String, dynamic>{};

    values.forEach((key, value) {
      if (value == null) {
        return;
      }

      if (value is String) {
        final trimmed = value.trim();
        if (trimmed.isEmpty) {
          return;
        }

        normalized[key] = trimmed;
        return;
      }

      if (value is DateTime) {
        normalized[key] = value.toIso8601String();
        return;
      }

      normalized[key] = value;
    });

    return normalized;
  }

  static List<Map<String, dynamic>> _buildFieldSnapshots(
    DynamicFormModel form,
    Map<String, dynamic> values,
  ) {
    final schema = form.schema ?? const [];
    final snapshots = <Map<String, dynamic>>[];

    for (var pageIndex = 0; pageIndex < schema.length; pageIndex++) {
      final page = schema[pageIndex];
      final fields = page.fields ?? const [];

      for (var fieldIndex = 0; fieldIndex < fields.length; fieldIndex++) {
        final field = fields[fieldIndex];
        final fieldKey = field.submissionKey(
          pageIndex: pageIndex,
          fieldIndex: fieldIndex,
        );

        if (!values.containsKey(fieldKey)) {
          continue;
        }

        snapshots.add({
          'page_id': page.id,
          'page_title': page.title,
          'field_id': field.id,
          'field_key': fieldKey,
          'field_label': field.label,
          'field_type': field.type?.name,
          'value': values[fieldKey] is DateTime
              ? (values[fieldKey] as DateTime).toIso8601String()
              : values[fieldKey],
        });
      }
    }

    return snapshots;
  }

  Map<String, dynamic> toJson() {
    return {
      'form_id': formId,
      'user_id': userId,
      'form_version': formVersion,
      'data': data,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
