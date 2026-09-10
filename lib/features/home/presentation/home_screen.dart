import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:venue_flow_app/app/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: AppColors.neutral200),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(17, 24, 39, 0.04),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 900;

                    if (isWide) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: _HeroPanel(theme: theme),
                          ),
                          const SizedBox(width: 32),
                          const Expanded(
                            flex: 4,
                            child: _ActionPanel(),
                          ),
                        ],
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _HeroPanel(theme: theme),
                        const SizedBox(height: 24),
                        const _ActionPanel(),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(36),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/venue_flow_mark_transparent.svg',
                    width: 28,
                    height: 28,
                    colorFilter: const ColorFilter.mode(
                      AppColors.onPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'VenueFlow',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            'Venue operations in one place.',
            style: theme.textTheme.displaySmall?.copyWith(
              color: AppColors.onPrimary,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Track bookings, customers, venues, and live operational health from a single workspace built for event teams.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.onPrimary.withValues(alpha: 0.9),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 32),
          const _MetricRow(),
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _MetricTile(label: 'Live venues', value: '24')),
        SizedBox(width: 16),
        Expanded(child: _MetricTile(label: 'Bookings today', value: '134')),
        SizedBox(width: 16),
        Expanded(child: _MetricTile(label: 'Occupancy', value: '86.4%')),
      ],
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: AppColors.onPrimary.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: AppColors.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionPanel extends StatelessWidget {
  const _ActionPanel();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Welcome to VenueFlow',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Start on the public home page, then sign in when you are ready to access the workspace.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: AppColors.onSurfaceVariant,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 28),
        FilledButton(
          onPressed: () => context.go('/sign-in'),
          child: const Text('Sign in'),
        ),
      ],
    );
  }
}
