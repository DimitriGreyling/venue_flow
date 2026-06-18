import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:table_calendar/table_calendar.dart";
import "package:venue_flow_app/views/side_nav_widget.dart";
import "package:venue_flow_app/views/top_bar_widget.dart";

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<String, List<String>> _eventsByDate = <String, List<String>>{
    "2026-06-18": <String>[
      "Wedding",
      "Setup",
    ],
    "2026-06-20": <String>[
      "Tech Gala",
    ],
    "2026-06-21": <String>[
      "AV Check",
      "Client Call",
    ],
    "2026-06-24": <String>[
      "Meeting",
    ],
    "2026-06-28": <String>[
      "Conference",
      "Rehearsal",
      "Catering",
    ],
  };

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  String _dateKey(DateTime date) {
    final String year = date.year.toString().padLeft(4, "0");
    final String month = date.month.toString().padLeft(2, "0");
    final String day = date.day.toString().padLeft(2, "0");

    return "$year-$month-$day";
  }

  List<String> _eventsForDay(DateTime day) {
    final String key = _dateKey(day);
    final List<String>? events = _eventsByDate[key];

    if (events == null) {
      return <String>[];
    }

    return events;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Row(
        children: <Widget>[
          const SideNavWidget(),
          Expanded(
            child: Column(
              children: <Widget>[
                const TopBarWidget(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: <Widget>[
                        Card(
                          elevation: 0,
                          color: colorScheme.surfaceContainerLowest,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: colorScheme.outline.withValues(alpha: 0.08),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: TableCalendar<String>(
                              firstDay: DateTime.utc(2020, 1, 1),
                              lastDay: DateTime.utc(2030, 12, 31),
                              focusedDay: _focusedDay,
                              calendarFormat: _calendarFormat,
                              selectedDayPredicate: (DateTime day) {
                                return isSameDay(_selectedDay, day);
                              },
                              eventLoader: (DateTime day) {
                                return _eventsForDay(day);
                              },
                              rowHeight: 92,
                              daysOfWeekHeight: 32,
                              availableCalendarFormats:
                              const <CalendarFormat, String>{
                                CalendarFormat.month: "Month",
                                CalendarFormat.twoWeeks: "2 weeks",
                                CalendarFormat.week: "Week",
                              },
                              onDaySelected: (
                                  DateTime selectedDay,
                                  DateTime focusedDay,
                                  ) {
                                setState(() {
                                  _selectedDay = selectedDay;
                                  _focusedDay = focusedDay;
                                });
                              },
                              onFormatChanged: (CalendarFormat format) {
                                setState(() {
                                  _calendarFormat = format;
                                });
                              },
                              onPageChanged: (DateTime focusedDay) {
                                _focusedDay = focusedDay;
                              },
                              headerStyle: HeaderStyle(
                                formatButtonVisible: true,
                                titleCentered: true,
                                formatButtonShowsNext: false,
                                titleTextStyle:
                                Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  height: 1.2,
                                ) ??
                                    const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      height: 1.2,
                                    ),
                                formatButtonTextStyle:
                                Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                ) ??
                                    const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      height: 1.2,
                                    ),
                              ),
                              daysOfWeekStyle: DaysOfWeekStyle(
                                weekdayStyle:
                                Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                ) ??
                                    const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2,
                                    ),
                                weekendStyle:
                                Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                  color: colorScheme.primary,
                                ) ??
                                    TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2,
                                      color: colorScheme.primary,
                                    ),
                              ),
                              calendarStyle: const CalendarStyle(
                                outsideDaysVisible: false,
                                markersMaxCount: 0,
                              ),
                              calendarBuilders: CalendarBuilders<String>(
                                defaultBuilder: (
                                    BuildContext context,
                                    DateTime day,
                                    DateTime focusedDay,
                                    ) {
                                  return _buildCalendarDayCell(
                                    context: context,
                                    day: day,
                                    events: _eventsForDay(day),
                                    isSelected: false,
                                    isToday: false,
                                    isOutsideMonth: day.month != focusedDay.month,
                                  );
                                },
                                todayBuilder: (
                                    BuildContext context,
                                    DateTime day,
                                    DateTime focusedDay,
                                    ) {
                                  return _buildCalendarDayCell(
                                    context: context,
                                    day: day,
                                    events: _eventsForDay(day),
                                    isSelected: false,
                                    isToday: true,
                                    isOutsideMonth: day.month != focusedDay.month,
                                  );
                                },
                                selectedBuilder: (
                                    BuildContext context,
                                    DateTime day,
                                    DateTime focusedDay,
                                    ) {
                                  return _buildCalendarDayCell(
                                    context: context,
                                    day: day,
                                    events: _eventsForDay(day),
                                    isSelected: true,
                                    isToday: isSameDay(day, DateTime.now()),
                                    isOutsideMonth: day.month != focusedDay.month,
                                  );
                                },
                                outsideBuilder: (
                                    BuildContext context,
                                    DateTime day,
                                    DateTime focusedDay,
                                    ) {
                                  return _buildCalendarDayCell(
                                    context: context,
                                    day: day,
                                    events: <String>[],
                                    isSelected: false,
                                    isToday: false,
                                    isOutsideMonth: true,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildSelectedDateDetails(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarDayCell({
    required BuildContext context,
    required DateTime day,
    required List<String> events,
    required bool isSelected,
    required bool isToday,
    required bool isOutsideMonth,
  }) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final Color backgroundColor;
    final Color borderColor;
    final Color dayTextColor;
    final Color eventBackgroundColor;
    final Color eventTextColor;

    if (isSelected) {
      backgroundColor = colorScheme.primary;
      borderColor = colorScheme.primary;
      dayTextColor = colorScheme.onPrimary;
      eventBackgroundColor = colorScheme.onPrimary.withValues(alpha: 0.18);
      eventTextColor = colorScheme.onPrimary;
    } else if (isToday) {
      backgroundColor = colorScheme.primaryContainer.withValues(alpha: 0.45);
      borderColor = colorScheme.primary;
      dayTextColor = colorScheme.primary;
      eventBackgroundColor = colorScheme.primary.withValues(alpha: 0.12);
      eventTextColor = colorScheme.primary;
    } else {
      backgroundColor = Colors.transparent;
      borderColor = colorScheme.outline.withValues(alpha: 0.08);
      dayTextColor = isOutsideMonth
          ? colorScheme.onSurface.withValues(alpha: 0.28)
          : colorScheme.onSurface;
      eventBackgroundColor =
          colorScheme.secondaryContainer.withValues(alpha: 0.55);
      eventTextColor = colorScheme.onSecondaryContainer;
    }

    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor,
          width: isToday || isSelected ? 1.2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "${day.day}",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: dayTextColor,
                height: 1,
              ),
            ),
          ),
          const SizedBox(height: 6),
          ...events.take(2).map(
                (String event) => Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: eventBackgroundColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  event,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: eventTextColor,
                    height: 1,
                  ),
                ),
              ),
            ),
          ),
          if (events.length > 2)
            Text(
              "+${events.length - 2} more",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? colorScheme.onPrimary
                    : colorScheme.onSurfaceVariant,
                height: 1,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSelectedDateDetails(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final DateTime? selectedDay = _selectedDay;
    final List<String> selectedEvents =
    selectedDay == null ? <String>[] : _eventsForDay(selectedDay);

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outline.withValues(alpha: 0.08),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              selectedDay == null
                  ? "Selected Date"
                  : "Selected Date: ${_dateKey(selectedDay)}",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            if (selectedEvents.isEmpty)
              Text(
                "No events scheduled.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              )
            else
              ...selectedEvents.map(
                    (String event) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.event,
                        size: 18,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          event,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}