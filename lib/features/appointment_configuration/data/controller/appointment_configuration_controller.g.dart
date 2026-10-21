// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_configuration_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppointmentConfigurationController)
final appointmentConfigurationControllerProvider =
    AppointmentConfigurationControllerProvider._();

final class AppointmentConfigurationControllerProvider
    extends
        $AsyncNotifierProvider<
          AppointmentConfigurationController,
          List<AppointmentConfigurationController>
        > {
  AppointmentConfigurationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appointmentConfigurationControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$appointmentConfigurationControllerHash();

  @$internal
  @override
  AppointmentConfigurationController create() =>
      AppointmentConfigurationController();
}

String _$appointmentConfigurationControllerHash() =>
    r'9a0ec48bd7f65f21df4239bef16e218a88878b72';

abstract class _$AppointmentConfigurationController
    extends $AsyncNotifier<List<AppointmentConfigurationController>> {
  FutureOr<List<AppointmentConfigurationController>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<AppointmentConfigurationController>>,
              List<AppointmentConfigurationController>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AppointmentConfigurationController>>,
                List<AppointmentConfigurationController>
              >,
              AsyncValue<List<AppointmentConfigurationController>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
