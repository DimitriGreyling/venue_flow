// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InvoiceController)
final invoiceControllerProvider = InvoiceControllerProvider._();

final class InvoiceControllerProvider
    extends
        $AsyncNotifierProvider<InvoiceController, List<InvoiceDetailResponse>> {
  InvoiceControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'invoiceControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$invoiceControllerHash();

  @$internal
  @override
  InvoiceController create() => InvoiceController();
}

String _$invoiceControllerHash() => r'46fa18084edd713ade73b0a2f3b195c14fdb57f1';

abstract class _$InvoiceController
    extends $AsyncNotifier<List<InvoiceDetailResponse>> {
  FutureOr<List<InvoiceDetailResponse>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<InvoiceDetailResponse>>,
              List<InvoiceDetailResponse>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<InvoiceDetailResponse>>,
                List<InvoiceDetailResponse>
              >,
              AsyncValue<List<InvoiceDetailResponse>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(InvoiceDetails)
final invoiceDetailsProvider = InvoiceDetailsFamily._();

final class InvoiceDetailsProvider
    extends $AsyncNotifierProvider<InvoiceDetails, InvoiceDetailResponse> {
  InvoiceDetailsProvider._({
    required InvoiceDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'invoiceDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$invoiceDetailsHash();

  @override
  String toString() {
    return r'invoiceDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  InvoiceDetails create() => InvoiceDetails();

  @override
  bool operator ==(Object other) {
    return other is InvoiceDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$invoiceDetailsHash() => r'be574e12b4d3db50f344be51f773ad618ac28a71';

final class InvoiceDetailsFamily extends $Family
    with
        $ClassFamilyOverride<
          InvoiceDetails,
          AsyncValue<InvoiceDetailResponse>,
          InvoiceDetailResponse,
          FutureOr<InvoiceDetailResponse>,
          String
        > {
  InvoiceDetailsFamily._()
    : super(
        retry: null,
        name: r'invoiceDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  InvoiceDetailsProvider call({required String invoiceId}) =>
      InvoiceDetailsProvider._(argument: invoiceId, from: this);

  @override
  String toString() => r'invoiceDetailsProvider';
}

abstract class _$InvoiceDetails extends $AsyncNotifier<InvoiceDetailResponse> {
  late final _$args = ref.$arg as String;
  String get invoiceId => _$args;

  FutureOr<InvoiceDetailResponse> build({required String invoiceId});
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<InvoiceDetailResponse>, InvoiceDetailResponse>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<InvoiceDetailResponse>,
                InvoiceDetailResponse
              >,
              AsyncValue<InvoiceDetailResponse>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(invoiceId: _$args));
  }
}

@ProviderFor(InvoiceNumber)
final invoiceNumberProvider = InvoiceNumberProvider._();

final class InvoiceNumberProvider
    extends
        $AsyncNotifierProvider<
          InvoiceNumber,
          InvoiceNumberReservationResponse
        > {
  InvoiceNumberProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'invoiceNumberProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$invoiceNumberHash();

  @$internal
  @override
  InvoiceNumber create() => InvoiceNumber();
}

String _$invoiceNumberHash() => r'794332f2869d9339d423cba47f6f2526f403f232';

abstract class _$InvoiceNumber
    extends $AsyncNotifier<InvoiceNumberReservationResponse> {
  FutureOr<InvoiceNumberReservationResponse> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<InvoiceNumberReservationResponse>,
              InvoiceNumberReservationResponse
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<InvoiceNumberReservationResponse>,
                InvoiceNumberReservationResponse
              >,
              AsyncValue<InvoiceNumberReservationResponse>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
