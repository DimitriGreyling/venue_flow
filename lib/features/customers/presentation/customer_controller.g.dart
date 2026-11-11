// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CustomerController)
final customerControllerProvider = CustomerControllerProvider._();

final class CustomerControllerProvider
    extends $AsyncNotifierProvider<CustomerController, List<Customer>> {
  CustomerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customerControllerHash();

  @$internal
  @override
  CustomerController create() => CustomerController();
}

String _$customerControllerHash() =>
    r'063e76e950354875a3f280a73c3a2f8e8e7c55cd';

abstract class _$CustomerController extends $AsyncNotifier<List<Customer>> {
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
