import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/theme_x.dart';
import '../../auth/presentation/auth_session.dart';

const _maxWidth = 1440.0;

// The global button themes use Size.fromHeight (infinite width).
// Override it here so buttons can sit inside Rows.
final _btnMin = const Size(0, 44);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authed = ref.watch(authSessionProvider).value ?? false;
    final mobile = MediaQuery.sizeOf(context).width < 768;

    return Scaffold(
      endDrawer: mobile ? _MobileMenu(authed: authed) : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 64),
                _Hero(authed: authed),
                const _LogoStrip(),
                const _Features(),
                const _Footer(),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _NavBar(authed: authed, mobile: mobile),
          ),
        ],
      ),
    );
  }
}

/// Centers content at max width with responsive side margins.
class _Section extends StatelessWidget {
  const _Section({required this.child, this.padding = EdgeInsets.zero});

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 768;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _maxWidth),
        child: Padding(
          padding: padding.copyWith(
            left: mobile ? 16 : 24,
            right: mobile ? 16 : 24,
          ),
          child: child,
        ),
      ),
    );
  }
}

// ───────────────────────── NAV ─────────────────────────

class _NavBar extends StatelessWidget {
  const _NavBar({required this.authed, required this.mobile});

  final bool authed;
  final bool mobile;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: cs.surface.withValues(alpha: 0.7),
            border: Border(
              bottom: BorderSide(color: context.semantic.borderSubtle),
            ),
          ),
          child: _Section(
            child: Row(
              children: [
                Icon(Icons.dashboard_customize, color: cs.primary, size: 28),
                const SizedBox(width: 8),
                Text(
                  'Venue Manager',
                  style: t.headlineMedium?.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                  ),
                ),
                if (!mobile) ...[
                  const SizedBox(width: 32),
                  for (final l in const ['Product', 'Solutions', 'Pricing'])
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: _NavLink(l),
                    ),
                ],
                const Spacer(),
                if (authed)
                  FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: _btnMin,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                    onPressed: () => context.go('/venues'),
                    child: const Text('Dashboard'),
                  )
                else ...[
                  if (!mobile)
                    TextButton(
                      onPressed: () => context.go('/login'),
                      child: const Text('Log In'),
                    ),
                  const SizedBox(width: 8),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: _btnMin,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                    onPressed: () => context.go('/login'),
                    child: const Text('Get Started'),
                  ),
                ],
                if (mobile)
                  Builder(
                    builder: (ctx) => IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () => Scaffold.of(ctx).openEndDrawer(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink(this.label);

  final String label;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final muted = context.semantic.textMuted;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: _hover ? cs.primary : muted,
            ),
          ),
          const SizedBox(height: 2),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 2,
            width: _hover ? 48 : 0,
            color: cs.primary,
          ),
        ],
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  const _MobileMenu({required this.authed});

  final bool authed;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (final l in const ['Product', 'Solutions', 'Pricing'])
              ListTile(title: Text(l), onTap: () => Navigator.pop(context)),
            const Divider(),
            if (!authed)
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Log In'),
                onTap: () => context.go('/login'),
              ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── HERO ─────────────────────────

class _Hero extends StatelessWidget {
  const _Hero({required this.authed});

  final bool authed;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;
    final sem = context.semantic;
    final mobile = MediaQuery.sizeOf(context).width < 768;
    final titleSize = mobile ? 40.0 : 64.0;

