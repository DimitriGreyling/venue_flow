// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_number_reservation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InvoiceNumberReservationResponse _$InvoiceNumberReservationResponseFromJson(
  Map<String, dynamic> json,
) => _InvoiceNumberReservationResponse(
  reservationId: json['reservationId'] as String,
  invoiceNumber: json['invoiceNumber'] as String,
  expiresAtUtc: DateTime.parse(json['expiresAtUtc'] as String),
);

Map<String, dynamic> _$InvoiceNumberReservationResponseToJson(
  _InvoiceNumberReservationResponse instance,
) => <String, dynamic>{
  'reservationId': instance.reservationId,
  'invoiceNumber': instance.invoiceNumber,
  'expiresAtUtc': instance.expiresAtUtc.toIso8601String(),
};
