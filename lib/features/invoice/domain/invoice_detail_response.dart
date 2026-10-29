import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice_detail_response.freezed.dart';

part 'invoice_detail_response.g.dart';

@freezed
abstract class InvoiceDetailResponse with _$InvoiceDetailResponse {
  const factory InvoiceDetailResponse({
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
  }) = _InvoiceDetailResponse;

  factory InvoiceDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDetailResponseFromJson(json);
}
