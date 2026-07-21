import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    Widget item(String label, String route, IconData icon) {
      final selected = location == route;
      return ListTile(
        leading: Icon(icon),
        title: Text(label),
        selected: selected,
        onTap: () => context.go(route),
      );
    }

    return Material(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text('VenueFlow'),
          const SizedBox(height: 20),
          item('Dashboard', '/dashboard', Icons.dashboard_outlined),
          item('Customers', '/customers', Icons.people_outline),
        ],
      ),
    );
  }
}