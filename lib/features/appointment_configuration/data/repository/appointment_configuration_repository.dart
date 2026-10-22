import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:venue_flow_app/features/appointment_configuration/domain/appointment_configuration.dart';

import '../../../../core/network/dio_client.dart';

part 'appointment_configuration_repository.g.dart';

class AppointmentConfigurationRepository {
  AppointmentConfigurationRepository(this._dio);

  final Dio _dio;

  ///
  /// Get Appointment Configuration by venue id
  ///
  Future<AppointmentConfiguration> getAppointmentConfiguration({
    required String venueId,
  }) async {
    final response = await _dio.get(
      '/venues/$venueId/appointment-configuration',
    );

    print('RESPONSE: ${response}');

    return AppointmentConfiguration.fromJson(response.data);
  }

  ///
  /// Update Appointment Configuration for a venue id
  ///
  Future<AppointmentConfiguration> updateAppointmentConfiguration({
    required AppointmentConfiguration appointment,
  }) async {
    final response = await _dio.put(
      '/venues/${appointment.venueId}/appointment-configuration',
      data: appointment.toJson(),
    );
    return AppointmentConfiguration.fromJson(response.data);
  }
}

@riverpod
AppointmentConfigurationRepository appointmentConfigurationRepository(Ref ref) {
  return AppointmentConfigurationRepository(ref.watch(dioProvider));
}
