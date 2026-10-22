import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../core/enums/badge_status.dart';
import '../../../../core/theme/theme_x.dart';
import '../../../../core/widgets/side_nav.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/top_bar.dart';
import '../../domain/appointment_days.dart';
import '../../domain/appointment_month.dart';
import '../appointment_calendar_provider.dart';
import '../appointment_title.dart';
import '../dialogs/add_appointment_dialog.dart';

class AppointmentDesktopScreen extends ConsumerStatefulWidget {
  const AppointmentDesktopScreen({super.key});

  @override
  ConsumerState<AppointmentDesktopScreen> createState() =>
      _AppointmentDesktopScreenState();
}

class _AppointmentDesktopScreenState
    extends ConsumerState<AppointmentDesktopScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  CalendarMonthYearAndVenue get _month =>
      (year: _focusedDay.year, month: _focusedDay.month);

  Future<void> _refresh() async {
    ref.invalidate(appointmentIdsProvider(_month));
    ref.invalidate(appointmentInformationByIdProvider);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    const _wideBreakpoint = 1000.0;
    final wide = MediaQuery.of(context).size.width >= _wideBreakpoint;
    final appointmentsAsync = ref.watch(appointmentIdsProvider(_month));

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
                        loading: () {
                          return loadingView(cs: cs);
                        },
                        error: (error, stackTrace) =>
                            Center(child: errorView(error: error.toString())),
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

                          return appointmentView(
                            cs: cs,
                            appointmentItems: appointmentItems,
                            appointments: appointments,
                            selectedAppointments: selectedAppointments,
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

  Widget appointmentView({
    required AppointmentMonth appointments,
    required List<({DateTime date, String id})> appointmentItems,
    required List<AppointmentDays> selectedAppointments,
    required ColorScheme cs,
  }) {
    return Column(
      children: [
        Card(
          child: TableCalendar<AppointmentDays>(
            firstDay: DateTime(2020),
            lastDay: DateTime(2100),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            eventLoader: (day) {
              return appointments.days.where((appointment) {
                return isSameDay(appointment.date.toLocal(), day);
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
                color: cs.secondary.withValues(alpha: 0.3),
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
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              StatusBadge(
                label: 'Total Appointments: ${selectedAppointments.length}',
                status: BadgeStatus.neutral,
              ),
            ],
          ),
        ),
        Expanded(
          child: selectedAppointments.isEmpty
              ? const Center(child: Text('No appointments for this day.'))
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: appointmentItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final item = appointmentItems[index];

                    return AppointmentTitle(
                      appointmentId: item.id,
                      appointmentStartDate: item.date,
                      appointmentEndDate: item.date,
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget errorView({required String error}) {
    return Padding(
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
              ref.invalidate(appointmentIdsProvider(_month));
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget loadingView({required ColorScheme cs}) {
    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(
        baseColor: cs.surfaceContainerLow,
        highlightColor: cs.surface,
      ),
      child: Column(
        children: [
          Card(
            child: TableCalendar<AppointmentDays>(
              firstDay: DateTime(2020),
              lastDay: DateTime(2100),
              focusedDay: _focusedDay,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
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
                  color: cs.secondary.withValues(alpha: 0.3),
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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                StatusBadge(
                  label: 'Total Appointments: 0',
                  status: BadgeStatus.neutral,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Skeleton.leaf(
                      enabled: true,
                      child: const CircleAvatar(child: Icon(Icons.event)),
                    ),
                    title: const Text(
                      'Loading...',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Loading...',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Skeleton.leaf(
                          enabled: true,
                          child: StatusBadge(
                            label: 'Loading...',
                            status: BadgeStatus.neutral,
                          ),
                        ),
                        const Spacer(),
                        IconButton(onPressed: null, icon: Icon(Mdi.eye)),
                        IconButton(onPressed: null, icon: Icon(Mdi.bookEdit)),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
