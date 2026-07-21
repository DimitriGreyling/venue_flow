import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/result/result.dart';
import '../data/customers_api_datasource.dart';
import '../data/customers_repository_impl.dart';
import '../domain/customer_entity.dart';
import '../domain/customers_repository.dart';

final customersDataSourceProvider = Provider<CustomersApiDataSource>((ref) {
  return CustomersApiDataSource(ref.read(apiClientProvider));
});

final customersRepositoryProvider = Provider<CustomersRepository>((ref) {
  return CustomersRepositoryImpl(ref.read(customersDataSourceProvider));
});

class CustomersState {
  final List<CustomerEntity> items;
  final bool loading;
  final String? error;

  const CustomersState({
    required this.items,
    this.loading = false,
    this.error,
  });

  CustomersState copyWith({
    List<CustomerEntity>? items,
    bool? loading,
    String? error,
  }) {
    return CustomersState(
      items: items ?? this.items,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  factory CustomersState.initial() => const CustomersState(items: []);
}

final customersControllerProvider =
    NotifierProvider<CustomersController, CustomersState>(CustomersController.new);

class CustomersController extends Notifier<CustomersState> {
  @override
  CustomersState build() => CustomersState.initial();

  Future<void> load() async {
    state = state.copyWith(loading: true, error: null);
    final result = await ref.read(customersRepositoryProvider).getAll();

    state = result.when(
      success: (data) => state.copyWith(items: data, loading: false),
      failure: (f) => state.copyWith(loading: false, error: f.message),
    );
  }

  Future<bool> create({
    required String fullName,
    required String email,
    String? phone,
  }) async {
    state = state.copyWith(loading: true, error: null);

    final result = await ref.read(customersRepositoryProvider).create(
          fullName: fullName,
          email: email,
          phone: phone,
        );

    return result.when(
      success: (_) async {
        await load();
        return true;
      },
      failure: (f) {
        state = state.copyWith(loading: false, error: f.message);
        return false;
      },
    );
  }
}