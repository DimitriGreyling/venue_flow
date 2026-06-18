import 'package:flutter/material.dart';
import 'package:venue_flow_app/theme/spacing.dart';
import 'package:venue_flow_app/theme/theme.dart';
import 'package:venue_flow_app/views/side_nav_widget.dart';
import 'package:venue_flow_app/views/top_bar_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
                          'Settings',
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: EditorialSpacing.spacing2),
                        Text(
                          'Manage application preferences and account defaults.',
                          style: context.editorial.metadataStyle,
                        ),
                        const SizedBox(height: EditorialSpacing.spacing8),
                        _buildToggleRow(
                          context,
                          title: 'Enable Dark Theme',
                          subtitle: 'Switch between light and dark mode',
                          value: false,
                        ),
                        const SizedBox(height: EditorialSpacing.spacing8),
                        _buildToggleRow(
                          context,
                          title: 'Email Notifications',
                          subtitle: 'Receive daily updates for new submissions',
                          value: true,
                        ),
                        const SizedBox(height: EditorialSpacing.spacing4),
                        _buildToggleRow(
                          context,
                          title: 'Weekly Summary Report',
                          subtitle: 'Send KPI summary every Monday',
                          value: false,
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

  Widget _buildToggleRow(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(EditorialSpacing.spacing5),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(subtitle, style: context.editorial.metadataStyle),
              ],
            ),
          ),
          Switch(value: value, onChanged: (_) {}),
        ],
      ),
    );
  }
}
