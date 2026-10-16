import 'package:flutter/cupertino.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
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
