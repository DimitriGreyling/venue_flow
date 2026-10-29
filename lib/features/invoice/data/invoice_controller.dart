import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/paged_response.dart';
import '../domain/add_invoice_request.dart';
import '../domain/invoice_detail_response.dart';
import '../domain/invoice_number_reservation_response.dart';
import '../domain/list_invoice_response.dart';
import 'invoice_repository.dart';

part 'invoice_controller.g.dart';

@riverpod
class InvoiceController extends _$InvoiceController {
  @override
  FutureOr<List<InvoiceDetailResponse>> build() async {
    /// Initial state can be an empty list or fetch default customers
    return [];
  }

  Future<PagedResponse<ListInvoiceResponse>> getInvoicesForOrganization({
    required page,
    required pageSize,
  }) async {
    final repo = ref.watch(invoiceRepositoryProvider);
    return repo.getInvoicesForOrganization(page: page, pageSize: pageSize);
  }

  Future<InvoiceDetailResponse> getInvoiceDetail({
    required String invoiceId,
  }) async {
    final repo = ref.watch(invoiceRepositoryProvider);
    return repo.getInvoiceDetail(invoiceId: invoiceId);
  }

  ///
  /// Reservation invoice number for current invoice
  ///
  Future<InvoiceNumberReservationResponse> getInvoiceReservation() async {
    final repo = ref.watch(invoiceRepositoryProvider);
    return repo.getInvoiceReservation();
  }

  ///
  /// Create invoice using reserved inv number
  ///
  Future<InvoiceDetailResponse> createInvoice({
    required AddInvoiceRequest addInvoiceRequest,
    required String reservationId,
  }) async {
    final repo = ref.watch(invoiceRepositoryProvider);
    return repo.createInvoice(
      addInvoiceRequest: addInvoiceRequest,
      reservationId: reservationId,
    );
  }
}

@riverpod
class InvoiceDetails extends _$InvoiceDetails {
  @override
  Future<InvoiceDetailResponse> build({required String invoiceId}) async {
    final repository = ref.watch(invoiceRepositoryProvider);
    return await repository.getInvoiceDetail(invoiceId: invoiceId);
  }
}

@riverpod
class InvoiceNumber extends _$InvoiceNumber {
  @override
  Future<InvoiceNumberReservationResponse> build() async {
    final repository = ref.watch(invoiceRepositoryProvider);
    return await repository.getInvoiceReservation();
  }
}
