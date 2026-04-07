class FormSubmission {
  final String formId;
  final String userId;
  final int formVersion;
  final Map<String, dynamic> data;
  final DateTime createdAt;

  FormSubmission({
    required this.formId,
    required this.userId,
    required this.formVersion,
    required this.data,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'form_id': formId,
      'user_id': userId,
      'form_version': formVersion,
      'data': data,
      'created_at': createdAt.toIso8601String(),
    };
  }
}