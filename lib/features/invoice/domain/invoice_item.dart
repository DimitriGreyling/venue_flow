// Guid Id,
//     decimal Price,
// int Quantity,
//     decimal TotalAmount,
// Guid InvoiceId

import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice_item.freezed.dart';

part 'invoice_item.g.dart';

@freezed
abstract class InvoiceItem with _$InvoiceItem {
  const factory InvoiceItem({
    required String id,
    required double price,
    required int quantity,
    required double totalAmount,
    required String invoiceId,
    required String description,
    String? email,
  }) = _InvoiceItem;

  factory InvoiceItem.fromJson(Map<String, dynamic> json) =>
      _$InvoiceItemFromJson(json);
}
