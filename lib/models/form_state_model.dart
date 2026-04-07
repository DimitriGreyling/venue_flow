class FormStateModel {
  Map<String, dynamic>? values;
  Map<String, String?>? errors;

  FormStateModel({
     this.values,
     this.errors,
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
