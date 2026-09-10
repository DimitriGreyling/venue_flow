import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/features/customers/data/customers_repository_impl.dart';
import 'package:venue_flow_app/features/customers/domain/customer.dart';

final customersControllerProvider =
    AsyncNotifierProvider<CustomersController, List<Customer>>(
      CustomersController.new,
    );

class CustomersController extends AsyncNotifier<List<Customer>> {
  @override
  Future<List<Customer>> build() async {
    final repository = ref.read(customersRepositoryProvider);
    return repository.list();
  }
}
