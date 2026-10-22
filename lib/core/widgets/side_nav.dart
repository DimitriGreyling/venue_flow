import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';

import '../config/nav_footer.dart';
import '../config/nav_item.dart';
import '../theme/theme_x.dart';
import 'nav_tile.dart';

const _navItems = [
  NavItem(Mdi.monitorDashboard, 'Dashboard', '/dashboard'),
  NavItem(Mdi.floorPlan, 'Venues', '/venues'),
  NavItem(Mdi.partyPopper, 'Events'),
  NavItem(Mdi.ticketConfirmationOutline, 'Bookings'),
  NavItem(Mdi.accountGroupOutline, 'Customers', '/customers'),
  NavItem(Mdi.badgeAccountOutline, 'Staff'),
  NavItem(Mdi.accountHardHatOutline, 'Equipment'),
  NavItem(Mdi.receiptOutline, 'Invoices'),
  NavItem(Mdi.fileAccountOutline, 'Forms', '/forms'),
  NavItem(Mdi.calendarAccountOutline, 'Calendar', '/appointments'),
  NavItem(Mdi.noteOutline, 'Notifications'),
  NavItem(Mdi.accountSettingsOutline, 'Settings'),
  NavItem(
    Mdi.bookSettingsOutline,
    'Appointment Config',
    '/appointment-configuration',
  ),
];

class SideNav extends StatelessWidget {
  const SideNav({required this.activePath});

  final String activePath;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;

    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(
          right: BorderSide(color: sem.textMuted.withValues(alpha: 0.1)),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Main Street Arena', // TODO: tenant name from API
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: cs.primary,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Tenant Admin',
                    style: TextStyle(fontSize: 14, color: cs.onSurface),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                for (final item in _navItems)
                  NavTile(item: item, active: item.route == activePath),
              ],
            ),
          ),
          Divider(height: 1, color: sem.textMuted.withValues(alpha: 0.1)),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Column(
              children: [
                for (final item in navFooter)
                  NavTile(item: item, active: false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
