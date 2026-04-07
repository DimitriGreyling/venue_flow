class FormSubmission {
  String? formId;
  String? userId;
  int? formVersion;
  Map<String, dynamic>? data;
  DateTime? createdAt;

  FormSubmission({
     this.formId,
     this.userId,
     this.formVersion,
     this.data,
     this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'form_id': formId,
      'user_id': userId,
      'form_version': formVersion,
      'data': data,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
