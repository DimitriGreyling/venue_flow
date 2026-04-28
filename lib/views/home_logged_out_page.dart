import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:venue_flow_app/theme/spacing.dart';
import 'package:venue_flow_app/theme/theme.dart';

class HomeLoggedOutPage extends StatelessWidget {
  const HomeLoggedOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.surface,
              colorScheme.surfaceContainerLow,
              colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop =
                  constraints.maxWidth >= EditorialSpacing.breakpointDesktop;
              final horizontalPadding =
                  constraints.maxWidth >= EditorialSpacing.breakpointTablet
                      ? EditorialSpacing.spacing12
                      : EditorialSpacing.spacing5;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    _TopNav(
                      onLogin: () => context.goNamed('signup'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: EditorialSpacing.spacing8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _HeroSection(
                            isDesktop: isDesktop,
                            onLogin: () => context.goNamed('signup'),
                          ),
                          const SizedBox(height: EditorialSpacing.spacing16),
                          const _TrustMetrics(),
                          const SizedBox(height: EditorialSpacing.spacing16),
                          const _FeatureGrid(),
                          const SizedBox(height: EditorialSpacing.spacing16),
                          const _ExperienceStrip(),
                          const SizedBox(height: EditorialSpacing.spacing16),
                          const _WorkflowSection(),
                          const SizedBox(height: EditorialSpacing.spacing16),
                          const _TestimonialSection(),
                          const SizedBox(height: EditorialSpacing.spacing16),
                          _BottomCta(
                            onLogin: () => context.goNamed('signup'),
                          ),
                          const SizedBox(height: EditorialSpacing.spacing12),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TopNav extends StatelessWidget {
  final VoidCallback onLogin;

  const _TopNav({
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial;
    final width = MediaQuery.of(context).size.width;
    final isCompact = width < 720;

    final brand = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 260),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: EditorialSpacing.spacing3,
          vertical: EditorialSpacing.spacing2,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLowest.withOpacity(0.88),
          borderRadius: BorderRadius.circular(EditorialSpacing.venueCardRadius),
          boxShadow: [
            BoxShadow(
              color: editorial.ambientShadowColor,
              blurRadius: 28,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/logo_white_transparent.png',
              height: 100,
              width: 100,
              errorBuilder: (_, __, ___) => Icon(
                Icons.event_available_outlined,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(width: EditorialSpacing.spacing3),
            Expanded(
              child: Text(
                'Venue Flow',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: editorial.venueNameStyle.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final actions = Wrap(
      spacing: EditorialSpacing.spacing3,
      runSpacing: EditorialSpacing.spacing3,
      children: [
        ElevatedButton(
          onPressed: onLogin,
          child: const Text('Sign In'),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: EditorialSpacing.spacing6,
        vertical: EditorialSpacing.spacing4,
      ),
      child: isCompact
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                brand,
                const SizedBox(height: EditorialSpacing.spacing4),
                actions,
              ],
            )
          : Row(
              children: [
                brand,
                const Spacer(),
                actions,
              ],
            ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final bool isDesktop;
  final VoidCallback onLogin;

  const _HeroSection({
    required this.isDesktop,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial;
    final isCompact = MediaQuery.of(context).size.width < 640;

    final heroText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: EditorialSpacing.spacing3,
            vertical: EditorialSpacing.spacing2,
          ),
          decoration: BoxDecoration(
            color: colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(EditorialSpacing.pillRadius),
          ),
          child: Text(
            'EDITORIAL VENUE OPERATIONS',
            style: editorial.metadataStyle.copyWith(
              color: colorScheme.onSecondaryContainer,
            ),
          ),
        ),
        const SizedBox(height: EditorialSpacing.spacing6),
        Text(
          'Run every venue moment with calm, clarity, and beautiful control.',
          style: (isCompact
                  ? Theme.of(context).textTheme.headlineLarge
                  : Theme.of(context).textTheme.displayMedium)
              ?.copyWith(
            fontWeight: FontWeight.w800,
            color: colorScheme.onSurface,
            height: 1.05,
          ),
        ),
        const SizedBox(height: EditorialSpacing.spacing5),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            'Venue Flow gives coordinators one place to shape forms, collect client input, track event movement, and turn high-pressure logistics into something that feels deliberate.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.6,
                ),
          ),
        ),
        const SizedBox(height: EditorialSpacing.spacing8),
        Wrap(
          spacing: EditorialSpacing.spacing3,
          runSpacing: EditorialSpacing.spacing3,
          children: [
            ElevatedButton.icon(
              onPressed: onLogin,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Start Managing'),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.auto_awesome),
              label: const Text('See The Flow'),
            ),
          ],
        ),
        const SizedBox(height: EditorialSpacing.spacing8),
        Wrap(
          spacing: EditorialSpacing.spacing6,
          runSpacing: EditorialSpacing.spacing4,
          children: const [
            _InlineMetric(value: '24', label: 'ACTIVE EVENT FLOWS'),
            _InlineMetric(value: '08', label: 'LIVE FORM CAMPAIGNS'),
            _InlineMetric(value: '4.9', label: 'CLIENT EXPERIENCE'),
          ],
        ),
      ],
    );

    final heroVisual = const _HeroVisual();

    if (!isDesktop) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heroText,
          const SizedBox(height: EditorialSpacing.spacing8),
          heroVisual,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 11, child: heroText),
        const SizedBox(width: EditorialSpacing.spacing10),
        const Expanded(flex: 9, child: _HeroVisual()),
      ],
    );
  }
}

class _HeroVisual extends StatelessWidget {
  const _HeroVisual();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial;

