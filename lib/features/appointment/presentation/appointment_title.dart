import 'package:flutter/cupertino.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:venue_flow_app/core/widgets/status_badge.dart';
import 'package:venue_flow_app/features/appointment/domain/appointment_days.dart';
import 'package:venue_flow_app/features/appointment/presentation/appointment_calendar_provider.dart';

import '../../../core/enums/badge_status.dart';
import '../../../core/theme/theme_x.dart' show ThemeX;
import '../domain/appointment.dart';
import 'package:flutter/material.dart';

class AppointmentTitle extends ConsumerStatefulWidget {
  const AppointmentTitle({
    required this.appointmentId,
    required this.appointmentStartDate,
    required this.appointmentEndDate,
  });

  final String appointmentId;
  final DateTime appointmentStartDate;
  final DateTime appointmentEndDate;

  @override
  ConsumerState<AppointmentTitle> createState() => _AppointmentTitleState();
}

class _AppointmentTitleState extends ConsumerState<AppointmentTitle> {
  @override
  Widget build(BuildContext context) {
    final start = widget.appointmentStartDate.toLocal();
    final end = widget.appointmentEndDate.toLocal();

    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;

    final time = '${_formatTime(start)} – ${_formatTime(end)}';

    final appointmentDetailAsync = ref.watch(
      appointmentInformationByIdProvider(widget.appointmentId),
    );

    return appointmentDetailAsync.when(
      loading: () => Skeletonizer(
        enabled: true,
        effect: ShimmerEffect(
          baseColor: cs.surfaceContainerLow,
          highlightColor: cs.surface,
        ),
        child: Card(
          child: ListTile(
            leading: Skeleton.leaf(
              enabled: true,
              child: const CircleAvatar(child: Icon(Icons.event)),
            ),
            title: const Text(
              'Garden Venue Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                const Expanded(
                  child: Text(
                    '10:30 AM\nVenue Viewing',
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
        ),
      ),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (appointment) {
        return Card(
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const CircleAvatar(child: Icon(Icons.event))],
            ),
            title: Text(
              appointment.venueName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$time\n${_formatLabel(appointment.type.name)}',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),

                    const SizedBox(width: 8),
                    StatusBadge(
                      label: _formatLabel(appointment.status.name),
                      status: appointment.status.badgeStatus,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Mdi.eye)),
                    IconButton(onPressed: () {}, icon: Icon(Mdi.bookEdit)),
                  ],
                ),
              ],
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }

  String _formatTime(DateTime value) {
    final hour = value.hour % 12 == 0 ? 12 : value.hour % 12;
    final minute = value.minute.toString().padLeft(2, '0');
    final period = value.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  String _formatLabel(String value) {
    final spaced = value.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) => '${match[1]} ${match[2]}',
    );

    return spaced.isEmpty
        ? spaced
        : '${spaced[0].toUpperCase()}${spaced.substring(1)}';
  }
}
