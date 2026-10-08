// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venues_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VenuesController)
final venuesControllerProvider = VenuesControllerProvider._();

final class VenuesControllerProvider
    extends $AsyncNotifierProvider<VenuesController, List<Venue>> {
  VenuesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'venuesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$venuesControllerHash();

  @$internal
  @override
  VenuesController create() => VenuesController();
}

String _$venuesControllerHash() => r'7f87df66cc0f65a44dc4e17c3b5a4e1c7b13b292';

abstract class _$VenuesController extends $AsyncNotifier<List<Venue>> {
  FutureOr<List<Venue>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Venue>>, List<Venue>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Venue>>, List<Venue>>,
              AsyncValue<List<Venue>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
