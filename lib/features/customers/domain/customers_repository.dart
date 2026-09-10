import 'package:venue_flow_app/features/customers/domain/customer.dart';

abstract class CustomersRepository {
  Future<List<Customer>> list();
}
