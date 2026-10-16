import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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
      '/api/appointments/my',
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
    } else if (data is Map<String, dynamic> &&
        data['items'] is List) {
      items = data['items'] as List<dynamic>;
    } else if (data is Map<String, dynamic> &&
        data['data'] is List) {
      items = data['data'] as List<dynamic>;
    } else {
      throw const FormatException(
        'Unexpected appointments API response format.',
      );
    }

    return items
        .map(
          (item) => Appointment.fromJson(
        Map<String, dynamic>.from(item as Map),
      ),
    )
        .toList();
  }
}

@riverpod
AppointmentsRepository appointmentsRepository(Ref ref){
  return AppointmentsRepository(ref.watch(dioProvider));
}