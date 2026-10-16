import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/nav_footer.dart';
import '../config/nav_item.dart';
import '../theme/theme_x.dart';
import 'nav_tile.dart';

const _navItems = [
  NavItem(Icons.dashboard_outlined, 'Dashboard', '/dashboard'),
  NavItem(Icons.location_on_outlined, 'Venues', '/venues'),
  NavItem(Icons.event_outlined, 'Events'),
  NavItem(Icons.confirmation_number_outlined, 'Bookings'),
  NavItem(Icons.group_outlined, 'Customers'),
  NavItem(Icons.badge_outlined, 'Staff'),
  NavItem(Icons.construction_outlined, 'Equipment'),
  NavItem(Icons.receipt_outlined, 'Invoices'),
  NavItem(Icons.description_outlined, 'Forms', '/forms'),
  NavItem(Icons.calendar_month_outlined, 'Calendar','/appointments'),
  NavItem(Icons.notifications_outlined, 'Notifications'),
  NavItem(Icons.settings_outlined, 'Settings'),
];

class SideNav extends StatelessWidget {
  const SideNav({required this.activePath});

  final String activePath;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;

    return Container(
      width: 240,
      decoration:  BoxDecoration(
        color: cs.surface,
        border: Border(right: BorderSide(color: sem.textMuted.withValues(alpha: 0.1))),
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
