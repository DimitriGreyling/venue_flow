class FormStateModel {
  final Map<String, dynamic> values;
  final Map<String, String?> errors;

  FormStateModel({
    required this.values,
    required this.errors,
  });

  FormStateModel copyWith({
    Map<String, dynamic>? values,
    Map<String, String?>? errors,
  }) {
    return FormStateModel(
      values: values ?? this.values,
      errors: errors ?? this.errors,
    );
  }
}