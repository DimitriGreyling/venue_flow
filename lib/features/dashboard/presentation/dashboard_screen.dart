import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/side_nav.dart';
import '../../auth/presentation/auth_session.dart';
import 'dashboard_providers.dart';

// ───────────────────────── PALETTE (from the HTML design) ─────────────────────────

class _C {
  static const primary = Color(0xFF3525CD);
  static const secondary = Color(0xFF4442E3);
  static const background = Color(0xFFF8F9FA);
  static const border = Color(0xFFE5E7EB);
  static const textMain = Color(0xFF111827);
  static const textMuted = Color(0xFF6B7280);
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);
  static const info = Color(0xFF3B82F6);
  static const surfaceLow = Color(0xFFF3F4F5);
  static const surfaceHigh = Color(0xFFE7E8E9);
}

const _wideBreakpoint = 1000.0;

// ───────────────────────── SCREEN ─────────────────────────

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wide = MediaQuery.sizeOf(context).width >= _wideBreakpoint;

    return Scaffold(
      backgroundColor: _C.background,
      drawer: wide
          ? null
          : const Drawer(
        width: 240,
        backgroundColor: _C.background,
        child: SideNav(activePath: '/dashboard'),
      ),
      body: Row(
        children: [
          if (wide) const SideNav(activePath: '/dashboard'),
          Expanded(
            child: Column(
              children: [
                _TopBar(wide: wide),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(wide ? 24 : 16),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1440),
                        child: const _DashboardBody(),
                      ),
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

// ───────────────────────── TOP BAR ─────────────────────────

class _TopBar extends ConsumerWidget {
  const _TopBar({required this.wide});

  final bool wide;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: wide ? 24 : 8),
      decoration: const BoxDecoration(
        color: _C.background,
        border: Border(bottom: BorderSide(color: _C.border)),
        boxShadow: [
          BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 1)),
        ],
      ),
      child: Row(
        children: [
          if (!wide)
            Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(Icons.menu, color: _C.textMuted),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              ),
            ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 576),
                child: const _SearchField(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: _C.textMuted),
            onPressed: () {},
          ),
          if (wide)
            IconButton(
              icon: const Icon(Icons.help_outline, color: _C.textMuted),
              onPressed: () {},
            ),
          if (wide) ...[
            const SizedBox(width: 8),
            Container(width: 1, height: 32, color: _C.border),
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
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: _C.surfaceHigh,
                  child: Icon(Icons.person, size: 18, color: _C.textMuted),
                ),
                if (wide) ...[
                  const SizedBox(width: 12),
                  const Text(
                    'Venue Manager',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _C.primary,
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

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border(Color c, [double w = 1]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: c, width: w),
    );

    return TextField(
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        isDense: true,
        hintText: 'Search venues, events, bookings...',
        hintStyle: const TextStyle(color: _C.textMuted, fontSize: 14),
        prefixIcon: const Icon(Icons.search, color: _C.textMuted, size: 20),
        filled: true,
        fillColor: _C.surfaceLow,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: border(_C.border),
        enabledBorder: border(_C.border),
        focusedBorder: border(_C.primary),
      ),
    );
  }
}

// ───────────────────────── BODY ─────────────────────────

class _DashboardBody extends StatelessWidget {
  const _DashboardBody();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Header(),
        SizedBox(height: 32),
        _KpiGrid(),
        SizedBox(height: 32),
        _ChartsSection(),
        SizedBox(height: 32),
        _BottomSection(),
        // SizedBox(height: 32),
      ],
    );
  }
}

// ───────────────────────── HEADER ─────────────────────────

const _weekdays = [
  'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday',
];
const _monthNames = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December',
];

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final greeting = now.hour < 12
        ? 'Good morning'
        : now.hour < 18
        ? 'Good afternoon'
        : 'Good evening';
    final date =
        '${_weekdays[now.weekday - 1]}, ${_monthNames[now.month - 1]} ${now.day}, ${now.year}';
    final narrow = MediaQuery.sizeOf(context).width < 700;

    final titles = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$greeting, Admin', // TODO: real user name
          style: TextStyle(
            fontSize: narrow ? 24 : 32,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.6,
            color: _C.textMain,
          ),
        ),
        const SizedBox(height: 4),
        Text(date, style: const TextStyle(fontSize: 14, color: _C.textMuted)),
      ],
    );

    final actions = Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.download, size: 18),
          label: const Text('Export Report'),
          style: OutlinedButton.styleFrom(
            foregroundColor: _C.textMain,
            backgroundColor: Colors.white,
            side: const BorderSide(color: _C.border),
            minimumSize: const Size(0, 40),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Create New'),
          style: FilledButton.styleFrom(
            backgroundColor: _C.primary,
            minimumSize: const Size(0, 40),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );

    if (narrow) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [titles, const SizedBox(height: 16), actions],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [titles, actions],
    );
  }
}

// ───────────────────────── KPI CARDS ─────────────────────────

