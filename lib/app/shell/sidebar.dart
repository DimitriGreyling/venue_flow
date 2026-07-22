import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// -------------------- SIDENAV --------------------
class SideNav extends StatelessWidget {
  final bool isDrawer;

  const SideNav({this.isDrawer = false});

  @override
  Widget build(BuildContext context) {
    final items = <({String label, IconData icon, bool active})>[
      (label: 'Dashboard', icon: Icons.dashboard_outlined, active: true),
      (label: 'Venues', icon: Icons.location_on_outlined, active: false),
      (label: 'Events', icon: Icons.event_outlined, active: false),
      (
      label: 'Bookings',
      icon: Icons.confirmation_number_outlined,
      active: false,
      ),
      (label: 'Customers', icon: Icons.group_outlined, active: false),
      (label: 'Staff', icon: Icons.badge_outlined, active: false),
      (label: 'Equipment', icon: Icons.construction_outlined, active: false),
      (label: 'Invoices', icon: Icons.receipt_outlined, active: false),
      (label: 'Forms', icon: Icons.description_outlined, active: false),
      (label: 'Calendar', icon: Icons.calendar_month_outlined, active: false),
      (
      label: 'Notifications',
      icon: Icons.notifications_outlined,
      active: false,
      ),
      (label: 'Settings', icon: Icons.settings_outlined, active: false),
    ];

    final content = Column(
      children: [
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Main Street Arena',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF3525CD),
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Tenant Admin',
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 2),
            itemBuilder: (_, i) {
              final item = items[i];
              return Container(
                decoration: BoxDecoration(
                  color:
                  item.active
                      ? const Color(0x1A3525CD)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border:
                  item.active
                      ? const Border(
                    left: BorderSide(
                      color: Color(0xFF3525CD),
                      width: 4,
                    ),
                  )
                      : null,
                ),
                child: ListTile(
                  dense: true,
                  minLeadingWidth: 24,
                  leading: Icon(
                    item.icon,
                    color:
                    item.active
                        ? const Color(0xFF3525CD)
                        : const Color(0xFF6B7280),
                    size: 20,
                  ),
                  title: Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 14,
                      color:
                      item.active
                          ? const Color(0xFF3525CD)
                          : const Color(0xFF6B7280),
                      fontWeight:
                      item.active ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const Divider(height: 1, color: Color(0xFFE5E7EB)),
        _bottomItem(Icons.swap_horiz, 'Switch Venue'),
        _bottomItem(Icons.account_circle_outlined, 'Profile'),
        const SizedBox(height: 10),
      ],
    );

    if (isDrawer) return SafeArea(child: content);

    return Container(
      width: 240,
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FA),
        border: Border(right: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: content,
    );
  }

  static Widget _bottomItem(IconData icon, String text) => ListTile(
    dense: true,
    minLeadingWidth: 24,
    leading: Icon(icon, size: 20, color: Color(0xFF6B7280)),
    title: Text(
      text,
      style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
    ),
  );
}