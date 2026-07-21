import '../domain/customer_entity.dart';

class CustomerDto {
  final String id;
  final String fullName;
  final String email;
  final String? phone;

  CustomerDto({
    required this.id,
    required this.fullName,
    required this.email,
    this.phone,
  });

  factory CustomerDto.fromJson(Map<String, dynamic> json) {
    return CustomerDto(
      id: json['id'].toString(),
      fullName: (json['fullName'] ?? json['name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      phone: json['phone']?.toString(),
    );
  }

  CustomerEntity toEntity() => CustomerEntity(
        id: id,
        fullName: fullName,
        email: email,
        phone: phone,
      );
}