import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_invoice_request.freezed.dart';

part 'add_invoice_request.g.dart';

@freezed
abstract class AddInvoiceRequest with _$AddInvoiceRequest {
  const factory AddInvoiceRequest({
    String? id,
    required String invoiceNumber,
    required DateTime invoiceDate,
    required double totalAmount,
    required String venueId,
    required String customerId,
    required String notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    required bool isDeleted,
    String? createdByUserId,
    String? updatedByUserId,
    String? invoiceStatus,
    String? email,
  }) = _AddInvoiceRequest;

  factory AddInvoiceRequest.fromJson(Map<String, dynamic> json) =>
      _$AddInvoiceRequestFromJson(json);
}
