import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:venue_flow_app/core/utils/day_of_week_utils.dart';
import 'package:venue_flow_app/core/widgets/top_bar.dart';
import 'package:venue_flow_app/features/appointment_configuration/domain/appointment_configuration.dart';
import 'package:venue_flow_app/features/appointment_configuration/domain/appointment_type.dart';
import 'package:venue_flow_app/features/appointment_configuration/domain/working_hours.dart';
import '../../../../core/theme/theme_x.dart';
import '../../../../core/widgets/side_nav.dart';
import '../../data/repository/appointment_configuration_repository.dart';

class AppointmentConfigMobileView extends ConsumerStatefulWidget {
  const AppointmentConfigMobileView({super.key, this.venueName, this.venueId});

  final String? venueName;
  final String? venueId;

  @override
  ConsumerState<AppointmentConfigMobileView> createState() =>
      _AppointmentConfigMobileViewState();
}

class _AppointmentConfigMobileViewState
    extends ConsumerState<AppointmentConfigMobileView> {
  late bool _enabled = false;
  bool isLoading = false;

  late String _timeZone = 'Africa/Johannesburg';
  late String _approvalMode = 'Manual';

  late int _advanceBookingDays = 90;
  late int _minimumNoticeHours = 24;
  late int _slotIntervalMinutes = 30;
  late int _bufferMinutes = 15;
  late int _maximumBookingsPerSlot = 1;

  late List<WorkingHours> _workingDays = [];
  late AppointmentConfiguration _appointmentConfiguration;
  late List<AppointmentType> _appointmentTypes = [];

  int get _enabledTypes =>
      _appointmentTypes.where((type) => type.enabled).length;

  int get _enabledDays => _workingDays.where((day) => day.enabled).length;

  @override
  void initState() {
    super.initState();
    _fetchAppointmentConfiguration();
  }

  Future<void> _fetchAppointmentConfiguration() async {
    setState(() {
      isLoading = true;
    });
    final repository = ref.watch(appointmentConfigurationRepositoryProvider);
    final appointmentConfig = await repository.getAppointmentConfiguration(
      venueId: 'f2e2eac4-af1e-4105-a666-c1f9fbd3c181',
    );

    setState(() {
      _appointmentConfiguration = appointmentConfig;
      _workingDays = _appointmentConfiguration.workingHours;
      _enabled = _appointmentConfiguration.enabled;
      _appointmentTypes = _appointmentConfiguration.appointmentTypes;
      isLoading = false;
    });
  }

  Future<void> _selectTime(WorkingHours day, bool isStart) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: isStart ? day.startTime : day.endTime,
      helpText: isStart ? 'Select opening time' : 'Select closing time',
    );

    if (selected == null || !mounted) return;

    setState(() {
      // if (isStart) {
      //   day.startTime = selected;
      // } else {
      //   day.endTime = selected;
      // }
    });
  }

  void _saveConfiguration() {
    final enabledTypes = _appointmentTypes
        .where((type) => type.enabled)
        .toList();

    if (_enabled && enabledTypes.isEmpty) {
      _showMessage('Enable at least one appointment type.');
      return;
    }

    if (_enabled && _enabledDays == 0) {
      _showMessage('Enable at least one working day.');
      return;
    }

    for (final day in _workingDays.where((day) => day.enabled)) {
      final startMinutes = day.startTime.hour * 60 + day.startTime.minute;
      final endMinutes = day.endTime.hour * 60 + day.endTime.minute;

      if (endMinutes <= startMinutes) {
        // _showMessage('${day.name}: closing time must be after opening time.');
        _showMessage(': closing time must be after opening time.');
        return;
      }
    }

    // TODO: Map these values to your API request DTO and call:
    // PUT /api/venues/${widget.venueId}/appointment-configuration

    _showMessage('Configuration validated. API integration is pending.');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    const _wideBreakpoint = 1000.0;
    final wide = MediaQuery.of(context).size.width >= _wideBreakpoint;

    return Scaffold(
      drawer: wide
          ? null
          : Drawer(
              width: 240,
              backgroundColor: cs.surface,
              child: SideNav(activePath: '/forms'),
            ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              children: [
                TopBar(wide: wide),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(24),
                    children: [
                      Text(
                        widget.venueName ?? '',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Configure appointment availability, booking rules, '
                        'working hours and approval settings for this venue.',
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),
                      _buildOverview(isLoading: isLoading, cs: cs),
                      const SizedBox(height: 24),
                      _buildGeneralSettings(isLoading: isLoading, cs: cs),
                      const SizedBox(height: 24),
                      _buildAppointmentTypes(isLoading: isLoading, cs: cs),
                      const SizedBox(height: 24),
                      _buildWorkingHours(isLoading: isLoading, cs: cs),
                      const SizedBox(height: 24),
                      _buildAvailabilityRules(isLoading: isLoading, cs: cs),
                      const SizedBox(height: 32),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FilledButton.icon(
                          onPressed: isLoading ? null : _saveConfiguration,
                          icon: const Icon(Icons.save_outlined),
                          label: const Text('Save configuration'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverview({required bool isLoading, required ColorScheme cs}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 600;
        final width = compact
            ? constraints.maxWidth
            : (constraints.maxWidth - 24) / 3;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            SizedBox(
              width: width,
              child: _summaryCard(
                icon: Icons.calendar_month_outlined,
                label: 'Booking status',
                value: _enabled ? 'Enabled' : 'Disabled',
                description: _enabled
                    ? 'Accepting requests'
                    : 'Bookings are switched off',
                isLoading: isLoading,
                cs: cs,
              ),
            ),
            SizedBox(
              width: width,
              child: _summaryCard(
                icon: Icons.event_available_outlined,
                label: 'Appointment types',
                value: '$_enabledTypes enabled',
                description: 'Of ${_appointmentTypes.length} configured',
                isLoading: isLoading,
                cs: cs,
              ),
            ),
            SizedBox(
              width: width,
              child: _summaryCard(
                icon: Icons.access_time,
                label: 'Working days',
                value: '$_enabledDays days',
                description: 'Per week',
                isLoading: isLoading,
                cs: cs,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _summaryCard({
    required IconData icon,
    required String label,
    required String value,
    required String description,
    required bool isLoading,
    required ColorScheme cs,
  }) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Skeletonizer(
      enabled: isLoading,
      effect: ShimmerEffect(
        baseColor: cs.surfaceContainerLow,
        highlightColor: cs.surface,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton.leaf(child: Icon(icon, color: colors.primary)),
              const SizedBox(height: 12),
              Skeleton.leaf(child: Text(label)),
              const SizedBox(height: 4),
              Skeleton.leaf(
                child: Text(
                  value,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Skeleton.leaf(
                child: Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Widget> children,
    required bool isLoading,
    required ColorScheme cs,
    Widget? trailing,
  }) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Skeletonizer(
      enabled: isLoading,
      effect: ShimmerEffect(
        baseColor: cs.surfaceContainerLow,
        highlightColor: cs.surface,
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: colors.onPrimaryContainer),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Skeleton.leaf(
                          child: Text(
                            title,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Skeleton.leaf(
                          child: Text(
                            subtitle,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (trailing != null) trailing,
                ],
              ),
              const SizedBox(height: 20),
              ...children,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGeneralSettings({
    required bool isLoading,
    required ColorScheme cs,
  }) {
    return _sectionCard(
      isLoading: isLoading,
      cs: cs,
      icon: Icons.tune,
      title: 'General settings',
      subtitle: 'Control whether appointments can be booked.',
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Enable appointment bookings'),
          subtitle: const Text(
            'Disable this to stop new bookings for this venue.',
          ),
          value: _enabled,
          onChanged: (value) => setState(() => _enabled = value),
        ),
        const Divider(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final timeZoneField = DropdownButtonFormField<String>(
              value: _timeZone,
              decoration: const InputDecoration(
                labelText: 'Time zone',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Africa/Johannesburg',
                  child: Text('South Africa (SAST)'),
                ),
                DropdownMenuItem(value: 'UTC', child: Text('UTC')),
                DropdownMenuItem(
                  value: 'Europe/London',
                  child: Text('United Kingdom'),
                ),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _timeZone = value);
              },
            );

            final approvalField = DropdownButtonFormField<String>(
              value: _approvalMode,
              decoration: const InputDecoration(
                labelText: 'Booking approval',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Manual',
                  child: Text('Manual approval'),
                ),
                DropdownMenuItem(
                  value: 'Automatic',
                  child: Text('Automatic confirmation'),
                ),
              ],
              onChanged: _enabled
                  ? (value) {
                      if (value != null) {
                        setState(() => _approvalMode = value);
                      }
                    }
                  : null,
            );

            if (constraints.maxWidth < 600) {
              return Column(
                children: [
                  timeZoneField,
                  const SizedBox(height: 16),
                  approvalField,
                ],
              );
            }

            return Row(
              children: [
                Expanded(child: timeZoneField),
                const SizedBox(width: 16),
                Expanded(child: approvalField),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildAppointmentTypes({
    required bool isLoading,
    required ColorScheme cs,
  }) {
    return _sectionCard(
      isLoading: isLoading,
      cs: cs,
      icon: Icons.event_note_outlined,
      title: 'Appointment types',
      subtitle: 'Choose which appointments clients can request.',
      trailing: IconButton(
        tooltip: 'Add appointment type',
        onPressed: _addAppointmentType,
        icon: const Icon(Icons.add),
      ),
      children: [
        for (final type in _appointmentTypes) _buildAppointmentTypeRow(type),
        const SizedBox(height: 8),
        Text(
          'Type codes must be supported by the backend before bookings '
          'can use them.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildAppointmentTypeRow(AppointmentType type) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 500;

          final info = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type.displayName,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                type.typeCode,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          );

          final duration = DropdownButtonFormField<int>(
            value: type.durationMinutes,
            decoration: const InputDecoration(
              labelText: 'Duration',
              border: OutlineInputBorder(),
              isDense: true,
            ),
            items: const [15, 30, 45, 60, 90, 120]
                .map(
                  (minutes) => DropdownMenuItem(
                    value: minutes,
                    child: Text('$minutes minutes'),
                  ),
                )
                .toList(),
            onChanged: _enabled
                ? (value) {
                    // if (value != null) {
                    //   setState(() => type.durationMinutes = value);
                    // }
                  }
                : null,
          );

          final toggle = Switch(
            value: type.enabled,
            onChanged: _enabled
                ? null //(value) => setState(() => type.enabled = value)
                : null,
          );

          if (compact) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(child: info),
                    toggle,
                  ],
                ),
                const SizedBox(height: 12),
                duration,
                if (type.typeCode != 'VenueViewing')
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () =>
                          setState(() => _appointmentTypes.remove(type)),
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Remove'),
                    ),
                  ),
              ],
            );
          }

          return Row(
            children: [
              toggle,
              const SizedBox(width: 8),
              Expanded(child: info),
              const SizedBox(width: 16),
              SizedBox(width: 160, child: duration),
              IconButton(
                tooltip: 'Remove appointment type',
                onPressed: type.typeCode == 'VenueViewing'
                    ? null
                    : () => setState(() => _appointmentTypes.remove(type)),
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _addAppointmentType() async {
    final nameController = TextEditingController();
    int selectedDuration = 30;

    final result = await showDialog<_NewAppointmentType>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add appointment type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Display name',
                  hintText: 'e.g. Wedding Consultation',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: selectedDuration,
                decoration: const InputDecoration(
                  labelText: 'Duration',
                  border: OutlineInputBorder(),
                ),
                items: const [15, 30, 45, 60, 90, 120]
                    .map(
                      (minutes) => DropdownMenuItem(
                        value: minutes,
                        child: Text('$minutes minutes'),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setDialogState(() => selectedDuration = value);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final name = nameController.text.trim();
                if (name.isEmpty) return;

                Navigator.pop(
                  dialogContext,
                  _NewAppointmentType(
                    name: name,
                    durationMinutes: selectedDuration,
                  ),
                );
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );

    nameController.dispose();

    if (result == null || !mounted) return;

    final code = result.name
        .replaceAll(RegExp(r'[^a-zA-Z0-9 ]'), '')
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
        .join();

    if (code.isEmpty ||
        _appointmentTypes.any((type) => type.typeCode == code)) {
      _showMessage('Enter a unique appointment type name.');
      return;
    }

    setState(() {
      // _appointmentTypes.add(
      //   _AppointmentTypeSetting(
      //     typeCode: code,
      //     displayName: result.name,
      //     enabled: true,
      //     durationMinutes: result.durationMinutes,
      //     sortOrder: _appointmentTypes.length + 1,
      //   ),
      // );
    });
  }

  Widget _buildWorkingHours({
    required bool isLoading,
    required ColorScheme cs,
  }) {
    return _sectionCard(
      isLoading: isLoading,
      cs: cs,
      icon: Icons.schedule,
      title: 'Working hours',
      subtitle: 'Define when appointments can be scheduled.',
      trailing: Text(
        '$_enabledDays of 7 days',
        style: Theme.of(context).textTheme.labelLarge,
      ),
      children: [for (final day in _workingDays) _buildWorkingDayRow(day)],
    );
  }

  Widget _buildWorkingDayRow(WorkingHours day) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 520;

          Widget timeButton(bool isStart) {
            final time = isStart ? day.startTime : day.endTime;

            return OutlinedButton(
              onPressed: _enabled && day.enabled
                  ? () => _selectTime(day, isStart)
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.access_time, size: 16),
                  const SizedBox(width: 6),
                  Text(time.format(context)),
                ],
              ),
            );
          }

          final toggle = Switch(
            value: day.enabled,
            onChanged: _enabled
                ? null // (value) => setState(() => day.enabled = value)
                : null,
          );

          if (compact) {
            return Column(
              children: [
                Row(
                  children: [
                    toggle,
                    Expanded(
                      child: Text(
                        '',
                      ), //Text(day.name, style: theme.textTheme.bodyLarge),
                    ),
                    if (!day.enabled) const Text('Closed'),
                  ],
                ),
                if (day.enabled)
                  Row(
                    children: [
                      Expanded(child: timeButton(true)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('to'),
                      ),
                      Expanded(child: timeButton(false)),
                    ],
                  ),
              ],
            );
          }

          return Row(
            children: [
              SizedBox(width: 52, child: toggle),
              const SizedBox(width: 12),
              SizedBox(
                width: 120,
                child: Text(
                  getDayOfWeekName(day.dayOfWeek),
                ), //Text(day.name, style: theme.textTheme.bodyLarge),
              ),
              const Spacer(),
              if (day.enabled) ...[
                SizedBox(width: 135, child: timeButton(true)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('to'),
                ),
                SizedBox(width: 135, child: timeButton(false)),
              ] else
                SizedBox(
                  width: 135,
                  child: Text(
                    'Closed',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAvailabilityRules({
    required bool isLoading,
    required ColorScheme cs,
  }) {
    return _sectionCard(
      isLoading: isLoading,
      cs: cs,
      icon: Icons.rule_outlined,
      title: 'Availability rules',
      subtitle: 'Control booking limits and time between appointments.',
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 650 ? 2 : 1;
            final width = columns == 2
                ? (constraints.maxWidth - 16) / 2
                : constraints.maxWidth;

            return Wrap(
              spacing: 16,
              runSpacing: 20,
              children: [
                SizedBox(
                  width: width,
                  child: _numberDropdown(
                    label: 'Advance booking limit',
                    value: _advanceBookingDays,
                    suffix: 'days',
                    values: const [7, 14, 30, 60, 90, 180, 365],
                    onChanged: (value) =>
                        setState(() => _advanceBookingDays = value),
                  ),
                ),
                SizedBox(
                  width: width,
                  child: _numberDropdown(
                    label: 'Minimum booking notice',
                    value: _minimumNoticeHours,
                    suffix: 'hours',
                    values: const [0, 2, 6, 12, 24, 48, 72],
                    onChanged: (value) =>
                        setState(() => _minimumNoticeHours = value),
                  ),
                ),
                SizedBox(
                  width: width,
                  child: _numberDropdown(
                    label: 'Slot interval',
                    value: _slotIntervalMinutes,
                    suffix: 'minutes',
                    values: const [15, 30, 45, 60],
                    onChanged: (value) =>
                        setState(() => _slotIntervalMinutes = value),
                  ),
                ),
                SizedBox(
                  width: width,
                  child: _numberDropdown(
                    label: 'Buffer between appointments',
                    value: _bufferMinutes,
                    suffix: 'minutes',
                    values: const [0, 5, 10, 15, 30, 60],
                    onChanged: (value) =>
                        setState(() => _bufferMinutes = value),
                  ),
                ),
                SizedBox(
                  width: width,
                  child: _numberDropdown(
                    label: 'Maximum simultaneous bookings',
                    value: _maximumBookingsPerSlot,
                    suffix: 'bookings',
                    values: const [1, 2, 3, 4, 5, 10],
                    onChanged: (value) =>
                        setState(() => _maximumBookingsPerSlot = value),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'The buffer is additional time reserved around an '
                  'appointment. The backend must enforce these rules '
                  'when creating or rescheduling bookings.',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _numberDropdown({
    required String label,
    required int value,
    required String suffix,
    required List<int> values,
    required ValueChanged<int> onChanged,
  }) {
    return DropdownButtonFormField<int>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: values
          .map(
            (number) =>
                DropdownMenuItem(value: number, child: Text('$number $suffix')),
          )
          .toList(),
      onChanged: _enabled
          ? (newValue) {
              if (newValue != null) onChanged(newValue);
            }
          : null,
    );
  }
}

class _AppointmentTypeSetting {
  _AppointmentTypeSetting({
    required this.typeCode,
    required this.displayName,
    required this.enabled,
    required this.durationMinutes,
    required this.sortOrder,
  });

  final String typeCode;
  final String displayName;
  bool enabled;
  int durationMinutes;
  int sortOrder;
}

class _NewAppointmentType {
  const _NewAppointmentType({
    required this.name,
    required this.durationMinutes,
  });

  final String name;
  final int durationMinutes;
}
