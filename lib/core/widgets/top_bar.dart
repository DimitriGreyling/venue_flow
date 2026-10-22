import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/data/auth_session.dart';
import '../theme/theme_x.dart';

class TopBar extends ConsumerWidget {
  const TopBar({required this.wide});

  final bool wide;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;

    return Container(
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: wide ? 24 : 8),
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(
          bottom: BorderSide(color: cs.outline.withValues(alpha: 0.2)),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          if (!wide)
            Builder(
              builder: (ctx) => IconButton(
                icon: Icon(Icons.menu, color: cs.onSurface),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              ),
            ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 576),
                // child: const _SearchField(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: cs.outline),
            onPressed: () {},
          ),
          if (wide)
            IconButton(
              icon: Icon(Icons.help_outline, color: cs.outline),
              onPressed: () {},
            ),
          if (wide) ...[
            const SizedBox(width: 8),
            Container(width: 1, height: 32, color: cs.outline),
            const SizedBox(width: 12),
          ],
          PopupMenuButton<String>(
            tooltip: 'Account',
            onSelected: (value) async {
              if (value == 'logout') {
                await ref.read(authSessionProvider.notifier).logout();
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'logout', child: Text('Sign out')),
            ],
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: cs.surfaceBright,
                  child: Icon(
                    Icons.person,
                    size: 18,
                    color: cs.onSurfaceVariant,
                  ),
                ),
                if (wide) ...[
                  const SizedBox(width: 12),
                  Text(
                    'Venue Manager',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: cs.primary,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
                const SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
