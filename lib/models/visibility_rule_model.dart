class VisibilityRule {
  final String fieldId;
  final String operator;
  final dynamic value;

  VisibilityRule({
    required this.fieldId,
    required this.operator,
    required this.value,
  });

  factory VisibilityRule.fromJson(Map<String, dynamic> json) {
    return VisibilityRule(
      fieldId: json['fieldId'],
      operator: json['operator'],
      value: json['value'],
    );
  }
}