import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:venue_flow_app/features/customers/data/member_response.dart';
import 'package:venue_flow_app/features/customers/domain/link_customer_to_org.dart';
import 'package:venue_flow_app/features/customers/domain/register_customer.dart';
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

  ///Get List of memebers for a organization
  Future<List<MemberResponse>> getMembersForOrg() async {
    final response = await _dio.get('/organizations/members');
    final list = (response.data as List<dynamic>);
    return list.map((e) => MemberResponse.fromJson(e)).toList();
  }

  ///Get customer details by ID
  Future<Customer> getMemberDetailsById(String userId) async {
    final response = await _dio.get(
      '/organizations/members/member/',
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
}

// 1. Change function name to match your preferred provider name (e.g., customerRepository)
// 2. Return the instantiated repository directly
@riverpod
CustomerRepository customerRepository(Ref ref) {
  return CustomerRepository(ref.watch(dioProvider));
}