    return Container(
      decoration: BoxDecoration(color: Color(0xFFE9E7FD)),
      child: _Section(
        padding: const EdgeInsets.only(top: 64, bottom: 80),
        child: Column(
          children: [
            // Pill badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(color: cs.primary.withValues(alpha: 0.1)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.bolt, size: 16, color: cs.primary),
                  const SizedBox(width: 6),
                  Text(
                    'NEW: AI-POWERED SCHEDULING',
                    style: t.labelMedium?.copyWith(
                      color: cs.primary,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                style: t.displayLarge?.copyWith(
                  fontSize: titleSize,
                  height: 1.1,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -2,
                  color: sem.textMain,
                ),
                children: [
                  const TextSpan(text: 'Streamline Your '),
                  TextSpan(
                    text: 'Venue',
                    style: TextStyle(
                      color: cs.primary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const TextSpan(text: ' Operations'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 672),
              child: Text(
                'The all-in-one platform for managing spaces, events, staff, '
                'and billing. Built for multi-tenant environments with '
                'enterprise-grade security and real-time insights.',
                textAlign: TextAlign.center,
                style: t.bodyLarge?.copyWith(color: sem.textMuted),
              ),
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(0, 56),
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => context.go(authed ? '/venues' : '/login'),
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(Icons.arrow_forward, size: 16),
                  label: const Text('Get Started'),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 56),
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    foregroundColor: sem.textMain,
                    backgroundColor: cs.surfaceContainerLowest,
                    side: BorderSide(color: sem.borderSubtle),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Book a Demo'),
                ),
              ],
            ),
            const SizedBox(height: 64),
            const _DashboardPreview(),
          ],
        ),
      ),
    );
  }
}

