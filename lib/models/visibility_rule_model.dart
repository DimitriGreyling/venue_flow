class VisibilityRule {
  String? fieldId;
  String? operator;
  dynamic? value;

  VisibilityRule({
    this.fieldId,
    this.operator,
    this.value,
  });

  factory VisibilityRule.fromJson(Map<String, dynamic> json) {
    return VisibilityRule(
      fieldId: json['fieldId'],
      operator: json['operator'],
      value: json['value'],
    );
  }
}
