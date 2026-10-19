import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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
}

// 1. Change function name to match your preferred provider name (e.g., customerRepository)
// 2. Return the instantiated repository directly
@riverpod
CustomerRepository customerRepository(Ref ref) {
  return CustomerRepository(ref.watch(dioProvider));
}
