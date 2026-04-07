import 'package:venue_flow_app/models/form_field_model.dart';

class FormPageModel {
  String? id;
  String? title;
  List<FormFieldModel>? fields;

  FormPageModel({
    this.id,
    this.title,
    this.fields,
  });

  factory FormPageModel.fromJson(Map<String, dynamic> json) {
    return FormPageModel(
      id: json['id'],
      title: json['title'] ?? '',
      fields: (json['fields'] as List?)
          ?.map((e) => FormFieldModel.fromJson(e))
          .toList(),
    );
  }
}
