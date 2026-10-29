import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice_number_reservation_response.freezed.dart';
part 'invoice_number_reservation_response.g.dart';

@freezed
abstract class InvoiceNumberReservationResponse with _$InvoiceNumberReservationResponse {
  const factory InvoiceNumberReservationResponse({
    required String reservationId,
    required String invoiceNumber,
    required DateTime expiresAtUtc,
  }) = _InvoiceNumberReservationResponse;

  factory InvoiceNumberReservationResponse.fromJson(Map<String, dynamic> json) =>
      _$InvoiceNumberReservationResponseFromJson(json);
}