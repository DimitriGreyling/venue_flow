// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_configuration_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appointmentConfigurationRepository)
final appointmentConfigurationRepositoryProvider =
    AppointmentConfigurationRepositoryProvider._();

final class AppointmentConfigurationRepositoryProvider
    extends
        $FunctionalProvider<
          AppointmentConfigurationRepository,
          AppointmentConfigurationRepository,
          AppointmentConfigurationRepository
        >
    with $Provider<AppointmentConfigurationRepository> {
  AppointmentConfigurationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appointmentConfigurationRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$appointmentConfigurationRepositoryHash();

  @$internal
  @override
  $ProviderElement<AppointmentConfigurationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppointmentConfigurationRepository create(Ref ref) {
    return appointmentConfigurationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppointmentConfigurationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppointmentConfigurationRepository>(
        value,
      ),
    );
  }
}

String _$appointmentConfigurationRepositoryHash() =>
    r'0e84094e003e4e72d50d3e0bb30db9af17ae43f0';
