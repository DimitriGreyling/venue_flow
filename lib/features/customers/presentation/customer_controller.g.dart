// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CustomerSearchController)
final customerSearchControllerProvider = CustomerSearchControllerProvider._();

final class CustomerSearchControllerProvider
    extends $AsyncNotifierProvider<CustomerSearchController, List<Customer>> {
  CustomerSearchControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customerSearchControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customerSearchControllerHash();

  @$internal
  @override
  CustomerSearchController create() => CustomerSearchController();
}

String _$customerSearchControllerHash() =>
    r'2c5a5aa425ab0cdac57965ce61fbafcee7f11364';

abstract class _$CustomerSearchController
    extends $AsyncNotifier<List<Customer>> {
  FutureOr<List<Customer>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Customer>>, List<Customer>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Customer>>, List<Customer>>,
              AsyncValue<List<Customer>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
