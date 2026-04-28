import 'dart:convert';
import 'dart:developer';

import 'package:venue_flow_app/models/dynamic_form_model.dart';
import 'package:venue_flow_app/models/user_model.dart';

class FormSubmission {
  String? formId;
  String? userId;
  int? formVersion;
  Map<String, dynamic>? data;
  DateTime? createdAt;
  String? tenantId;

  FormSubmission({
    this.formId,
    this.userId,
    this.formVersion,
    this.data,
    this.createdAt,
    this.tenantId,
  });

  factory FormSubmission.fromFormValues({
    required DynamicFormModel form,
    required UserModel user,
    required Map<String, dynamic> values,
  }) {
    return FormSubmission(
      formId: form.id,
      userId: user.id,
      tenantId: user.tenantId,
      formVersion: form.version ?? 1,
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
      'tenant_id': tenantId,
      'user_id': userId,
      // 'form_version': formVersion,
      'data': data,
      'created_at': createdAt?.toIso8601String() ?? DateTime.now(),
      'modified_date': DateTime.now().toIso8601String(),
    };
  }

  //toString
  @override
  String toString() => toJsonString();

//toJsonString
  String toJsonString() {
    try {
      return jsonEncode(toJson());
    } catch (error, stackTrace) {
      log('TOJSONSTRING ERROR:: ${error}');
      return '';
    }
  }

factory FormSubmission.fromJson(Map<String, dynamic> json) {
  DateTime? parseDate(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is DateTime) {
      return value;
    }
    return DateTime.tryParse(value.toString());
  }

  Map<String, dynamic>? parsedData;
  final rawData = json['data'];

  if (rawData is Map<String, dynamic>) {
    parsedData = Map<String, dynamic>.from(rawData);
  } else if (rawData is Map) {
    parsedData = rawData.map(
      (key, value) => MapEntry(key.toString(), value),
    );
  }

  return FormSubmission(
    formId: json['form_id']?.toString(),
    userId: json['user_id']?.toString(),
    tenantId: json['tenant_id']?.toString(),
    formVersion: json['form_version'] is num
        ? (json['form_version'] as num).toInt()
        : int.tryParse(json['form_version']?.toString() ?? ''),
    data: parsedData,
    createdAt: parseDate(json['created_at']),
  );
}
}
