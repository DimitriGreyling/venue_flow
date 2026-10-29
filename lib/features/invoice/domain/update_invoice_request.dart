import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_invoice_request.freezed.dart';

part 'update_invoice_request.g.dart';

@freezed
abstract class UpdateInvoiceRequest with _$UpdateInvoiceRequest {
  const factory UpdateInvoiceRequest({
    required String id,
    required String invoiceNumber,
    required DateTime invoiceDate,
    required double totalAmount,
    required String venueId,
    required String customerId,
    required String notes,
    required DateTime createdAt,
    required DateTime updatedAt,
    required bool isDeleted,
    required String createdByUserId,
    required String updatedByUserId,
    required String invoiceStatus,
    String? email,
  }) = _UpdateInvoiceRequest;

  factory UpdateInvoiceRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateInvoiceRequestFromJson(json);
}