class _Kpi {
  const _Kpi({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
    required this.trend,
    required this.trendColor,
    this.trendIcon,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String value;
  final String trend;
  final Color trendColor;
  final IconData? trendIcon;
}

// TODO: replace with real data
const _kpis = [
  _Kpi(
    icon: Icons.location_on_outlined,
    color: _C.info,
    label: 'Total Venues',
    value: '12',
    trend: '+2',
    trendColor: _C.success,
    trendIcon: Icons.trending_up,
  ),
  _Kpi(
    icon: Icons.event_outlined,
    color: _C.primary,
    label: 'Active Events',
    value: '48',
    trend: '12%',
    trendColor: _C.success,
    trendIcon: Icons.trending_up,
  ),
  _Kpi(
    icon: Icons.confirmation_number_outlined,
    color: _C.warning,
    label: 'Upcoming Bookings',
    value: '156',
    trend: 'Steady',
    trendColor: _C.textMuted,
  ),
  _Kpi(
    icon: Icons.payments_outlined,
    color: _C.success,
    label: 'Monthly Revenue',
    value: '\$84,200',
    trend: '8.4%',
    trendColor: _C.success,
    trendIcon: Icons.trending_up,
  ),
  _Kpi(
    icon: Icons.assignment_late_outlined,
    color: _C.error,
    label: 'Pending Invoices',
    value: '8',
    trend: 'Overdue',
    trendColor: _C.error,
  ),
];

class _KpiGrid extends StatelessWidget {
  const _KpiGrid();

  @override
  Widget build(BuildContext context) {
    const gap = 24.0;

    return LayoutBuilder(
      builder: (context, c) {
        final cols = c.maxWidth >= 1100
            ? 5
            : c.maxWidth >= 700
            ? 3
            : c.maxWidth >= 480
            ? 2
            : 1;
        final w = (c.maxWidth - gap * (cols - 1)) / cols;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final k in _kpis) SizedBox(width: w, child: _KpiCard(k)),
          ],
        );
      },
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard(this.kpi);

  final _Kpi kpi;

  @override
  Widget build(BuildContext context) {
    return _Card(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kpi.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(kpi.icon, color: kpi.color, size: 22),
              ),
              Row(
                children: [
                  if (kpi.trendIcon != null) ...[
                    Icon(kpi.trendIcon, size: 14, color: kpi.trendColor),
                    const SizedBox(width: 2),
                  ],
                  Text(
                    kpi.trend,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: kpi.trendColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            kpi.label.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.8,
              color: _C.textMuted,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            kpi.value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.2,
              color: _C.textMain,
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── CHARTS ─────────────────────────

class _ChartsSection extends StatelessWidget {
  const _ChartsSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final wide = c.maxWidth >= _wideBreakpoint - 240;

        if (!wide) {
          return const Column(
            children: [
              _EventsChartCard(),
              SizedBox(height: 24),
              _RevenueCard(),
              SizedBox(height: 24),
              _UtilizationCard(),
            ],
          );
        }

        return const IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 8, child: _EventsChartCard()),
              SizedBox(width: 24),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: _RevenueCard()),
                    SizedBox(height: 24),
                    _UtilizationCard(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EventsChartCard extends ConsumerWidget {
  const _EventsChartCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(dashRangeProvider);
    final data = ref.watch(eventsSeriesProvider);
    final labels = ref.watch(eventsAxisLabelsProvider);

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Events over time', style: _cardTitle),
                    SizedBox(height: 2),
                    Text(
                      'Tracking activity across all venues',
                      style: TextStyle(fontSize: 13, color: _C.textMuted),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: _C.surfaceLow,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _C.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<DashRange>(
                    value: range,
                    isDense: true,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _C.textMain,
                    ),
                    items: [
                      for (final r in DashRange.values)
                        DropdownMenuItem(value: r, child: Text(r.label)),
                    ],
                    onChanged: (r) {
                      if (r != null) {
                        ref.read(dashRangeProvider.notifier).select(r);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 280,
            width: double.infinity,
            child: CustomPaint(
              painter: _LineChartPainter(data: data, color: _C.primary),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final l in labels)
                Text(
                  l,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _C.textMuted,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  _LineChartPainter({required this.data, required this.color});

  final List<double> data;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;

    // Grid lines
    final grid = Paint()
      ..color = _C.border.withValues(alpha: 0.6)
      ..strokeWidth = 1;
    for (var i = 0; i < 4; i++) {
      final y = size.height * i / 3;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final maxV = data.reduce((a, b) => a > b ? a : b) * 1.15;
    final pts = <Offset>[
      for (var i = 0; i < data.length; i++)
        Offset(
          size.width * i / (data.length - 1),
          size.height - (data[i] / maxV) * size.height,
        ),
    ];

    // Smooth curve
    final line = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (var i = 1; i < pts.length; i++) {
      final midX = (pts[i - 1].dx + pts[i].dx) / 2;
      line.cubicTo(midX, pts[i - 1].dy, midX, pts[i].dy, pts[i].dx, pts[i].dy);
    }

    // Gradient fill under the line
    final fill = Path.from(line)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
      fill,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withValues(alpha: 0.12), color.withValues(alpha: 0)],
        ).createShader(Offset.zero & size),
    );

    canvas.drawPath(
      line,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_LineChartPainter old) =>
      old.data != data || old.color != color;
}

class _RevenueCard extends StatelessWidget {
  const _RevenueCard();

  // TODO: replace with real data (value in $k)
  static const _months = ['Jun', 'Jul', 'Aug', 'Sep', 'Oct'];
  static const _values = [42.0, 58.0, 48.0, 79.0, 84.0];

  @override
  Widget build(BuildContext context) {
    final maxV = _values.reduce((a, b) => a > b ? a : b) / 0.85;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Revenue by month', style: _cardTitle),
          const SizedBox(height: 24),
          SizedBox(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var i = 0; i < _values.length; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  Expanded(
                    child: Tooltip(
                      message: '${_months[i]}: \$${_values[i].toInt()}k',
                      child: FractionallySizedBox(
                        heightFactor: _values[i] / maxV,
                        child: Container(
                          decoration: BoxDecoration(
                            color: i == _values.length - 1
                                ? _C.primary
                                : _C.primary.withValues(alpha: 0.2),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final m in _months)
                Text(
                  m.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _C.textMuted,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UtilizationCard extends StatelessWidget {
  const _UtilizationCard();

  static const _value = 0.72; // TODO: real data

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Venue utilization', style: _cardTitle),
                SizedBox(height: 2),
                Text(
                  'Capacity efficiency',
                  style: TextStyle(fontSize: 13, color: _C.textMuted),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const SizedBox.expand(
                  child: CircularProgressIndicator(
                    value: _value,
                    strokeWidth: 8,
                    strokeCap: StrokeCap.round,
                    backgroundColor: _C.surfaceHigh,
                    color: _C.secondary,
                  ),
                ),
                Text(
                  '${(_value * 100).round()}%',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: _C.textMain,
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

// ───────────────────────── ACTIVITY + QUICK ACTIONS ─────────────────────────

class _BottomSection extends StatelessWidget {
  const _BottomSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        if (c.maxWidth < 900) {
          print('Triggering bottom section column layout for width: ${c.maxWidth}');
          return const Column(
            children: [
              _ActivityCard(),
              SizedBox(height: 24),
              _QuickActionsCard(),
            ],
          );
        }
        return const IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _ActivityCard()),
              SizedBox(width: 24),
              Expanded(child: _QuickActionsCard()),
            ],
          ),
        );
      },
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Recent Activity Feed', style: _cardTitle),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _C.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const _ActivityTile(
            icon: Icons.add_task,
            color: _C.info,
            title: 'New Booking: Main Street Arena - Wedding',
            time: '2 mins ago',
            subtitle: Text('Client: Sarah Jennings | Oct 12, 2024'),
          ),
          _ActivityTile(
            icon: Icons.sync_alt,
            color: _C.primary,
            title: 'Event Status Updated: Tech Conference',
            time: '45 mins ago',
            subtitle: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: 'Status changed from '),
                  TextSpan(
                    text: 'Pending',
                    style: TextStyle(color: _C.warning),
                  ),
                  const TextSpan(text: ' to '),
                  TextSpan(
                    text: 'Confirmed',
                    style: TextStyle(
                      color: _C.success,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const _ActivityTile(
            icon: Icons.receipt_long_outlined,
            color: _C.warning,
            title: 'Invoice #INV-9283 Generated',
            time: '2 hours ago',
            subtitle: Text('Amount: \$12,450.00 | Sent to: Global Logistics Inc.'),
            last: true,
          ),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.time,
    required this.subtitle,
    this.last = false,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String time;
  final Widget subtitle;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(bottom: last ? 0 : 16),
              decoration: BoxDecoration(
                border: last
                    ? null
                    : const Border(bottom: BorderSide(color: _C.border)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _C.textMain,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: _C.textMuted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  DefaultTextStyle.merge(
                    style: const TextStyle(fontSize: 13, color: _C.textMuted),
                    child: subtitle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionsCard extends StatelessWidget {
  const _QuickActionsCard();

  static const _actions = [
    (Icons.edit_calendar_outlined, 'Create Event'),
    (Icons.person_add_alt_outlined, 'Add Customer'),
    (Icons.domain_add_outlined, 'Add Venue'),
    (Icons.request_quote_outlined, 'Generate Invoice'),
  ];

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Quick Actions', style: _cardTitle),
          const SizedBox(height: 24),
          // GridView.count(
          //   crossAxisCount: 2,
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   mainAxisSpacing: 16,
          //   crossAxisSpacing: 16,
          //   childAspectRatio: 1.5,
          //   children: [
          //     for (final a in _actions) _QuickAction(icon: a.$1, label: a.$2),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _C.surfaceLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: _C.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        hoverColor: _C.primary.withValues(alpha: 0.06),
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: _C.primary),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: _C.textMain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── SHARED ─────────────────────────

const _cardTitle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: _C.textMain,
);

class _Card extends StatelessWidget {
  const _Card({
    required this.child,
    this.padding = const EdgeInsets.all(24),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _C.border.withValues(alpha: 0.6)),
        boxShadow: const [
          BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 1)),
        ],
      ),
      child: child,
    );
  }
}