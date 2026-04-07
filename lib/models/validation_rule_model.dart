class ValidationRule {
  final String type;
  final dynamic value;
  final String? message;

  ValidationRule({
    required this.type,
    this.value,
    this.message,
  });

  factory ValidationRule.fromJson(Map<String, dynamic> json) {
    return ValidationRule(
      type: json['type'],
      value: json['value'],
      message: json['message'],
    );
  }
}