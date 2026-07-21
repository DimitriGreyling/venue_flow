class CustomerEntity {
  final String id;
  final String fullName;
  final String email;
  final String? phone;

  const CustomerEntity({
    required this.id,
    required this.fullName,
    required this.email,
    this.phone,
  });
}