import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/nav_item.dart';
import '../theme/theme_x.dart';

class NavTile extends StatefulWidget {
  const NavTile({super.key, required this.item, required this.active});

  final NavItem item;
  final bool active;

  @override
  State<NavTile> createState() => _NavTileState();
}

class _NavTileState extends State<NavTile> {
  // You can now define local state variables or AnimationControllers here if needed

  @override
  Widget build(BuildContext context) {
    // Correctly initialize Theme objects inside the build method context
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;

    // Use widget.active to reference properties from the parent configuration
    final color = widget.active ? cs.primary : sem.textMuted;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: widget.active
              ? cs.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          child: InkWell(
            onTap: () {
              final route = widget.item.route;
              if (route == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${widget.item.label} is coming soon'),
                  ),
                );
                return;
              }
              // Adjust route execution based on requirements
              if (route != '/dashboard') {
                context.go(route);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: widget.active ? cs.primary : Colors.transparent,
                    width: 4,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Icon(widget.item.icon, size: 22, color: color),
                  const SizedBox(width: 12),
                  Text(
                    widget.item.label,
                    style: TextStyle(
                      fontSize: 14,
                      color: color,
                      fontWeight: widget.active
                          ? FontWeight.w700
                          : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
