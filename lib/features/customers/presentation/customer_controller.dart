import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:venue_flow_app/features/customers/data/member_response.dart';
import 'package:venue_flow_app/features/customers/domain/register_customer.dart';
import '../data/customer_repository.dart';
import '../domain/customer.dart';
import '../domain/link_customer_to_org.dart';

part 'customer_controller.g.dart';

@riverpod
class CustomerController extends _$CustomerController {
  @override
  FutureOr<List<Customer>> build() async {
    /// Initial state can be an empty list or fetch default customers
    return [];
  }

  /// Action method called from your UI
  Future<void> search(String searchTerm) async {
    if (searchTerm.trim().isEmpty) {
      state = const AsyncData([]);
      return;
    }

    // Set state to loading while keeping previous data (optional) or fresh load
    state = const AsyncLoading();

    // Fetch via repository and update state automatically
    state = await AsyncValue.guard(() async {
      final repository = ref.read(customerRepositoryProvider);
      return await repository.searchCustomers(searchTerm: searchTerm);
    });
  }

  ///Get List of members for a organization
  Future<List<MemberResponse>> getMembersForOrg() async {
    final repository = ref.read(customerRepositoryProvider);
    return await repository.getMembersForOrg();
  }

  ///Fetch customer details by user id
  Future<Customer> customerDetails(Ref ref, String customerId) async {
    final repository = ref.watch(customerRepositoryProvider);
    return await repository.getMemberDetailsById(customerId);
  }

  ///Post call for adding a customer that already exist in the system
  Future<void> registerCustomer(RegisterCustomer customer) async {
    final repository = ref.watch(customerRepositoryProvider);
    return await repository.registerCustomer(customer);
  }

  ///Post call for registering a new customer that does not exist in the system
  Future<void> linkCustomer(LinkCustomerToOrg linkCustomerToOrg) async {
    final repository = ref.watch(customerRepositoryProvider);
    return await repository.linkCustomer(linkCustomerToOrg);
  }

  ///
  ///Remove Customer from Organization
  ///
  Future<void> removeCustomer(String userId) async {
    final repository = ref.watch(customerRepositoryProvider);
    return await repository.removeCustomer(userId);
  }
}

@riverpod
class CustomerDetails extends _$CustomerDetails {
  @override
  Future<Customer> build(String customerId) async {
    final repository = ref.watch(customerRepositoryProvider);
    return await repository.getMemberDetailsById(customerId);
  }
}
