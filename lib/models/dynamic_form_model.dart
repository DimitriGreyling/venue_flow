import 'dart:convert';
import 'dart:developer';

import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/models/form_page_model.dart';

class DynamicFormModel {
  String? id;
  String? name;
  int? version;
  FormStatus? formStatus;
  List<FormPageModel>? schema;
  bool? isActive;
  DateTime? createdAt;
  DateTime? modifiedDate;
  String? tenantId;
  List<FormPageModel>? draftSchema;

  DynamicFormModel({
    this.id,
    this.name,
    this.version,
    this.schema,
    this.formStatus,
    this.isActive,
    this.createdAt,
    this.modifiedDate,
    this.tenantId,
    this.draftSchema,
  });

  factory DynamicFormModel.fromJson(Map<String, dynamic> json) {
    List<FormPageModel>? pages;
    List<FormPageModel>? draftPges;

    // ✅ Handle different JSON structures
    if (json['formConfig'] != null) {
      if (json['formConfig'] is List) {
        // Direct array: "schema": [{"title": "Page 1", ...}]
        pages =
            (json['formConfig'] as List)
                .map((e) => FormPageModel.fromJson(e as Map<String, dynamic>))
                .toList();
      } else if (json['formConfig'] is Map && json['formConfig']['pages'] != null) {
        // Nested structure: "schema": {"pages": [...]}
        pages =
            (json['formConfig']['pages'] as List)
                .map((e) => FormPageModel.fromJson(e as Map<String, dynamic>))
                .toList();
      }
    } else if (json['pages'] != null) {
      // Direct pages field: "pages": [...]
      pages =
          (json['pages'] as List)
              .map((e) => FormPageModel.fromJson(e as Map<String, dynamic>))
              .toList();
    }

    if (json['draftFormConfig'] != null) {
      if (json['draftFormConfig'] is List) {
        // Direct array: "schema": [{"title": "Page 1", ...}]
        draftPges =
            (json['draftFormConfig'] as List)
                .map((e) => FormPageModel.fromJson(e as Map<String, dynamic>))
                .toList();
      } else if (json['draftFormConfig'] is Map &&
          json['draftFormConfig']['pages'] != null) {
        // Nested structure: "schema": {"pages": [...]}
        draftPges =
            (json['draftFormConfig']['pages'] as List)
                .map((e) => FormPageModel.fromJson(e as Map<String, dynamic>))
                .toList();
      }
    } else if (json['pages'] != null) {
      // Direct pages field: "pages": [...]
      draftPges =
          (json['pages'] as List)
              .map((e) => FormPageModel.fromJson(e as Map<String, dynamic>))
              .toList();
    }

    final resp = DynamicFormModel(
      id: json['id'],
      name: json['name'] ?? '',
      version: json['formVersion'] ?? 1,
      schema: pages,
      formStatus:
          json['status'] != null
              ? json['status'] is String
                  ? FormStatus.values.byName(json['status'])
                  : FormStatus.values[json['status']]
              : null,
      isActive: json['isActive'] as bool? ?? false,
      createdAt:
          json['createdDate'] == null
              ? null
              : DateTime.tryParse(json['createdDate']),
      modifiedDate:
          json['modifiedDate'] == null
              ? null
              : DateTime.tryParse(json['modifiedDate']),
      tenantId: json['tenantId'],
      draftSchema: draftPges,
    );

    return resp;
  }

  DynamicFormModel copyWith({
    String? id,
    String? name,
    int? version,
    List<FormPageModel>? pages,
  }) {
    return DynamicFormModel(
      id: id ?? this.id,
      name: name ?? this.name,
      schema: pages ?? schema,
      version: version ?? this.version,
      formStatus: formStatus ?? formStatus,
      createdAt: createdAt ?? createdAt,
      modifiedDate: modifiedDate ?? modifiedDate,
      tenantId: tenantId ?? tenantId,
    );
  }

  Map<String, dynamic> toJson() {
    try {


      final Map<String, dynamic> myObjec = {
        if (id != null) 'id': id,
        'name': name,
        'version': version,
        'formConfig': schema?.map((x) => x.toJson()).toList(),
        'status': formStatus?.index,
        'is_active': isActive,
        'created_at':
            createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        'modified_date': DateTime.now().toIso8601String(),
        'tenant_id': tenantId,
        'draftFormConfig': draftSchema?.map((x) => x.toJson()).toList(),
      };

      log('toJson output: $myObjec');

      return myObjec;
    } catch (error) {
      log('toJson ERROR:: $error');
      return {};
    }
  }

  //toString
  @override
  String toString() => toJsonString();

  //toJsonString
  String toJsonString() {
    try {
      return jsonEncode(toJson());
    } catch (error) {
      log('TOJSONSTRING ERROR:: $error');
      return '';
    }
  }
}
