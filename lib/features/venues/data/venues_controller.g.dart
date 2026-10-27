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

String _$venuesControllerHash() => r'fa94f14f4be4442880794cd43a19b906abe75eb6';

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

@ProviderFor(VenueDetails)
final venueDetailsProvider = VenueDetailsFamily._();

final class VenueDetailsProvider
    extends $AsyncNotifierProvider<VenueDetails, VenueResponse> {
  VenueDetailsProvider._({
    required VenueDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'venueDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$venueDetailsHash();

  @override
  String toString() {
    return r'venueDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  VenueDetails create() => VenueDetails();

  @override
  bool operator ==(Object other) {
    return other is VenueDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$venueDetailsHash() => r'a41487f09c5c5f95fb857582211a6005ea365064';

final class VenueDetailsFamily extends $Family
    with
        $ClassFamilyOverride<
          VenueDetails,
          AsyncValue<VenueResponse>,
          VenueResponse,
          FutureOr<VenueResponse>,
          String
        > {
  VenueDetailsFamily._()
    : super(
        retry: null,
        name: r'venueDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VenueDetailsProvider call(String venueId) =>
      VenueDetailsProvider._(argument: venueId, from: this);

  @override
  String toString() => r'venueDetailsProvider';
}

abstract class _$VenueDetails extends $AsyncNotifier<VenueResponse> {
  late final _$args = ref.$arg as String;
  String get venueId => _$args;

  FutureOr<VenueResponse> build(String venueId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<VenueResponse>, VenueResponse>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<VenueResponse>, VenueResponse>,
              AsyncValue<VenueResponse>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
