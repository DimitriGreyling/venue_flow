import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/features/customers/domain/customer.dart';
import 'package:venue_flow_app/features/customers/domain/customers_repository.dart';

final customersRepositoryProvider = Provider<CustomersRepository>((ref) {
  return _CustomersRepositoryImpl();
});

class _CustomersRepositoryImpl implements CustomersRepository {
  @override
  Future<List<Customer>> list() async {
    return const [
      Customer(id: '1', name: 'Acme Events'),
      Customer(id: '2', name: 'Northwind Hospitality'),
    ];
  }
}
