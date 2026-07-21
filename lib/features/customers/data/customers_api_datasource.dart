import '../../../core/network/api_client.dart';
import '../../../core/result/result.dart';
import 'customer_dto.dart';

class CustomersApiDataSource {
  final ApiClient _api;
  CustomersApiDataSource(this._api);

  Future<Result<List<CustomerDto>>> getAll() {
    return _api.get('/customers', (json) {
      final list = (json is List) ? json : (json['items'] as List? ?? []);
      return list
          .map((e) => CustomerDto.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    });
  }

  Future<Result<CustomerDto>> create({
    required String fullName,
    required String email,
    String? phone,
  }) {
    return _api.post(
      '/customers',
      data: {
        'fullName': fullName,
        'email': email,
        'phone': phone,
      },
      parser: (json) => CustomerDto.fromJson(Map<String, dynamic>.from(json)),
    );
  }
}