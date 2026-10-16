import 'package:flutter/cupertino.dart';
import 'package:venue_flow_app/core/widgets/status_badge.dart';

import '../../../core/enums/badge_status.dart';
import '../domain/appointment.dart';
import 'package:flutter/material.dart';

class AppointmentTile extends StatelessWidget {
  const AppointmentTile({required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final start = appointment.startAtUtc.toLocal();
    final end = appointment.endAtUtc.toLocal();

    final time = '${_formatTime(start)} – ${_formatTime(end)}';

    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.event)),
        title: Text(appointment.venueName),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text('$time\n${_formatLabel(appointment.type.name)}'),
            ),
            const SizedBox(width: 8),
            StatusBadge(
              label: _formatLabel(appointment.status.name),
              status: appointment.status.badgeStatus,
            ),
          ],
        ),
        isThreeLine: true,
      ),
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
