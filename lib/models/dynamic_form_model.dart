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
      pages: (json['schema']['pages'] as List)
          .map((e) => FormPageModel.fromJson(e))
          .toList(),
    );

    return resp;
  }
}
