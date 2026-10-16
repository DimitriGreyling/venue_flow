import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/enums/badge_status.dart';
import 'package:venue_flow_app/core/widgets/responsive.dart';
import 'package:venue_flow_app/core/widgets/status_badge.dart';
import 'package:venue_flow_app/core/widgets/top_bar.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/theme_x.dart' show ThemeX;
import '../../../core/widgets/side_nav.dart';
import '../domain/appointment.dart';
import 'package:table_calendar/table_calendar.dart';

import 'appointment_calendar_provider.dart';
import 'appointment_title.dart';

class AppointmentScreen extends ConsumerStatefulWidget {
  const AppointmentScreen({super.key});

  @override
  ConsumerState<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends ConsumerState<AppointmentScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  CalendarMonth get _month =>
      (year: _focusedDay.year, month: _focusedDay.month);

  @override
  Widget build(BuildContext context) {
    final appointmentsAsync = ref.watch(appointmentsForMonthProvider(_month));
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    const _wideBreakpoint = 1000.0;

    return Responsive(
      mobile: viewMobile(
        appointmentsAsync: appointmentsAsync,
        cs: cs,
        sem: sem,
        wideBreakpoint: _wideBreakpoint,
      ),
      desktop: viewDesktop(
        appointmentsAsync: appointmentsAsync,
        cs: cs,
        sem: sem,
        wideBreakpoint: _wideBreakpoint,
      ),
    );
  }

