import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/theme.dart';
import '../theme/theme_provider.dart';
import '../theme/components.dart';
import '../theme/spacing.dart';
import '../theme/elevation.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedBottomNavIndex = 2; // Events tab selected

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: _buildAppBar(context, colorScheme, editorial),
      body: _buildBody(context, colorScheme, editorial),
      bottomNavigationBar: _buildBottomNavigation(colorScheme),
      floatingActionButton: _buildFloatingActionButton(colorScheme),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context, 
    ColorScheme colorScheme, 
    EditorialThemeData editorial,
  ) {
    return AppBar(
      backgroundColor: editorial.glassSurface,
      elevation: 0,
      systemOverlayStyle: colorScheme.brightness == Brightness.dark 
          ? SystemUiOverlayStyle.light 
          : SystemUiOverlayStyle.dark,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(color: Colors.transparent),
        ),
      ),
      leading: Row(
        children: [
          const SizedBox(width: EditorialSpacing.spacing6),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.business_outlined,
              color: colorScheme.primary,
              size: 20,
            ),
          ),
        ],
      ),
      leadingWidth: 64,
      title: Text(
        'The Digital Curator',
        style: editorial.venueNameStyle,
      ),
      actions: [
        // Desktop Navigation
        if (MediaQuery.of(context).size.width >= 768) ...[
          _buildNavItem('Timeline', true, colorScheme, editorial),
          _buildNavItem('Vendors', false, colorScheme, editorial),
          _buildNavItem('Guests', false, colorScheme, editorial),
          const SizedBox(width: EditorialSpacing.spacing8),
        ],
        // Theme Toggle
        IconButton(
          icon: Icon(
            colorScheme.brightness == Brightness.dark 
                ? Icons.light_mode_outlined 
                : Icons.dark_mode_outlined,
            color: colorScheme.primary,
          ),
          onPressed: () {
            ref.read(themeModeProvider.notifier).toggleTheme();
          },
        ),
        IconButton(
          icon: Icon(
            Icons.notifications_outlined,
            color: colorScheme.primary,
          ),
          onPressed: () {},
        ),
        Container(
          width: 32,
          height: 32,
          margin: const EdgeInsets.only(
            right: EditorialSpacing.spacing6,
            left: EditorialSpacing.spacing2,
          ),
          decoration: BoxDecoration(
            color: colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(
    String label, 
    bool isSelected, 
    ColorScheme colorScheme, 
    EditorialThemeData editorial,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: EditorialSpacing.spacing8),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          foregroundColor: isSelected 
              ? colorScheme.primary 
              : colorScheme.onSurfaceVariant,
        ),
        child: Text(
          label.toUpperCase(),
          style: editorial.sectionHeaderStyle.copyWith(
            color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context, 
    ColorScheme colorScheme, 
    EditorialThemeData editorial,
  ) {
    return SingleChildScrollView(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        margin: const EdgeInsets.symmetric(horizontal: EditorialSpacing.spacing6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: EditorialSpacing.spacing12),
            _buildHeader(colorScheme, editorial),
            const SizedBox(height: EditorialSpacing.spacing16),
            _buildTimelineContent(colorScheme, editorial),
            const SizedBox(height: 100), // Space for bottom nav
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme colorScheme, EditorialThemeData editorial) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 768;
        return isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: _buildHeaderContent(colorScheme, editorial)),
                  const SizedBox(width: EditorialSpacing.spacing6),
                  _buildAddButton(colorScheme, editorial),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderContent(colorScheme, editorial),
                  const SizedBox(height: EditorialSpacing.spacing6),
                  _buildAddButton(colorScheme, editorial),
                ],
              );
      },
    );
  }

  Widget _buildHeaderContent(ColorScheme colorScheme, EditorialThemeData editorial) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EVENT COORDINATION',
          style: editorial.sectionHeaderStyle,
        ),
        const SizedBox(height: EditorialSpacing.spacing2),
        Text(
          'Timeline Builder',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: EditorialSpacing.spacing4),
        Text(
          'Curating the seamless flow of the Thompson-Chen Wedding at Grand Heritage Estate.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton(ColorScheme colorScheme, EditorialThemeData editorial) {
    return ElevatedButton.icon(
      onPressed: () {},
      style: Theme.of(context).elevatedButtonTheme.style,
      icon: const Icon(Icons.add, size: 20),
      label: Text('Add Activity'),
    );
  }

  Widget _buildTimelineContent(ColorScheme colorScheme, EditorialThemeData editorial) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1024;
        return isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.25,
                    child: _buildSidebar(colorScheme, editorial),
                  ),
                  const SizedBox(width: EditorialSpacing.spacing12),
                  Expanded(child: _buildTimeline(colorScheme, editorial)),
                ],
              )
            : Column(
                children: [
                  _buildSidebar(colorScheme, editorial),
                  const SizedBox(height: EditorialSpacing.spacing8),
                  _buildTimeline(colorScheme, editorial),
                ],
              );
      },
    );
  }

  Widget _buildSidebar(ColorScheme colorScheme, EditorialThemeData editorial) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(EditorialSpacing.spacing8),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: const Alignment(-1.0, -1.0),
              end: const Alignment(0.707, 0.707),
              colors: [
                colorScheme.primary.withOpacity(0.05),
                colorScheme.primaryContainer.withOpacity(0.2),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Event Details',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: EditorialSpacing.spacing4),
              _buildDetailItem('DATE', 'September 14, 2024', editorial),
              const SizedBox(height: EditorialSpacing.spacing4),
              _buildDetailItem('LOCATION', 'The Sunken Garden & Great Hall', editorial),
              const SizedBox(height: EditorialSpacing.spacing4),
              _buildDetailItem('MAIN COORDINATOR', '', editorial),
              const SizedBox(height: EditorialSpacing.spacing1),
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(width: EditorialSpacing.spacing2),
                  Text(
                    'Elena Vance',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: EditorialSpacing.spacing8),
        EditorialComponents.quoteContainer(
          quote: "The beauty of the day lies in the precision of the plan.",
          colorScheme: colorScheme,
        ),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value, EditorialThemeData editorial) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: editorial.metadataStyle,
        ),
        if (value.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ],
    );
  }

  Widget _buildTimeline(ColorScheme colorScheme, EditorialThemeData editorial) {
    final timelineItems = [
      _TimelineItem(
        time: '11:00',
        period: 'AM',
        title: 'Vendor Arrival & Setup',
        category: 'Logistics',
        status: VenueStatus.available,
        assignees: [
          _Assignee(Icons.room_service_outlined, 'Lush Florals Team'),
          _Assignee(Icons.badge_outlined, 'Marcus (Venue Lead)'),
        ],
      ),
      _TimelineItem(
        time: '04:30',
        period: 'PM',
        title: 'Ceremony Begins',
        description: 'Processional music by String Quartet. Guests to be seated 15 mins prior.',
        category: 'High Priority',
        status: VenueStatus.booked,
        isHighlighted: true,
        assignees: [
          _Assignee(Icons.music_note_outlined, 'Vivaldi Strings'),
          _Assignee(Icons.person_outline, 'Officiant Smith'),
        ],
      ),
      _TimelineItem(
        time: '05:30',
        period: 'PM',
        title: 'Cocktail Hour',
        category: 'F&B',
        status: VenueStatus.available,
        assignees: [
          _Assignee(Icons.local_bar_outlined, 'Estate Bar Team'),
          _Assignee(Icons.restaurant_outlined, 'Chef Julian'),
        ],
      ),
      _TimelineItem(
        time: '07:00',
        period: 'PM',
        title: 'Grand Entrance & Dinner',
        category: 'Event',
        status: VenueStatus.available,
        assignees: [
          _Assignee(Icons.mic_outlined, 'DJ Sonic (MC)'),
          _Assignee(Icons.groups_outlined, 'All Waitstaff'),
        ],
      ),
    ];

    return Column(
      children: [
        Stack(
          children: [
            // Vertical line
            Positioned(
              left: 32,
              top: 0,
              bottom: 40,
              child: Container(
                width: 1,
                color: colorScheme.outlineVariant.withOpacity(0.3),
              ),
            ),
            Column(
              children: timelineItems
                  .asMap()
                  .entries
                  .map((entry) => Padding(
                        padding: EdgeInsets.only(
                          bottom: entry.key < timelineItems.length - 1 
                              ? EditorialSpacing.timelineItemSpacing 
                              : 0,
                        ),
                        child: _buildTimelineItemWidget(entry.value, colorScheme, editorial),
                      ))
                  .toList(),
            ),
          ],
        ),
        const SizedBox(height: EditorialSpacing.spacing8),
        _buildInsertButton(colorScheme, editorial),
      ],
    );
  }

  Widget _buildTimelineItemWidget(
    _TimelineItem item, 
    ColorScheme colorScheme, 
    EditorialThemeData editorial,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Time
        SizedBox(
          width: 64,
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.time,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                Text(
                  item.period,
                  style: editorial.metadataStyle,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: EditorialSpacing.spacing8),
        // Content
        Expanded(
          child: Stack(
            children: [
              // Timeline dot
              Positioned(
                left: -37,
                top: 16,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: _getStatusColor(item.status, colorScheme),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorScheme.surface,
                      width: 2,
                    ),
                    boxShadow: EditorialElevation.cardShadow(
                      colorScheme.brightness == Brightness.dark,
                    ),
                  ),
                ),
              ),
              // Card
              EditorialComponents.editorialCard(
                colorScheme: colorScheme,
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.drag_indicator,
                          color: colorScheme.outlineVariant,
                          size: 20,
                        ),
                        const SizedBox(width: EditorialSpacing.spacing4),
                        Expanded(
                          child: Text(
                            item.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        EditorialComponents.statusChip(
                          label: item.category,
                          status: item.status,
                          colorScheme: colorScheme,
                        ),
                      ],
                    ),
                    if (item.description != null) ...[
                      const SizedBox(height: EditorialSpacing.spacing4),
                      Text(
                        item.description!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (item.assignees.isNotEmpty) ...[
                      const SizedBox(height: EditorialSpacing.spacing6),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: editorial.ghostBorder,
                              width: 1,
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.only(top: EditorialSpacing.spacing6),
                        child: Wrap(
                          spacing: EditorialSpacing.spacing6,
                          runSpacing: EditorialSpacing.spacing2,
                          children: item.assignees
                              .map((assignee) => Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        assignee.icon,
                                        size: 16,
                                        color: colorScheme.secondary,
                                      ),
                                      const SizedBox(width: EditorialSpacing.spacing1),
                                      Text(
                                        assignee.name,
                                        style: editorial.captionStyle,
                                      ),
                                    ],
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInsertButton(ColorScheme colorScheme, EditorialThemeData editorial) {
    return Padding(
      padding: const EdgeInsets.only(left: 96),
      child: Center(
        child: OutlinedButton.icon(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: colorScheme.secondary,
            side: BorderSide(
              color: colorScheme.outlineVariant.withOpacity(0.3),
              style: BorderStyle.solid,
              width: 2,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: EditorialSpacing.spacing12,
              vertical: EditorialSpacing.spacing4,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: const Icon(Icons.add_circle_outline, size: 24),
          label: Text(
            'Insert Activity',
            style: editorial.buttonTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(ColorScheme colorScheme) {
    if (MediaQuery.of(context).size.width >= 768) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.primary.withOpacity(0.1),
            width: 1,
          ),
        ),
        boxShadow: EditorialElevation.navigationShadow(
          colorScheme.brightness == Brightness.dark,
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedBottomNavIndex,
        onTap: (index) => setState(() => _selectedBottomNavIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        selectedLabelStyle: context.editorial.metadataStyle,
        unselectedLabelStyle: context.editorial.metadataStyle,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'DASHBOARD',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: 'CALENDAR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_seat_outlined),
            activeIcon: Icon(Icons.event_seat),
            label: 'EVENTS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined),
            activeIcon: Icon(Icons.group),
            label: 'CLIENTS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_outlined),
            activeIcon: Icon(Icons.checklist),
            label: 'TASKS',
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(ColorScheme colorScheme) {
    if (MediaQuery.of(context).size.width >= 768) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 80),
      child: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Color _getStatusColor(VenueStatus status, ColorScheme colorScheme) {
    switch (status) {
      case VenueStatus.available:
        return colorScheme.primary;
      case VenueStatus.hold:
        return colorScheme.tertiary;
      case VenueStatus.booked:
        return colorScheme.secondary;
    }
  }
}

class _TimelineItem {
  final String time;
  final String period;
  final String title;
  final String? description;
  final String category;
  final VenueStatus status;
  final bool isHighlighted;
  final List<_Assignee> assignees;

  _TimelineItem({
    required this.time,
    required this.period,
    required this.title,
    this.description,
    required this.category,
    required this.status,
    this.isHighlighted = false,
    required this.assignees,
  });
}

class _Assignee {
  final IconData icon;
  final String name;

  _Assignee(this.icon, this.name);
}