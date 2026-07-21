import '../../../core/result/result.dart';
import 'customer_entity.dart';

abstract class CustomersRepository {
  Future<Result<List<CustomerEntity>>> getAll();
  Future<Result<CustomerEntity>> create({
    required String fullName,
    required String email,
    String? phone,
  });
}