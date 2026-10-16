import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/appointment_repository.dart';
import '../domain/appointment.dart';
import '../domain/appointment_month.dart';

typedef CalendarMonth = ({int year, int month});
typedef CalendarMonthYearAndVenue = ({int year, int month});

final appointmentsForMonthProvider =
    FutureProvider.family<List<Appointment>, CalendarMonth>((ref, month) async {
      final repository = ref.watch(appointmentsRepositoryProvider);

      final fromLocal = DateTime(month.year, month.month);
      final toLocal = DateTime(month.year, month.month + 1);

      return repository.getCalendarAppointments(
        fromUtc: fromLocal.toUtc(),
        toUtc: toLocal.toUtc(),
      );
    });

///Bring back all appointments for a specific month and year, with the appointment IDs only. This is used to display the calendar with dots on the days that have appointments.
///Only Ids are brought back and counts not actual appointment information
final appointmentIdsProvider =
    FutureProvider.family<AppointmentMonth, CalendarMonthYearAndVenue>((
      ref,
      monthYearAndVenue,
    ) async {
      final repository = ref.watch(appointmentsRepositoryProvider);

      return repository.getCalendarAppointmentIds(
        month: monthYearAndVenue.month,
        year: monthYearAndVenue.year,
      );
    });

/// Get All details of the appointment using the ID
final appointmentInformationByIdProvider =
FutureProvider.family<Appointment, String>((
    ref,
    appointmentId,
    ) async {
  final repository = ref.watch(appointmentsRepositoryProvider);

  return repository.getAppointmentInformationById(
    appointmentId: appointmentId,
  );
});
