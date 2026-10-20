
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_customer.freezed.dart';
part 'update_customer.g.dart';

@freezed
abstract class UpdateCustomer with _$UpdateCustomer{
  const factory UpdateCustomer({
    required String userId,
    required String firstName,
    required String lastName,
    String? email,
  })=_UpdateCustomer;

  factory UpdateCustomer.fromJson(Map<String, dynamic> json) => _$UpdateCustomerFromJson(json);
}