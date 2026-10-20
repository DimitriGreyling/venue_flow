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
    r'7265c13149ca0176fed55bb359d34f276b018e45';

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

@ProviderFor(CustomerDetails)
final customerDetailsProvider = CustomerDetailsFamily._();

final class CustomerDetailsProvider
    extends $AsyncNotifierProvider<CustomerDetails, Customer> {
  CustomerDetailsProvider._({
    required CustomerDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'customerDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$customerDetailsHash();

  @override
  String toString() {
    return r'customerDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CustomerDetails create() => CustomerDetails();

  @override
  bool operator ==(Object other) {
    return other is CustomerDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$customerDetailsHash() => r'b2edb687ee0fb2e4ff90d3c82c55215c7a6c3734';

final class CustomerDetailsFamily extends $Family
    with
        $ClassFamilyOverride<
          CustomerDetails,
          AsyncValue<Customer>,
          Customer,
          FutureOr<Customer>,
          String
        > {
  CustomerDetailsFamily._()
    : super(
        retry: null,
        name: r'customerDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CustomerDetailsProvider call(String customerId) =>
      CustomerDetailsProvider._(argument: customerId, from: this);

  @override
  String toString() => r'customerDetailsProvider';
}

abstract class _$CustomerDetails extends $AsyncNotifier<Customer> {
  late final _$args = ref.$arg as String;
  String get customerId => _$args;

  FutureOr<Customer> build(String customerId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Customer>, Customer>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Customer>, Customer>,
              AsyncValue<Customer>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
