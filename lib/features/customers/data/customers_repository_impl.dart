import '../../../core/result/result.dart';
import '../domain/customer_entity.dart';
import '../domain/customers_repository.dart';
import 'customers_api_datasource.dart';

class CustomersRepositoryImpl implements CustomersRepository {
  final CustomersApiDataSource _ds;
  CustomersRepositoryImpl(this._ds);

  @override
  Future<Result<List<CustomerEntity>>> getAll() async {
    final result = await _ds.getAll();
    return result.when(
      success: (data) => Success(data.map((e) => e.toEntity()).toList()),
      failure: (f) => FailureResult(f),
    );
  }

  @override
  Future<Result<CustomerEntity>> create({
    required String fullName,
    required String email,
    String? phone,
  }) async {
    final result = await _ds.create(fullName: fullName, email: email, phone: phone);
    return result.when(
      success: (dto) => Success(dto.toEntity()),
      failure: (f) => FailureResult(f),
    );
  }
}