import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:venue_flow_app/core/domain/paged_response.dart';
import 'package:venue_flow_app/features/invoice/domain/add_invoice_request.dart';
import 'package:venue_flow_app/features/invoice/domain/invoice_detail_response.dart';
import 'package:venue_flow_app/features/invoice/domain/invoice_number_reservation_response.dart';
import 'package:venue_flow_app/features/invoice/domain/list_invoice_response.dart';
import '../../../core/network/dio_client.dart';

part 'invoice_repository.g.dart';

class InvoiceRepository {
  InvoiceRepository(this._dio);

  final Dio _dio;

  ///
  /// List all the invoices for a organization , using paging
  /// Returns a list of IDs and pagination information
  ///
  Future<PagedResponse<ListInvoiceResponse>> getInvoicesForOrganization({
    required int page,
    required int pageSize,
  }) async {
    final response = await _dio.get(
      '/invoices',
      queryParameters: {'page': page, 'pageSize': pageSize},
    );

    return PagedResponse<ListInvoiceResponse>.fromJson(
      response.data as Map<String, dynamic>,
      (json) => ListInvoiceResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  ///
  /// Get all information of the invoice
  ///
  Future<InvoiceDetailResponse> getInvoiceDetail({
    required String invoiceId,
  }) async {
    final response = await _dio.get('/invoices/$invoiceId');

    return InvoiceDetailResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  ///
  /// Reservation invoice number for current invoice
  ///
  Future<InvoiceNumberReservationResponse> getInvoiceReservation() async {
    final response = await _dio.post('/invoices/reservations');

    return InvoiceNumberReservationResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  ///
  /// Create invoice
  ///
  Future<InvoiceDetailResponse> createInvoice({
    required AddInvoiceRequest addInvoiceRequest,
    required String reservationId,
  }) async {
    final response = await _dio.post(
      '/invoices/$reservationId',
      data: addInvoiceRequest.toJson(),
    );

    return InvoiceDetailResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}

@riverpod
InvoiceRepository invoiceRepository(Ref ref) {
  return InvoiceRepository(ref.watch(dioProvider));
}
