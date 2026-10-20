// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterCustomer _$RegisterCustomerFromJson(Map<String, dynamic> json) =>
    _RegisterCustomer(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$RegisterCustomerToJson(_RegisterCustomer instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'password': instance.password,
    };
