import 'package:flutter/cupertino.dart';

class NavItem {
  const NavItem(this.icon, this.label, [this.route]);
  final IconData icon;
  final String label;
  final String? route; // null = page not built yet
}
