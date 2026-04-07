import 'package:venue_flow_app/models/form_page_model.dart';

class DynamicFormModel {
  String? id;
  String? name;
  int? version;
  List<FormPageModel>? pages;

  DynamicFormModel({
    required this.id,
    required this.name,
    required this.version,
    required this.pages,
  });

  factory DynamicFormModel.fromJson(Map<String, dynamic> json) {
    return DynamicFormModel(
      id: json['id'],
      name: json['name'] ?? '',
      version: json['version'] ?? 1,
      pages: (json['pages'] as List)
          .map((e) => FormPageModel.fromJson(e))
          .toList(),
    );
  }
}