class _DashboardPreview extends StatelessWidget {
  const _DashboardPreview();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    final desktop = MediaQuery.sizeOf(context).width >= 1024;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1024),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Glow
          // Positioned.fill(
          //   child: Container(
          //     margin: const EdgeInsets.all(-4),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(20),
          //       gradient: LinearGradient(colors: [
          //         cs.primary.withValues(alpha: 0.25),
          //         cs.secondary.withValues(alpha: 0.25),
          //       ]),
          //     ),
          //   ),
          // ),

          // Positioned(
          //   left: -4,
          //   right: -4,
          //   top: -4,
          //   bottom: -4,
          //   child: DecoratedBox(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(20),
          //       gradient: LinearGradient(colors: [
          //         cs.primary.withValues(alpha: 0.25),
          //         cs.secondary.withValues(alpha: 0.25),
          //       ]),
          //     ),
          //   ),
          // ),
          // Window
          // Container(
          //   decoration: BoxDecoration(
          //     color: cs.surface,
          //     borderRadius: BorderRadius.circular(16),
          //     border: Border.all(color: sem.borderSubtle),
          //     boxShadow: const [
          //       BoxShadow(
          //           color: Color(0x33000000),
          //           blurRadius: 40,
          //           offset: Offset(0, 20)),
          //     ],
          //   ),
          //   clipBehavior: Clip.antiAlias,
          //   child: Column(
          //     children: [
          //       // Browser bar
          //       Container(
          //         padding:
          //         const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          //         color: cs.surfaceContainerLow,
          //         child: Row(
          //           children: [
          //             for (final c in [cs.error, sem.warning, sem.success])
          //               Container(
          //                 width: 12,
          //                 height: 12,
          //                 margin: const EdgeInsets.only(right: 6),
          //                 decoration: BoxDecoration(
          //                     color: c.withValues(alpha: 0.3),
          //                     shape: BoxShape.circle),
          //               ),
          //             const SizedBox(width: 10),
          //             Container(
          //               height: 24,
          //               padding: const EdgeInsets.symmetric(horizontal: 8),
          //               decoration: BoxDecoration(
          //                 color: cs.surfaceContainerHigh,
          //                 borderRadius: BorderRadius.circular(6),
          //               ),
          //               child: Row(
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   Icon(Icons.lock, size: 12, color: sem.textMuted),
          //                   const SizedBox(width: 4),
          //                   Text('admin.venuemanager.io/dashboard',
          //                       style: TextStyle(
          //                           fontSize: 10, color: sem.textMuted)),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       const AspectRatio(aspectRatio: 16 / 9, child: _MockDashboard()),
          //     ],
          //   ),
          // ),
          Container(
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: sem.borderSubtle),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 40,
                  offset: Offset(0, 20),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                // Browser bar
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  color: cs.surfaceContainerLow,
                  child: Row(
                    children: [
                      for (final c in [cs.error, sem.warning, sem.success])
                        Container(
                          width: 12,
                          height: 12,
                          margin: const EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                            color: c.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                        ),
                      const SizedBox(width: 10),
                      Container(
                        height: 24,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.lock, size: 12, color: sem.textMuted),
                            const SizedBox(width: 4),
                            Text(
                              'admin.venuemanager.io/dashboard',
                              style: TextStyle(
                                fontSize: 10,
                                color: sem.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const AspectRatio(aspectRatio: 16 / 9, child: _MockDashboard()),
                // Image.asset('assets/dashboard_image.webp', fit: BoxFit.cover),
              ],
            ),
          ),

          if (desktop) ...[
            Positioned(
              right: -48,
              top: 120,
              child: _Floating(
                delay: 1,
                child: _StatCard(
                  icon: Icons.trending_up,
                  color: sem.success,
                  label: 'Revenue Growth',
                  value: '+24.8%',
                ),
              ),
            ),
            Positioned(
              left: -48,
              bottom: 120,
              child: _Floating(
                child: _StatCard(
                  icon: Icons.groups,
                  color: cs.primary,
                  label: 'Active Users',
                  value: '1.2k',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Simple drawn stand-in for the dashboard screenshot.
class _MockDashboard extends StatelessWidget {
  const _MockDashboard();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;

    Widget card(Color c, {int flex = 1}) => Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          color: cs.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: sem.borderSubtle),
        ),
        child: Center(
          child: Container(
            width: 60,
            height: 6,
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      ),
    );

    return Row(
      children: [
        Container(width: 140, color: cs.inverseSurface),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      card(cs.primary, flex: 2),
                      const SizedBox(width: 12),
                      card(sem.success),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      card(sem.info),
                      const SizedBox(width: 12),
                      card(sem.warning, flex: 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final sem = context.semantic;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: sem.borderSubtle),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: color.withValues(alpha: 0.1),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(label, style: t.labelSmall),
                  Text(value, style: t.headlineMedium),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Gentle up/down bobbing (the CSS "floating" animation).
class _Floating extends StatefulWidget {
  const _Floating({required this.child, this.delay = 0});

  final Widget child;
  final double delay;

  @override
  State<_Floating> createState() => _FloatingState();
}

class _FloatingState extends State<_Floating>
    with SingleTickerProviderStateMixin {
  late final _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: (widget.delay * 1000).toInt()), () {
      if (mounted) _c.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CurvedAnimation(parent: _c, curve: Curves.easeInOut),
      builder: (_, child) => Transform.translate(
        offset: Offset(0, -10 * Curves.easeInOut.transform(_c.value)),
        child: child,
      ),
      child: widget.child,
    );
  }
}

// ───────────────────────── LOGOS ─────────────────────────

class _LogoStrip extends StatelessWidget {
  const _LogoStrip();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    final t = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerLowest,
        border: Border.symmetric(
          horizontal: BorderSide(color: sem.borderSubtle),
        ),
      ),
      child: _Section(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          children: [
            Text(
              'TRUSTED BY INDUSTRY LEADERS WORLDWIDE',
              textAlign: TextAlign.center,
              style: t.labelMedium?.copyWith(letterSpacing: 3),
            ),
            const SizedBox(height: 32),
            Opacity(
              opacity: 0.5,
              child: Wrap(
                spacing: 48,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  for (final n in const [
                    'EVENTUM',
                    'STRATOS',
                    'COREVENUE',
                    'URBANSPACE',
                    'NEXUS HALL',
                  ])
                    Text(
                      n,
                      style: t.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: sem.textMain,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── FEATURES ─────────────────────────

class _Features extends StatelessWidget {
  const _Features();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final sem = context.semantic;
    final desktop = MediaQuery.sizeOf(context).width >= 768;
    const gap = 24.0;

    final multiTenant = const _MultiTenantCard();
    final form = _FeatureCard(
      icon: Icons.dynamic_form,
      color: Theme.of(context).colorScheme.secondary,
      title: 'Dynamic Form Builder',
      body:
          'Create custom intake forms, surveys, and booking questionnaires '
          'without writing a single line of code.',
    );
    final analytics = _FeatureCard(
      icon: Icons.insights,
      color: sem.info,
      title: 'Real-time Analytics',
      body:
          'Track revenue, occupancy rates, and event performance with live '
          'dashboards and automated email reports.',
    );
    final cta = const _CtaCard();

    return _Section(
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: Column(
        children: [
          Text(
            'Powerful Features for Modern Venues',
            textAlign: TextAlign.center,
            style: t.displayLarge?.copyWith(fontSize: 32),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 576),
            child: Text(
              'Everything you need to run your venue ecosystem in one place, '
              'with no compromises on scale or security.',
              textAlign: TextAlign.center,
              style: t.bodyMedium?.copyWith(color: sem.textMuted),
            ),
          ),
          const SizedBox(height: 64),
          if (desktop) ...[
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 8, child: multiTenant),
                  const SizedBox(width: gap),
                  Expanded(flex: 4, child: form),
                ],
              ),
            ),
            const SizedBox(height: gap),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 4, child: analytics),
                  const SizedBox(width: gap),
                  Expanded(flex: 8, child: cta),
                ],
              ),
            ),
          ] else ...[
            multiTenant,
            const SizedBox(height: gap),
            form,
            const SizedBox(height: gap),
            analytics,
            const SizedBox(height: gap),
            cta,
          ],
        ],
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  const _CardShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: context.semantic.borderSubtle),
      ),
      child: child,
    );
  }
}

