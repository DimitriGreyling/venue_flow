import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:venue_flow_app/features/customers/data/member_response.dart';
import '../../../core/network/dio_client.dart';
import '../domain/customer.dart';

part 'customer_repository.g.dart';

class CustomerRepository {
  CustomerRepository(this._dio);

  final Dio _dio;

  Future<List<Customer>> searchCustomers({required String searchTerm}) async {
    final response = await _dio.get(
      '/organizations/members/search',
      queryParameters: {'searchTerm': searchTerm},
    );
    final list = (response.data as List<dynamic>);
    return list.map((e) => Customer.fromJson(e)).toList();
  }

  //Get List of memebers for a organization
  Future<List<MemberResponse>> getMembersForOrg() async {
    final response = await _dio.get('/organizations/members');
    final list = (response.data as List<dynamic>);
    return list.map((e) => MemberResponse.fromJson(e)).toList();
  }

  //Get customer details by ID
  Future<Customer> getMemberDetailsById(String userId) async {
    final response = await _dio.get(
      '/organizations/members/member/',
      queryParameters: {'id': userId},
    );

    return Customer.fromJson(response.data);
  }
}

// 1. Change function name to match your preferred provider name (e.g., customerRepository)
// 2. Return the instantiated repository directly
@riverpod
CustomerRepository customerRepository(Ref ref) {
  return CustomerRepository(ref.watch(dioProvider));
}
