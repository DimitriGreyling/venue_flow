import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/customer_repository.dart';
import '../domain/customer.dart';

part 'customer_controller.g.dart';

@riverpod
class CustomerSearchController extends _$CustomerSearchController {
  @override
  FutureOr<List<Customer>> build() async {
    // Initial state can be an empty list or fetch default customers
    return [];
  }

  // Action method called from your UI
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

  //Get List of members for a organization
  Future<List<Customer>> getMembersForOrg() async {
    final repository = ref.read(customerRepositoryProvider);
    return await repository.getMembersForOrg();
  }

  //Get customer details by ID
  Future<Customer> getMemberDetailsById(String userId) async {
    final repository = ref.read(customerRepositoryProvider);
    return await repository.getMemberDetailsById(userId);
  }
}
