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
  });

  factory DynamicFormModel.fromJson(Map<String, dynamic> json) {
    List<FormPageModel>? pages;

    // ✅ Handle different JSON structures
    if (json['schema'] != null) {
      if (json['schema'] is List) {
        // Direct array: "schema": [{"title": "Page 1", ...}]
        pages = (json['schema'] as List)
            .map((e) => FormPageModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (json['schema'] is Map && json['schema']['pages'] != null) {
        // Nested structure: "schema": {"pages": [...]}
        pages = (json['schema']['pages'] as List)
            .map((e) => FormPageModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } else if (json['pages'] != null) {
      // Direct pages field: "pages": [...]
      pages = (json['pages'] as List)
          .map((e) => FormPageModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    final resp = DynamicFormModel(
      id: json['id'],
      name: json['name'] ?? '',
      version: json['version'] ?? 1,
      schema: pages,
      formStatus: json['status'] != null
          ? FormStatus.values.byName(json['status'])
          : null,
      isActive: json['is_active'] as bool? ?? false,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.tryParse(json['created_at']),
      modifiedDate: json['modified_date'] == null
          ? null
          : DateTime.tryParse(json['modified_date']),
      tenantId: json['tenant_id'],
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
      schema: pages ?? this.schema,
      version: version ?? this.version,
      formStatus: formStatus ?? this.formStatus,
      createdAt: createdAt ?? this.createdAt,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      tenantId: tenantId ?? this.tenantId,
    );
  }

  Map<String, dynamic> toJson() {
    try {
      final Map<String, dynamic> myObjec = {
        if (id != null) 'id': id,
        'name': name,
        'version': version,
        'schema': schema?.map((x) => x.toJson()).toList(),
        'status': formStatus?.name,
        'is_active': isActive,
        'created_at': createdAt?.toIso8601String(),
        'modified_date': DateTime.now().toIso8601String(),
        'tenant_id': tenantId,
      };

      return myObjec;
    } catch (error) {
      log('toJson ERROR:: ${error}');
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
    } catch (error, stackTrace) {
      log('TOJSONSTRING ERROR:: ${error}');
      return '';
    }
  }
}
