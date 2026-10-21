import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/appointment_configuration.dart';
import '../repository/appointment_configuration_repository.dart';

part 'appointment_configuration_controller.g.dart';

@riverpod
class AppointmentConfigurationController
    extends _$AppointmentConfigurationController {
  @override
  FutureOr<List<AppointmentConfigurationController>> build() async {
    return [];
  }

  ///
  /// Get Appointment Configuration by venue id
  ///
  Future<AppointmentConfiguration> getAppointmentConfiguration({
    required String venueId,
  }) async {
    final repository = ref.watch(appointmentConfigurationRepositoryProvider);
    return await repository.getAppointmentConfiguration(venueId: venueId);
  }

  ///
  /// Update Appointment Configuration for a venue id
  ///
  Future<AppointmentConfiguration> updateAppointmentConfiguration({
    required AppointmentConfiguration appointment,
  }) async {
    final repository = ref.watch(appointmentConfigurationRepositoryProvider);
    return await repository.updateAppointmentConfiguration(
      appointment: appointment,
    );
  }
}
