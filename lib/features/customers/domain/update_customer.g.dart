// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateCustomer _$UpdateCustomerFromJson(Map<String, dynamic> json) =>
    _UpdateCustomer(
      userId: json['userId'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$UpdateCustomerToJson(_UpdateCustomer instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
    };
