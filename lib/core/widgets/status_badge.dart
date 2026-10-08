import 'package:flutter/material.dart';
import '../theme/theme_x.dart';

enum BadgeStatus { success, warning, error, info }

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.label, required this.status});

  final String label;
  final BadgeStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      BadgeStatus.success => context.semantic.success,
      BadgeStatus.warning => context.semantic.warning,
      BadgeStatus.info => context.semantic.info,
      BadgeStatus.error => Theme.of(context).colorScheme.error,
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
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
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