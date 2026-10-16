import 'package:flutter/material.dart';
import 'package:venue_flow_app/core/enums/appointment_type.dart';
import '../enums/appointment_status.dart';
import '../enums/badge_status.dart';
import '../theme/theme_x.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    required this.status,
    this.showBulletPoint = false,
  });

  final String label;
  final BadgeStatus status;
  final bool showBulletPoint;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      BadgeStatus.success => context.semantic.success,
      BadgeStatus.warning => context.semantic.warning,
      BadgeStatus.info => context.semantic.info,
      BadgeStatus.error => Theme.of(context).colorScheme.error,
      BadgeStatus.neutral => context.semantic.textMuted,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showBulletPoint)
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          if (showBulletPoint) const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
