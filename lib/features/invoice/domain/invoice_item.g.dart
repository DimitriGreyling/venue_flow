// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InvoiceItem _$InvoiceItemFromJson(Map<String, dynamic> json) => _InvoiceItem(
  id: json['id'] as String,
  price: (json['price'] as num).toDouble(),
  quantity: (json['quantity'] as num).toInt(),
  totalAmount: (json['totalAmount'] as num).toDouble(),
  invoiceId: json['invoiceId'] as String,
  description: json['description'] as String,
  email: json['email'] as String?,
);

Map<String, dynamic> _$InvoiceItemToJson(_InvoiceItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'quantity': instance.quantity,
      'totalAmount': instance.totalAmount,
      'invoiceId': instance.invoiceId,
      'description': instance.description,
      'email': instance.email,
    };