class _IconBox extends StatelessWidget {
  const _IconBox(this.icon, this.color);

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: 48,
    height: 48,
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Icon(icon, color: color),
  );
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IconBox(icon, color),
          const SizedBox(height: 24),
          Text(title, style: t.headlineMedium),
          const SizedBox(height: 12),
          Text(
            body,
            style: t.bodyMedium?.copyWith(color: context.semantic.textMuted),
          ),
        ],
      ),
    );
  }
}

class _MultiTenantCard extends StatelessWidget {
  const _MultiTenantCard();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;
    final sem = context.semantic;
    final wide = MediaQuery.sizeOf(context).width >= 768;

    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _IconBox(Icons.security, cs.primary),
        const SizedBox(height: 24),
        Text('Multi-tenant Isolation', style: t.headlineMedium),
        const SizedBox(height: 12),
        Text(
          'Manage multiple venues under one umbrella with complete data '
          'separation and customizable permissions for each staff member.',
          style: t.bodyMedium?.copyWith(color: sem.textMuted),
        ),
        const SizedBox(height: 24),
        for (final s in const [
          'Independent Venue Branding',
          'Cross-venue Unified Reporting',
        ])
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 16, color: sem.success),
                const SizedBox(width: 8),
                Flexible(child: Text(s, style: t.bodySmall)),
              ],
            ),
          ),
      ],
    );

    Widget venue(IconData i, Color c, String n) => Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: sem.borderSubtle),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(i, color: c),
          const SizedBox(height: 4),
          Text(
            n,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );

    final visual = Container(
      constraints: const BoxConstraints(minHeight: 240),
      decoration: BoxDecoration(
        color: cs.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            venue(Icons.location_on, cs.primary, 'Venue A'),
            const SizedBox(width: 16),
            venue(Icons.apartment, cs.secondary, 'Venue B'),
          ],
        ),
      ),
    );

    return _CardShell(
      child: wide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: text),
                const SizedBox(width: 32),
                Expanded(child: visual),
              ],
            )
          : Column(children: [text, const SizedBox(height: 24), visual]),
    );
  }
}

