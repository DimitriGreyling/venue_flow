class ValidationRule {
  String? type;
  dynamic? value;
  String? message;

  ValidationRule({
    this.type,
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
