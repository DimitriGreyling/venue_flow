import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/appointment_repository.dart';
import '../domain/appointment.dart';

typedef CalendarMonth = ({int year, int month});

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
