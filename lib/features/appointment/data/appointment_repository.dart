import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:venue_flow_app/features/appointment/domain/appointment_month.dart';
import '../../../core/network/dio_client.dart';
import '../domain/appointment.dart';

part 'appointment_repository.g.dart';

class AppointmentsRepository {
  final Dio _dio;

  AppointmentsRepository(this._dio);

  Future<List<Appointment>> getCalendarAppointments({
    required DateTime fromUtc,
    required DateTime toUtc,
  }) async {
    final response = await _dio.get(
      '/appointments/my',
      // queryParameters: {
      //   'fromUtc': fromUtc.toUtc().toIso8601String(),
      //   'toUtc': toUtc.toUtc().toIso8601String(),
      // },
    );

    final data = response.data;

    // Supports either a direct JSON array or a common wrapped response.
    final List<dynamic> items;

    print('Response data: $data');

    if (data is List) {
      items = data;
    } else if (data is Map<String, dynamic> && data['items'] is List) {
      items = data['items'] as List<dynamic>;
    } else if (data is Map<String, dynamic> && data['data'] is List) {
      items = data['data'] as List<dynamic>;
    } else {
      throw const FormatException(
        'Unexpected appointments API response format.',
      );
    }

    return items
        .map(
          (item) =>
              Appointment.fromJson(Map<String, dynamic>.from(item as Map)),
        )
        .toList();
  }


  ///
  ///Bring back all appointments for a specific month and year, with the appointment IDs only. This is used to display the calendar with dots on the days that have appointments.
  ///Only Ids are brought back and counts not actual appointment information
  Future<AppointmentMonth> getCalendarAppointmentIds({
    required int year,
    required int month,
  }) async {
    final response = await _dio.get(
      '/appointments/calendar-month',
      queryParameters: {'year': year, 'month': month},
    );

    final data = response.data;

    print('Response data: $data');

    return AppointmentMonth.fromJson(Map<String, dynamic>.from(data as Map));
  }

  /// Get All details of the appointment using the ID
  Future<Appointment> getAppointmentInformationById({
    required String appointmentId,
  }) async {
    await Future.delayed(Duration(seconds: 10));
    final response = await _dio.get('/appointments/$appointmentId');

    final data = response.data;

    print('Response data: $data');

    return Appointment.fromJson(Map<String, dynamic>.from(data as Map));
  }
}

@riverpod
AppointmentsRepository appointmentsRepository(Ref ref) {
  return AppointmentsRepository(ref.watch(dioProvider));
}
