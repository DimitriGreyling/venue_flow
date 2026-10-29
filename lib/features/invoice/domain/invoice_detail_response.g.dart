// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InvoiceDetailResponse _$InvoiceDetailResponseFromJson(
  Map<String, dynamic> json,
) => _InvoiceDetailResponse(
  id: json['id'] as String,
  invoiceNumber: json['invoiceNumber'] as String,
  invoiceDate: DateTime.parse(json['invoiceDate'] as String),
  totalAmount: (json['totalAmount'] as num).toDouble(),
  venueId: json['venueId'] as String,
  customerId: json['customerId'] as String,
  notes: json['notes'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  isDeleted: json['isDeleted'] as bool,
  createdByUserId: json['createdByUserId'] as String,
  updatedByUserId: json['updatedByUserId'] as String,
  invoiceStatus: json['invoiceStatus'] as String,
  email: json['email'] as String?,
);

Map<String, dynamic> _$InvoiceDetailResponseToJson(
  _InvoiceDetailResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'invoiceNumber': instance.invoiceNumber,
  'invoiceDate': instance.invoiceDate.toIso8601String(),
  'totalAmount': instance.totalAmount,
  'venueId': instance.venueId,
  'customerId': instance.customerId,
  'notes': instance.notes,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'isDeleted': instance.isDeleted,
  'createdByUserId': instance.createdByUserId,
  'updatedByUserId': instance.updatedByUserId,
  'invoiceStatus': instance.invoiceStatus,
  'email': instance.email,
};