    return Container(
      constraints: const BoxConstraints(minHeight: 420),
      padding: const EdgeInsets.all(EditorialSpacing.spacing7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(EditorialSpacing.venueCardRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primaryContainer,
            colorScheme.primary,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: editorial.ambientShadowColor,
            blurRadius: 40,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 520;
          final cardWidth = compact
              ? constraints.maxWidth
              : (constraints.maxWidth - EditorialSpacing.spacing4) / 2;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: EditorialSpacing.spacing3,
                    vertical: EditorialSpacing.spacing2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.14),
                    borderRadius:
                        BorderRadius.circular(EditorialSpacing.pillRadius),
                  ),
                  child: Text(
                    'LIVE ORCHESTRATION',
                    style: editorial.metadataStyle.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: EditorialSpacing.spacing12),
              Text(
                'Today at a glance',
                style: editorial.labelBold.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: EditorialSpacing.spacing5),
              Wrap(
                spacing: EditorialSpacing.spacing4,
                runSpacing: EditorialSpacing.spacing4,
                children: [
                  SizedBox(
                    width: cardWidth,
                    child: const _GlassStat(
                      title: 'Meetings',
                      value: '04',
                      icon: Icons.groups_outlined,
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: const _GlassStat(
                      title: 'Forms Due',
                      value: '08',
                      icon: Icons.fact_check_outlined,
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: const _GlassStat(
                      title: 'Approvals',
                      value: '12',
                      icon: Icons.approval_outlined,
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: const _GlassStat(
                      title: 'Venues Ready',
                      value: '03',
                      icon: Icons.location_city_outlined,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _InlineMetric extends StatelessWidget {
  final String value;
  final String label;

  const _InlineMetric({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final editorial = context.editorial;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: colorScheme.primary,
              ),
        ),
        Text(
          label,
          style: editorial.metadataStyle,
        ),
      ],
    );
  }
}

class _GlassStat extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _GlassStat({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial;

    return Container(
      padding: const EdgeInsets.all(EditorialSpacing.spacing4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(EditorialSpacing.cardRadius),
      ),
      child: Row(
        children: [
          Icon(icon, color: colorScheme.onPrimary),
          const SizedBox(width: EditorialSpacing.spacing3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                Text(
                  title.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: editorial.metadataStyle.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.82),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TrustMetrics extends StatelessWidget {
  const _TrustMetrics();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(EditorialSpacing.spacing8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(EditorialSpacing.venueCardRadius),
        boxShadow: [
          BoxShadow(
            color: editorial.ambientShadowColor,
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: EditorialSpacing.spacing6,
        spacing: EditorialSpacing.spacing8,
        children: const [
          _LargeMetric(value: '250+', label: 'EVENTS ORCHESTRATED'),
          _LargeMetric(value: '98%', label: 'FORM COMPLETION RATE'),
          _LargeMetric(value: '< 3 min', label: 'AVERAGE CLIENT RESPONSE'),
          _LargeMetric(value: '1', label: 'UNIFIED VENUE WORKSPACE'),
        ],
      ),
    );
  }
}

class _LargeMetric extends StatelessWidget {
  final String value;
  final String label;

  const _LargeMetric({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final editorial = context.editorial;
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: EditorialSpacing.spacing2),
          Text(label, style: editorial.metadataStyle),
        ],
      ),
    );
  }
}

class _FeatureGrid extends StatelessWidget {
  const _FeatureGrid();

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        icon: Icons.dynamic_form_outlined,
        title: 'Elegant Form Building',
        text:
            'Design coordinator-grade forms with structure that feels intentional, not bureaucratic.'
      ),
      (
        icon: Icons.schedule_outlined,
        title: 'Operational Visibility',
        text:
            'Track meetings, approvals, deadlines, and venue readiness in one calm command surface.'
      ),
      (
        icon: Icons.forum_outlined,
        title: 'Client Clarity',
        text:
            'Collect requirements and expectations with less back-and-forth and better context.'
      ),
      (
        icon: Icons.verified_outlined,
        title: 'Decision Confidence',
        text:
            'Turn scattered requests into reliable event records your team can act on immediately.'
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeading(
          eyebrow: 'WHY VENUE FLOW',
          title: 'Built for venues where details matter as much as atmosphere.',
        ),
        const SizedBox(height: EditorialSpacing.spacing8),
        Wrap(
          spacing: EditorialSpacing.spacing6,
          runSpacing: EditorialSpacing.spacing6,
          children: items
              .map(
                (item) => SizedBox(
                  width: 320,
                  child: _FeatureCard(
                    icon: item.icon,
                    title: item.title,
                    text: item.text,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial;

    return Container(
      padding: const EdgeInsets.all(EditorialSpacing.spacing6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(EditorialSpacing.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: colorScheme.primary),
          ),
          const SizedBox(height: EditorialSpacing.spacing5),
          Text(title, style: editorial.cardTitleStyle),
          const SizedBox(height: EditorialSpacing.spacing3),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.6,
                ),
          ),
        ],
      ),
    );
  }
}

class _ExperienceStrip extends StatelessWidget {
  const _ExperienceStrip();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(EditorialSpacing.spacing8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(EditorialSpacing.venueCardRadius),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: EditorialSpacing.spacing6,
        spacing: EditorialSpacing.spacing8,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A front-of-house experience for back-of-house complexity.',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: colorScheme.onSurface,
                      ),
                ),
                const SizedBox(height: EditorialSpacing.spacing4),
                Text(
                  'Your coordinators should feel composed while the system handles the invisible choreography beneath them.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.6,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 320,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _StripItem(
                  icon: Icons.layers_outlined,
                  label: 'Layered surfaces instead of noisy chrome',
                ),
                SizedBox(height: EditorialSpacing.spacing4),
                _StripItem(
                  icon: Icons.visibility_outlined,
                  label: 'Clear status and momentum at a glance',
                ),
                SizedBox(height: EditorialSpacing.spacing4),
                _StripItem(
                  icon: Icons.spa_outlined,
                  label: 'Calm operational rhythm for busy venue teams',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StripItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StripItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, color: colorScheme.primary),
        const SizedBox(width: EditorialSpacing.spacing3),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

class _WorkflowSection extends StatelessWidget {
  const _WorkflowSection();

  @override
  Widget build(BuildContext context) {
    final steps = [
      (
        number: '01',
        title: 'Shape the intake',
        text:
            'Create polished forms for venue requirements, approvals, and client preferences.'
      ),
      (
        number: '02',
        title: 'Collect with confidence',
        text:
            'Gather accurate responses through a guided client-facing experience.'
      ),
      (
        number: '03',
        title: 'Move the event forward',
        text:
            'Turn submissions into operational clarity for meetings, planning, and execution.'
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeading(
          eyebrow: 'THE FLOW',
          title: 'A simple rhythm from inquiry to execution.',
        ),
        const SizedBox(height: EditorialSpacing.spacing8),
        Wrap(
          spacing: EditorialSpacing.spacing6,
          runSpacing: EditorialSpacing.spacing6,
          children: steps
              .map(
                (step) => SizedBox(
                  width: 340,
                  child: _WorkflowCard(
                    number: step.number,
                    title: step.title,
                    text: step.text,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _WorkflowCard extends StatelessWidget {
  final String number;
  final String title;
  final String text;

  const _WorkflowCard({
    required this.number,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial;

    return Container(
      padding: const EdgeInsets.all(EditorialSpacing.spacing6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(EditorialSpacing.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: EditorialSpacing.spacing3),
          Text(title, style: editorial.cardTitleStyle),
          const SizedBox(height: EditorialSpacing.spacing3),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.6,
                ),
          ),
        ],
      ),
    );
  }
}

class _TestimonialSection extends StatelessWidget {
  const _TestimonialSection();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(EditorialSpacing.spacing8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(EditorialSpacing.venueCardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FROM THE FLOOR', style: editorial.metadataStyle),
          const SizedBox(height: EditorialSpacing.spacing4),
          Text(
            '“Venue Flow made our intake feel luxurious instead of administrative. Clients answer faster, and our team spends less time stitching together context.”',
            style: editorial.quoteStyle.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: EditorialSpacing.spacing5),
          Text(
            'Operations Lead, Editorial Events Group',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}

class _BottomCta extends StatelessWidget {
  final VoidCallback onLogin;

  const _BottomCta({
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(EditorialSpacing.spacing8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primaryContainer,
            colorScheme.primary,
          ],
        ),
        borderRadius: BorderRadius.circular(EditorialSpacing.venueCardRadius),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: EditorialSpacing.spacing6,
        spacing: EditorialSpacing.spacing8,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bring structure to the moments clients remember.',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: EditorialSpacing.spacing4),
                Text(
                  'Open your workspace and start building a more composed venue operation.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onPrimary.withOpacity(0.88),
                      ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: onLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.onPrimary,
                foregroundColor: colorScheme.primary,
              ),
              child: const Text('Sign In To Continue'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  final String eyebrow;
  final String title;

  const _SectionHeading({
    required this.eyebrow,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final editorial = context.editorial;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow,
          style: editorial.metadataStyle.copyWith(
            color: colorScheme.secondary,
          ),
        ),
        const SizedBox(height: EditorialSpacing.spacing3),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
      ],
    );
  }
}
