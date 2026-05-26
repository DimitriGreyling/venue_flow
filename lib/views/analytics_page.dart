import 'package:flutter/material.dart';
import 'package:venue_flow_app/theme/spacing.dart';
import 'package:venue_flow_app/theme/theme.dart';
import 'package:venue_flow_app/views/side_nav_widget.dart';
import 'package:venue_flow_app/views/top_bar_widget.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Row(
        children: [
          const SideNavWidget(),
          Expanded(
            child: Column(
              children: [
                const TopBarWidget(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(EditorialSpacing.spacing8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Analytics',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: EditorialSpacing.spacing2),
                        Text(
                          'Performance insights for bookings and form completion.',
                          style: context.editorial.metadataStyle,
                        ),
                        const SizedBox(height: EditorialSpacing.spacing8),
                        const Wrap(
                          spacing: EditorialSpacing.spacing4,
                          runSpacing: EditorialSpacing.spacing4,
                          children: [
                            _KpiTile(label: 'Completion Rate', value: '84%'),
                            _KpiTile(label: 'Avg Response Time', value: '9h'),
                            _KpiTile(label: 'Total Submissions', value: '1,248'),
                            _KpiTile(label: 'Drop-off', value: '7%'),
                          ],
                        ),
                      ],
                    ),
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

class _KpiTile extends StatelessWidget {
  final String label;
  final String value;

  const _KpiTile({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 220, maxWidth: 280),
      child: Container(
        padding: const EdgeInsets.all(EditorialSpacing.spacing5),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border:
              Border.all(color: colorScheme.outline.withValues(alpha: 0.08)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: EditorialSpacing.spacing2),
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
