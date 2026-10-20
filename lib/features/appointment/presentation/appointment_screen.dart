import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/enums/badge_status.dart';
import 'package:venue_flow_app/core/widgets/responsive.dart';
import 'package:venue_flow_app/core/widgets/status_badge.dart';
import 'package:venue_flow_app/core/widgets/top_bar.dart';
import 'package:venue_flow_app/features/appointment/domain/appointment_days.dart';
import 'package:venue_flow_app/features/appointment/domain/appointment_month.dart';
import 'package:venue_flow_app/features/appointment/presentation/dialogs/add_appointment_dialog.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/theme_x.dart' show ThemeX;
import '../../../core/widgets/generic_loader.dart';
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

  CalendarMonthYearAndVenue get _month =>
      (year: _focusedDay.year, month: _focusedDay.month);

  @override
  Widget build(BuildContext context) {
    final appointmentsAsync = ref.watch(appointmentIdsProvider(_month));
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

  Future<void> _refresh() async {
    ref.invalidate(appointmentIdsProvider(_month));
    ref.invalidate(appointmentInformationByIdProvider);
  }

  Widget viewMobile({
    required AsyncValue<AppointmentMonth> appointmentsAsync,
    required ColorScheme cs,
    required AppSemanticColors sem,
    required double wideBreakpoint,
  }) {
    final wide = MediaQuery.sizeOf(context).width >= wideBreakpoint;

    return Scaffold(
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
                          CircleAvatar(
                            child: IconButton(
                              onPressed: () async {
                                await AddAppointmentDialog.show(
                                  context: context,
                                );
                                _refresh();
                              },
                              tooltip: 'Add appointment to calendar',
                              icon: const Icon(Mdi.calendarAccount),
                            ),
                          ),
                          const SizedBox(width: 8),
                          CircleAvatar(
                            child: IconButton(
                              onPressed: () {
                                _refresh();
                              },
                              tooltip: 'Refresh',
                              icon: const Icon(Mdi.refresh),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: appointmentsAsync.when(
                        loading: () => const GenericLoader(
                          message: 'Loading your appointments...',
                        ),
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
                                      appointmentIdsProvider(_month),
                                    );
                                  },
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        data: (appointments) {
                          final selectedAppointments = appointments.days.where((
                            appointment,
                          ) {
                            return isSameDay(
                              appointment.date.toLocal(),
                              _selectedDay,
                            );
                          }).toList()..sort((a, b) => a.date.compareTo(b.date));

                          final appointmentItems = selectedAppointments.expand((
                            appointment,
                          ) {
                            return appointment.appointmentIds.map((
                              appointmentId,
                            ) {
                              return (
                                id: appointmentId,
                                date: appointment.date,
                              );
                            });
                          }).toList();

                          return Column(
                            children: [
                              Card(
                                child: TableCalendar<AppointmentDays>(
                                  firstDay: DateTime(2020),
                                  lastDay: DateTime(2100),
                                  focusedDay: _focusedDay,
                                  calendarFormat: CalendarFormat.month,
                                  selectedDayPredicate: (day) =>
                                      isSameDay(day, _selectedDay),
                                  eventLoader: (day) {
                                    return appointments.days.where((
                                      appointment,
                                    ) {
                                      return isSameDay(
                                        appointment.date.toLocal(),
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
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    todayDecoration: BoxDecoration(
                                      color: cs.secondary.withValues(
                                        alpha: 0.3,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    selectedDecoration: BoxDecoration(
                                      color: cs.secondaryFixed,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                      ),
                                    ),
                                    StatusBadge(
                                      label:
                                          'Total Appointments: ${selectedAppointments.length}',
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
                                        itemCount: appointmentItems.length,
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(height: 8),
                                        itemBuilder: (context, index) {
                                          final item = appointmentItems[index];

                                          return AppointmentTitle(
                                            appointmentId: item.id,
                                            appointmentStartDate: item.date,
                                            appointmentEndDate: item.date,
                                          );
                                        },
                                      ),

                                // ListView.separated(
                                //   padding: const EdgeInsets.symmetric(
                                //     horizontal: 16,
                                //   ),
                                //   itemCount: selectedAppointments.length,
                                //   separatorBuilder: (_, __) =>
                                //   const SizedBox(height: 8),
                                //   itemBuilder: (context, index) {
                                //     final appointment =
                                //     selectedAppointments[index];
                                //
                                //     return ListView.separated(
                                //       padding: const EdgeInsets.symmetric(
                                //         horizontal: 16,
                                //       ),
                                //       itemCount: appointment
                                //           .appointmentIds
                                //           .length,
                                //       separatorBuilder: (_, __) =>
                                //       const SizedBox(height: 8),
                                //       itemBuilder: (context, index) {
                                //         final appointmentDate =
                                //         appointment
                                //             .appointmentIds[index];
                                //
                                //         return AppointmentTitle(
                                //           appointmentId: appointmentDate,
                                //           appointmentStartDate:
                                //           appointment.date,
                                //           appointmentEndDate:
                                //           appointment.date,
                                //         );
                                //       },
                                //     );
                                //   },
                                // ),
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
    required AsyncValue<AppointmentMonth> appointmentsAsync,
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
                              ref.invalidate(appointmentIdsProvider(_month));
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
                        loading: () => const GenericLoader(
                          message: 'Loading your appointments...',
                        ),
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
                                      appointmentIdsProvider(_month),
                                    );
                                  },
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        data: (appointments) {
                          final selectedAppointments = appointments.days.where((
                            appointment,
                          ) {
                            return isSameDay(
                              appointment.date.toLocal(),
                              _selectedDay,
                            );
                          }).toList()..sort((a, b) => a.date.compareTo(b.date));

                          return Column(
                            children: [
                              Card(
                                child: TableCalendar<AppointmentDays>(
                                  firstDay: DateTime(2020),
                                  lastDay: DateTime(2100),
                                  focusedDay: _focusedDay,
                                  calendarFormat: CalendarFormat.month,
                                  selectedDayPredicate: (day) =>
                                      isSameDay(day, _selectedDay),
                                  eventLoader: (day) {
                                    return appointments.days.where((
                                      appointment,
                                    ) {
                                      return isSameDay(
                                        appointment.date.toLocal(),
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
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    todayDecoration: BoxDecoration(
                                      color: cs.secondary.withValues(
                                        alpha: 0.3,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    selectedDecoration: BoxDecoration(
                                      color: cs.secondaryFixed,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                      ),
                                    ),
                                    StatusBadge(
                                      label:
                                          'Total Appointments: ${selectedAppointments.length}',
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

                                          return ListView.separated(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            itemCount: appointment
                                                .appointmentIds
                                                .length,
                                            separatorBuilder: (_, __) =>
                                                const SizedBox(height: 8),
                                            itemBuilder: (context, index) {
                                              final appointmentDate =
                                                  appointment
                                                      .appointmentIds[index];

                                              return AppointmentTitle(
                                                appointmentId: appointmentDate,
                                                appointmentStartDate:
                                                    appointment.date,
                                                appointmentEndDate:
                                                    appointment.date,
                                              );
                                            },
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
}