  Widget viewMobile({
    required AsyncValue<List<Appointment>> appointmentsAsync,
    required ColorScheme cs,
    required AppSemanticColors sem,
    required double wideBreakpoint,
  }) {
    final wide = MediaQuery.sizeOf(context).width >= wideBreakpoint;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Appointments'),
      //   actions: [
      //     IconButton(
      //       tooltip: 'Refresh appointments',
      //       onPressed: () {
      //         ref.invalidate(appointmentsForMonthProvider(_month));
      //       },
      //       icon: const Icon(Icons.refresh),
      //     ),
      //   ],
      // ),
      drawer: wide
          ? null
          : Drawer(
              width: 240,
              backgroundColor: cs.surface,
              child: SideNav(activePath: '/appointments'),
            ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TopBar(wide: wide),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              ref.invalidate(
                                appointmentsForMonthProvider(_month),
                              );
                            },
                            icon: const Icon(Icons.refresh),
                            label: Text(
                              'Refresh',
                              style: TextStyle(color: cs.onSecondary),
                            ),
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                cs.secondary,
                              ),
                              iconColor: WidgetStateProperty.all(
                                cs.onSecondary,
                              ),
                              textStyle: WidgetStateProperty.all(
                                TextStyle(color: cs.onSecondary),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: appointmentsAsync.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (error, stackTrace) => Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.error_outline, size: 40),
                                const SizedBox(height: 12),
                                const Text('Could not load appointments.'),
                                const SizedBox(height: 8),
                                Text(
                                  error.toString(),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                FilledButton(
                                  onPressed: () {
                                    ref.invalidate(
                                      appointmentsForMonthProvider(_month),
                                    );
                                  },
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        data: (appointments) {
                          final selectedAppointments =
                              appointments.where((appointment) {
                                return isSameDay(
                                  appointment.startAtUtc.toLocal(),
                                  _selectedDay,
                                );
                              }).toList()..sort(
                                (a, b) => a.startAtUtc.compareTo(b.startAtUtc),
                              );

                          return Column(
                            children: [
                              Card(
                                child: TableCalendar<Appointment>(
                                  firstDay: DateTime(2020),
                                  lastDay: DateTime(2100),
                                  focusedDay: _focusedDay,
                                  calendarFormat: CalendarFormat.month,
                                  selectedDayPredicate: (day) =>
                                      isSameDay(day, _selectedDay),
                                  eventLoader: (day) {
                                    return appointments.where((appointment) {
                                      return isSameDay(
                                        appointment.startAtUtc.toLocal(),
                                        day,
                                      );
                                    }).toList();
                                  },
                                  onDaySelected: (selectedDay, focusedDay) {
                                    setState(() {
                                      _selectedDay = selectedDay;
                                      _focusedDay = focusedDay;
                                    });
                                  },
                                  onPageChanged: (focusedDay) {
                                    setState(() {
                                      _focusedDay = focusedDay;
                                    });
                                  },
                                  calendarStyle: CalendarStyle(
                                    markerDecoration: BoxDecoration(
                                      color: cs.tertiary,
                                      shape: BoxShape.circle,
                                    ),
                                    todayDecoration: BoxDecoration(
                                      color: cs.secondary.withValues(
                                        alpha: 0.2,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    selectedDecoration: BoxDecoration(
                                      color: cs.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Appointments for '
                                        '${_selectedDay.day}/'
                                        '${_selectedDay.month}/'
                                        '${_selectedDay.year}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                      ),
                                    ),
                                    StatusBadge(
                                      label:
                                          'Total: ${selectedAppointments.length}',
                                      status: BadgeStatus.neutral,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: selectedAppointments.isEmpty
                                    ? const Center(
                                        child: Text(
                                          'No appointments for this day.',
                                        ),
                                      )
                                    : ListView.separated(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        itemCount: selectedAppointments.length,
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(height: 8),
                                        itemBuilder: (context, index) {
                                          final appointment =
                                              selectedAppointments[index];

                                          return AppointmentTile(
                                            appointment: appointment,
                                          );
                                        },
                                      ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget viewDesktop({
    required AsyncValue<List<Appointment>> appointmentsAsync,
    required ColorScheme cs,
    required AppSemanticColors sem,
    required double wideBreakpoint,
  }) {
    final wide = MediaQuery.sizeOf(context).width >= wideBreakpoint;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Appointments'),
      //   actions: [
      //     IconButton(
      //       tooltip: 'Refresh appointments',
      //       onPressed: () {
      //         ref.invalidate(appointmentsForMonthProvider(_month));
      //       },
      //       icon: const Icon(Icons.refresh),
      //     ),
      //   ],
      // ),
      drawer: wide
          ? null
          : Drawer(
              width: 240,
              backgroundColor: cs.surface,
              child: SideNav(activePath: '/appointments'),
            ),
      body: appointmentsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 40),
                const SizedBox(height: 12),
                const Text('Could not load appointments.'),
                const SizedBox(height: 8),
                Text(error.toString(), textAlign: TextAlign.center),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () {
                    ref.invalidate(appointmentsForMonthProvider(_month));
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (appointments) {
          final selectedAppointments = appointments.where((appointment) {
            return isSameDay(appointment.startAtUtc.toLocal(), _selectedDay);
          }).toList()..sort((a, b) => a.startAtUtc.compareTo(b.startAtUtc));

          return Column(
            children: [
              TableCalendar<Appointment>(
                firstDay: DateTime(2020),
                lastDay: DateTime(2100),
                focusedDay: _focusedDay,
                calendarFormat: CalendarFormat.month,
                selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                eventLoader: (day) {
                  return appointments.where((appointment) {
                    return isSameDay(appointment.startAtUtc.toLocal(), day);
                  }).toList();
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                },
                calendarStyle: const CalendarStyle(
                  markerDecoration: BoxDecoration(
                    color: Colors.deepOrange,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.blueGrey,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.deepOrange,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Appointments for '
                        '${_selectedDay.day}/'
                        '${_selectedDay.month}/'
                        '${_selectedDay.year}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Text('${selectedAppointments.length}'),
                  ],
                ),
              ),
              Expanded(
                child: selectedAppointments.isEmpty
                    ? const Center(child: Text('No appointments for this day.'))
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: selectedAppointments.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final appointment = selectedAppointments[index];

                          return AppointmentTile(appointment: appointment);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
