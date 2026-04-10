// lib/models/tenant_model.dart  
class TenantModel {
  final String id;
  final String name;
  final String slug;
  final bool isActive;
  final String subscriptionStatus;
  final DateTime createdAt;
  final DateTime? updatedAt;

  TenantModel({
    required this.id,
    required this.name,
    required this.slug,
    this.isActive = true,
    this.subscriptionStatus = 'trial',
    required this.createdAt,
    this.updatedAt,
  });

  factory TenantModel.fromJson(Map<String, dynamic> json) {
    return TenantModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      isActive: json['is_active'] ?? true,
      subscriptionStatus: json['subscription_status'] ?? 'trial',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
    );
  }
}