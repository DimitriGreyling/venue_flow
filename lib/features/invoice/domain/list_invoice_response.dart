import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_invoice_response.freezed.dart';
part 'list_invoice_response.g.dart';

@freezed
abstract class ListInvoiceResponse with _$ListInvoiceResponse {
  const factory ListInvoiceResponse({required String invoiceId}) =
      _ListInvoiceResponse;

  factory ListInvoiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ListInvoiceResponseFromJson(json);
}
