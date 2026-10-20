import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_customer.freezed.dart';
part 'register_customer.g.dart';

@freezed
abstract class RegisterCustomer with _$RegisterCustomer {
  const factory RegisterCustomer({
    required String firstName,
    required String lastName,
    required String email,
    String? password,
  }) = _RegisterCustomer;

  factory RegisterCustomer.fromJson(Map<String, dynamic> json) =>
      _$RegisterCustomerFromJson(json);
}
