import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../../app/shell/sidebar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1100;

        if (!isDesktop) {
          return const _MobileDashboard();
        }

        return Row(
          children: const [
            // _SideNav(),
            Expanded(
              child: Column(
                children: [_TopBar(), Expanded(child: _DashboardScroll())],
              ),
            ),
          ],
        );
      },
    );
  }
}

/// -------------------- MOBILE --------------------
class _MobileDashboard extends StatelessWidget {
  const _MobileDashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF111827)),
        title: const Text(
          'Main Street Arena',
          style: TextStyle(
            color: Color(0xFF3525CD),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      drawer: const Drawer(child: SideNav(isDrawer: true)),
      body: const _DashboardScroll(mobilePadding: true),
    );
  }
}

/// -------------------- SHELL --------------------
class _DashboardScroll extends StatelessWidget {
  final bool mobilePadding;

  const _DashboardScroll({this.mobilePadding = false});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(mobilePadding ? 16 : 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1440),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeaderRow(),
              SizedBox(height: 24),
              _KpiRow(),
              SizedBox(height: 24),
              _MiddleCharts(),
              SizedBox(height: 24),
              _BottomSection(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}



/// -------------------- TOPBAR --------------------
class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FA),
        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search venues, events, bookings...',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 20,
                    color: Color(0xFF6B7280),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF3F4F5),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
          const Icon(Icons.notifications_none, color: Color(0xFF6B7280)),
          const SizedBox(width: 14),
          const Icon(Icons.help_outline, color: Color(0xFF6B7280)),
          const SizedBox(width: 18),
          Container(width: 1, height: 24, color: const Color(0xFFE5E7EB)),
          const SizedBox(width: 14),
          const CircleAvatar(radius: 16, backgroundColor: Color(0xFFCBD5E1)),
          const SizedBox(width: 10),
          const Text(
            'Venue Manager',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF3525CD),
            ),
          ),
        ],
      ),
    );
  }
}

/// -------------------- HEADER --------------------
class _HeaderRow extends StatelessWidget {
  const _HeaderRow();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final isNarrow = c.maxWidth < 900;

        final left = const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning, Admin',
              style: TextStyle(
                fontSize: 32,
                height: 1.2,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111827),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Tuesday, October 24, 2023',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            ),
          ],
        );

        final right = Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.start,
          children: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download, size: 18),
              label: const Text('Export Report'),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3525CD),
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Create New'),
            ),
          ],
        );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              left,
              const SizedBox(height: 16),
              SizedBox(
                width: c.maxWidth,
                child: right, // bounded width
              ),
            ],
          );
        }

        // Desktop: bound each side explicitly
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: left),
            const SizedBox(width: 16),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: math.min(420, c.maxWidth * 0.42),
              ),
              child: right,
            ),
          ],
        );
      },
    );
  }
}

/// -------------------- KPI --------------------
class _KpiRow extends StatelessWidget {
  const _KpiRow();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final cards = const [
          _KpiCard(
            'Total Venues',
            '12',
            Icons.location_on_outlined,
            Color(0xFF3B82F6),
          ),
          _KpiCard(
            'Active Events',
            '48',
            Icons.event_outlined,
            Color(0xFF3525CD),
          ),
          _KpiCard(
            'Upcoming Bookings',
            '156',
            Icons.confirmation_number_outlined,
            Color(0xFFF59E0B),
          ),
          _KpiCard(
            'Monthly Revenue',
            '\$84,200',
            Icons.payments_outlined,
            Color(0xFF10B981),
          ),
          _KpiCard(
            'Pending Invoices',
            '8',
            Icons.assignment_late_outlined,
            Color(0xFFEF4444),
          ),
        ];

        final isWide = c.maxWidth >= 1300;
        if (isWide) {
          return const Row(
            children: [
              Expanded(
                child: _KpiCard(
                  'Total Venues',
                  '12',
                  Icons.location_on_outlined,
                  Color(0xFF3B82F6),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _KpiCard(
                  'Active Events',
                  '48',
                  Icons.event_outlined,
                  Color(0xFF3525CD),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _KpiCard(
                  'Upcoming Bookings',
                  '156',
                  Icons.confirmation_number_outlined,
                  Color(0xFFF59E0B),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _KpiCard(
                  'Monthly Revenue',
                  '\$84,200',
                  Icons.payments_outlined,
                  Color(0xFF10B981),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _KpiCard(
                  'Pending Invoices',
                  '8',
                  Icons.assignment_late_outlined,
                  Color(0xFFEF4444),
                ),
              ),
            ],
          );
        }

        final tileWidth = math.min(320.0, c.maxWidth);
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              cards.map((e) => SizedBox(width: tileWidth, child: e)).toList(),
        );
      },
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color accent;

  const _KpiCard(this.title, this.value, this.icon, this.accent);

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accent.withOpacity(.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: accent, size: 20),
          ),
          const SizedBox(height: 16),
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }
}

