import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_client.dart';

part 'appointment_configuration_repository.g.dart';

class AppointmentConfigurationRepository {
  AppointmentConfigurationRepository(this._dio);

  final Dio _dio;


}

@riverpod
AppointmentConfigurationRepository appointmentConfigurationRepository(Ref ref) {
  return AppointmentConfigurationRepository(ref.watch(dioProvider));
}