import 'appointment_status.dart';

enum BadgeStatus { success, warning, error, info, neutral }

//extension that converts appointment statuses to badge styles
extension AppointmentStatusBadge on AppointmentStatus {
  BadgeStatus get badgeStatus {
    switch (this) {
      case AppointmentStatus.pending:
        return BadgeStatus.info;

      case AppointmentStatus.confirmed:
      case AppointmentStatus.completed:
        return BadgeStatus.success;

      case AppointmentStatus.rescheduleProposed:
        return BadgeStatus.warning;

      case AppointmentStatus.declined:
      case AppointmentStatus.cancelled:
      case AppointmentStatus.noShow:
        return BadgeStatus.error;
      default:
        return BadgeStatus.neutral;
    }
  }
}
