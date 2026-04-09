import 'dart:convert';
import 'dart:developer';

import 'package:venue_flow_app/models/form_page_model.dart';

class DynamicFormModel {
  String? id;
  String? name;
  int? version;
  List<FormPageModel>? pages;

  DynamicFormModel({
    this.id,
    this.name,
    this.version,
    this.pages,
  });

  factory DynamicFormModel.fromJson(Map<String, dynamic> json) {
    final resp = DynamicFormModel(
      id: json['id'],
      name: json['name'] ?? '',
      version: json['version'] ?? 1,
      pages: (json['pages'] != null)
          ? (json['pages'] as List)
              .map((e) => FormPageModel.fromJson(e))
              .toList()
          : (json['schema']['pages'] as List)
              .map((e) => FormPageModel.fromJson(e))
              .toList(),
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
      pages: pages ?? this.pages,
      version: version ?? this.version,
    );
  }

  Map<String, dynamic> toJson() {
    try {
      final Map<String, dynamic> myObjec = {
        'id': id,
        'name': name,
        'version': version,
        'pages': pages?.map((x) => x.toJson()).toList(),
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
