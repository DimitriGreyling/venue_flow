import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/app/theme/app_colors.dart';
import 'package:venue_flow_app/core/error/failure.dart';
import 'package:venue_flow_app/core/widgets/failure_view.dart';
import 'package:venue_flow_app/features/dashboard/application/dashboard_controller.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modern Venue Intelligence'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary,
              child: Text(
                'DG',
                style: TextStyle(
                  color: AppColors.onPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      body: dashboardState.when(
        data: (summary) {
          final stats = [
            _StatCard(
              label: 'Occupancy',
              value: '${summary.occupancyRate.toStringAsFixed(1)}%',
              delta: '+12.4%',
              tone: AppColors.success,
            ),
            _StatCard(
              label: 'Revenue',
              value: '\$${summary.revenue.toStringAsFixed(0)}',
              delta: '+8.1%',
              tone: AppColors.primary,
            ),
            _StatCard(
              label: 'Bookings',
              value: summary.activeBookings.toString(),
              delta: '+24',
              tone: AppColors.secondary,
            ),
            _StatCard(
              label: 'Alerts',
              value: summary.pendingAlerts.toString(),
              delta: '-3',
              tone: AppColors.danger,
            ),
          ];

          return RefreshIndicator(
            onRefresh: () => ref.read(dashboardControllerProvider.notifier).refresh(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Operations overview',
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                letterSpacing: 0.06,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              summary.venueName,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainer,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: AppColors.neutral200),
                        ),
                        child: Text(
                          'Updated ${summary.lastUpdated}',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    children: stats,
                  ),
                  const SizedBox(height: 24),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: _Panel(
                          title: 'Schedule health',
                          child: Column(
                            children: [
                              _TimelineRow(label: 'Check-in', value: '96%'),
                              _TimelineRow(label: 'Catering', value: '87%'),
                              _TimelineRow(label: 'AV Setup', value: '91%'),
                              _TimelineRow(label: 'Security', value: '98%'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: _Panel(
                          title: 'Live activity',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _ActivityRow(text: '12 rooms in active use'),
                              _ActivityRow(text: '4 payments pending review'),
                              _ActivityRow(text: '3 vendor confirmations due'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          final failure = error is Failure
              ? error
              : Failure(error.toString());
          return FailureView(
            failure: failure,
            onRetry: () => ref.read(dashboardControllerProvider.notifier).refresh(),
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.delta,
    required this.tone,
  });

  final String label;
  final String value;
  final String delta;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.neutral500,
                letterSpacing: 0.05,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                delta,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: tone,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 64,
            child: LinearProgressIndicator(
              value: 0.9,
              backgroundColor: AppColors.neutral200,
              color: AppColors.primary,
              minHeight: 8,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