/// -------------------- CHARTS --------------------
class _MiddleCharts extends StatelessWidget {
  const _MiddleCharts();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        if (c.maxWidth < 1100) {
          return const Column(
            children: [
              _EventsOverTimeCard(),
              SizedBox(height: 12),
              _RevenueByMonthCard(),
              SizedBox(height: 12),
              _UtilizationCard(),
            ],
          );
        }

        return const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 8, child: _EventsOverTimeCard()),
            SizedBox(width: 12),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  _RevenueByMonthCard(),
                  SizedBox(height: 12),
                  _UtilizationCard(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EventsOverTimeCard extends StatelessWidget {
  const _EventsOverTimeCard();

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Events over time',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          const Text(
            'Tracking activity across all venues last 30 days',
            style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
          ),
          const SizedBox(height: 18),
          Container(
            height: 280,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: const Center(child: Text('Chart placeholder')),
          ),
        ],
      ),
    );
  }
}

class _RevenueByMonthCard extends StatelessWidget {
  const _RevenueByMonthCard();

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Revenue by month',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 130,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                _MiniBar(45),
                _MiniBar(62),
                _MiniBar(52),
                _MiniBar(90),
                _MiniBar(102, active: true),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Jun'),
              Text('Jul'),
              Text('Aug'),
              Text('Sep'),
              Text('Oct'),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniBar extends StatelessWidget {
  final double h;
  final bool active;

  const _MiniBar(this.h, {this.active = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: h,
        decoration: BoxDecoration(
          color: active ? const Color(0xFF3525CD) : const Color(0x333525CD),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ),
    );
  }
}

class _UtilizationCard extends StatelessWidget {
  const _UtilizationCard();

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Venue utilization',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2),
                Text(
                  'Capacity efficiency',
                  style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 84,
            height: 84,
            child: Stack(
              fit: StackFit.expand,
              children: const [
                CircularProgressIndicator(
                  value: 0.72,
                  strokeWidth: 8,
                  backgroundColor: Color(0xFFE7E8E9),
                  valueColor: AlwaysStoppedAnimation(Color(0xFF4442E3)),
                ),
                Center(
                  child: Text(
                    '72%',
                    style: TextStyle(fontWeight: FontWeight.w700),
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

/// -------------------- BOTTOM --------------------
class _BottomSection extends StatelessWidget {
  const _BottomSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        if (c.maxWidth < 1000) {
          return const Column(
            children: [
              _ActivityCard(),
              SizedBox(height: 12),
              _QuickActionsCard(),
            ],
          );
        }

        return const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _ActivityCard()),
            SizedBox(width: 12),
            Expanded(child: _QuickActionsCard()),
          ],
        );
      },
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard();

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Recent Activity Feed',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 16),
          _ActivityItem(
            'New Booking: Main Street Arena - Wedding',
            '2 mins ago',
            'Client: Sarah Jennings | Oct 12, 2024',
          ),
          _ActivityItem(
            'Event Status Updated: Tech Conference',
            '45 mins ago',
            'Status changed from Pending to Confirmed',
          ),
          _ActivityItem(
            'Invoice #INV-9283 Generated',
            '2 hours ago',
            'Amount: \$12,450.00 | Sent to: Global Logistics Inc.',
            hasDivider: false,
          ),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final String title, time, subtitle;
  final bool hasDivider;

  const _ActivityItem(
    this.title,
    this.time,
    this.subtitle, {
    this.hasDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 14),
      margin: const EdgeInsets.only(bottom: 14),
      decoration:
          hasDivider
              ? const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
              )
              : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0x143B82F6),
            child: Icon(Icons.bolt, size: 18, color: Color(0xFF3B82F6)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
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

class _QuickActionsCard extends StatelessWidget {
  const _QuickActionsCard();

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.5,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          _ActionBtn(Icons.calendar_month, 'Create Event'),
          _ActionBtn(Icons.person_add_alt_1, 'Add Customer'),
          _ActionBtn(Icons.domain_add, 'Add Venue'),
          _ActionBtn(Icons.request_quote, 'Generate Invoice'),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionBtn(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F5),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: const Color(0xFF3525CD)),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// -------------------- CARD --------------------
class _GlassCard extends StatelessWidget {
  final Widget child;

  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.85),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x80E5E7EB)),
      ),
      child: child,
    );
  }
}
