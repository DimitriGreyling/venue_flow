// lib/models/user_model.dart
import 'package:venue_flow_app/models/enums.dart';

class UserModel {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final UserRole role;
  final String? tenantId;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    required this.role,
    this.tenantId,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      role: UserRole.values.byName(json['role']),
      tenantId: json['tenant_id'],
      isActive: json['is_active'] ?? true,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'role': role.name,
      'tenant_id': tenantId,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    }
    return email;
  }

  bool get isCoordinator => role == UserRole.coordinator || role == UserRole.admin;
  bool get isClient => role == UserRole.client;
}



