import 'package:venue_flow_app/models/form_field_model.dart';

class FormPageModel {
  final String id;
  final String title;
  final List<FormFieldModel> fields;

  FormPageModel({
    required this.id,
    required this.title,
    required this.fields,
  });

  factory FormPageModel.fromJson(Map<String, dynamic> json) {
    return FormPageModel(
      id: json['id'],
      title: json['title'] ?? '',
      fields: (json['fields'] as List)
          .map((e) => FormFieldModel.fromJson(e))
          .toList(),
    );
  }
}