import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:venue_flow_app/features/customers/domain/member_response.dart';
import 'package:venue_flow_app/features/customers/domain/link_customer_to_org.dart';
import 'package:venue_flow_app/features/customers/domain/register_customer.dart';
import 'package:venue_flow_app/features/customers/domain/update_customer.dart';
import '../../../core/domain/paged_response.dart';
import '../../../core/network/dio_client.dart';
import '../domain/customer.dart';

part 'customer_repository.g.dart';

class CustomerRepository {
  CustomerRepository(this._dio);

  final Dio _dio;

  /// Search customers using a search term
  Future<List<Customer>> searchCustomers({required String searchTerm}) async {
    final response = await _dio.get(
      '/organizations/members/search',
      queryParameters: {'searchTerm': searchTerm},
    );
    final list = (response.data as List<dynamic>);
    return list.map((e) => Customer.fromJson(e)).toList();
  }

  ///
  ///Get List of memebers for a organization
  ///Method takes in page and pageSize
  ///
  Future<PagedResponse<MemberResponse>> getMembersForOrg({
    int page = 1,
    int pageSize = 20,
  }) async {
    final response = await _dio.get(
      '/organizations/members',
      queryParameters: {'page': page, 'pageSize': pageSize},
    );

    return PagedResponse<MemberResponse>.fromJson(
      response.data as Map<String, dynamic>,
      (json) => MemberResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  ///Get customer details by ID
  Future<Customer> getMemberDetailsById(String userId) async {
    final response = await _dio.get(
      '/organizations/members/member',
      queryParameters: {'id': userId},
    );

    return Customer.fromJson(response.data);
  }

  ///Post call for adding a customer that already exist in the system
  Future<void> registerCustomer(RegisterCustomer customer) async {
    final response = await _dio.post(
      '/organizations/members/register',
      data: customer.toJson(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add customer');
    }
  }

  ///
  ///Post call for registering a new customer that does not exist in the system
  ///
  Future<void> linkCustomer(LinkCustomerToOrg linkCustomerToOrg) async {
    final response = await _dio.post(
      '/organizations/members/link',
      data: linkCustomerToOrg.toJson(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to register customer');
    }
  }

  ///
  ///Remove Customer from Organization
  ///
  Future<void> removeCustomer(String userId) async {
    final response = await _dio.delete('/organizations/members/$userId');

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to remove customer');
    }
  }

  ///
  /// Update customer details
  ///
  ///
  Future<void> updateCustomerDetails(UpdateCustomer customer) async {
    final response = await _dio.put(
      '/organizations/members/update/${customer.userId}',
      data: customer.toJson(),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to update customer details');
    }
  }
}

// 1. Change function name to match your preferred provider name (e.g., customerRepository)
// 2. Return the instantiated repository directly
@riverpod
CustomerRepository customerRepository(Ref ref) {
  return CustomerRepository(ref.watch(dioProvider));
}