class _CtaCard extends StatelessWidget {
  const _CtaCard();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;
    final wide = MediaQuery.sizeOf(context).width >= 768;

    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Ready to scale your venue empire?',
          style: t.headlineMedium?.copyWith(color: cs.onInverseSurface),
        ),
        const SizedBox(height: 12),
        Text(
          "Our infrastructure is built to support single venues or worldwide "
          "chains. Experience the speed of 'Kinetic Infrastructure'.",
          style: t.bodyMedium?.copyWith(
            color: cs.onInverseSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 32),
        FilledButton(
          style: FilledButton.styleFrom(
            minimumSize: const Size(0, 48),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            backgroundColor: cs.primaryContainer,
            foregroundColor: cs.onPrimaryContainer,
          ),
          onPressed: () => context.go('/login'),
          child: const Text('Start Free Trial'),
        ),
      ],
    );

    final visual = Container(
      // height: wide ? null : 192,
      // constraints: const BoxConstraints(minHeight: 192),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: [cs.primaryContainer, cs.secondaryContainer, cs.primary],
        // ),
      ),
      child: Center(
        child: Image.asset('ready_to_scale_your_venue.webp'),
        //Icon(Icons.hub, size: 72, color: Colors.white70),
      ),
    );

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: cs.inverseSurface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: wide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: text),
                const SizedBox(width: 32),
                Expanded(child: visual),
              ],
            )
          : Column(children: [text, const SizedBox(height: 24), visual]),
    );
  }
}

// ───────────────────────── FOOTER ─────────────────────────

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;
    final sem = context.semantic;
    final desktop = MediaQuery.sizeOf(context).width >= 768;

    Widget column(String title, List<String> items) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: t.labelMedium?.copyWith(
            color: sem.textMain,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 24),
        for (final i in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(i, style: t.bodySmall?.copyWith(color: sem.textMuted)),
          ),
      ],
    );

    final brand = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.dashboard_customize, color: cs.primary),
            const SizedBox(width: 8),
            Text(
              'Venue Manager',
              style: t.headlineMedium?.copyWith(
                color: cs.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'The operating system for modern venues and complex events spaces.',
          style: t.bodySmall?.copyWith(color: sem.textMuted),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            for (final i in const [
              Icons.public,
              Icons.terminal,
              Icons.mail_outline,
            ])
              Container(
                width: 32,
                height: 32,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: sem.borderSubtle),
                ),
                child: Icon(i, size: 16, color: sem.textMuted),
              ),
          ],
        ),
      ],
    );

    final cols = [
      column('Product', [
        'Form Builder',
        'Staffing Logic',
        'Invoicing Engine',
        'API Docs',
      ]),
      column('Solutions', [
        'Convention Centers',
        'Coworking Spaces',
        'Music Venues',
        'Sports Arenas',
      ]),
      column('Company', [
        'About Us',
        'Careers',
        'Privacy Policy',
        'Terms of Service',
      ]),
    ];

    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        border: Border(top: BorderSide(color: sem.borderSubtle)),
      ),
      child: _Section(
        padding: const EdgeInsets.only(top: 80, bottom: 40),
        child: Column(
          children: [
            if (desktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: brand),
                  const SizedBox(width: 48),
                  for (final c in cols) ...[
                    Expanded(child: c),
                    const SizedBox(width: 48),
                  ],
                ]..removeLast(),
              )
            else ...[
              brand,
              const SizedBox(height: 40),
              for (final c in cols) ...[c, const SizedBox(height: 24)],
            ],
            const SizedBox(height: 40),
            Divider(color: sem.borderSubtle),
            const SizedBox(height: 24),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 16,
              spacing: 24,
              children: [
                Text(
                  '© ${DateTime.now().year} Venue Manager Inc. All rights reserved.',
                  style: t.labelSmall,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: sem.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text('All systems operational', style: t.labelSmall),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
