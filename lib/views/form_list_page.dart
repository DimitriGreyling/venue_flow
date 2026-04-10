// lib/views/dashboard_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:venue_flow_app/models/dynamic_form_model.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/providers/viewmodel_provider.dart';
import 'package:venue_flow_app/views/form_builder_page.dart';
import '../theme/theme.dart';
import '../theme/spacing.dart';
import '../theme/elevation.dart';

class FormListPage extends ConsumerStatefulWidget {
  const FormListPage({super.key});

  @override
  ConsumerState<FormListPage> createState() => _FormListPageState();
}

class _FormListPageState extends ConsumerState<FormListPage> {
  String _selectedNavItem = 'Dashboard';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Row(
        children: [
          // Side Navigation
          _buildSideNavigation(colorScheme, editorial),
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Top Navigation
                _buildTopNavigation(colorScheme, editorial),
                // Dashboard Content
                Expanded(
                  child: _buildDashboardContent(colorScheme, editorial),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideNavigation(
      ColorScheme colorScheme, EditorialThemeData editorial) {
    return Container(
      width: 256,
      height: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.04),
            blurRadius: 32,
            offset: const Offset(32, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Logo Section
          Container(
            padding: const EdgeInsets.all(EditorialSpacing.spacing6),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        colorScheme.primaryContainer,
                        colorScheme.primary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.hub_outlined,
                    color: colorScheme.onPrimary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: EditorialSpacing.spacing3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Venue Flow',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: colorScheme.onSurface,
                            ),
                      ),
                      Text(
                        'MANAGEMENT PORTAL',
                        style: editorial.metadataStyle.copyWith(
                          fontSize: 8,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // New Event Button
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: EditorialSpacing.spacing6,
              vertical: EditorialSpacing.spacing4,
            ),
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                elevation: 8,
                shadowColor: colorScheme.primary.withOpacity(0.2),
              ),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('New Event'),
            ),
          ),

          // Navigation Items
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: EditorialSpacing.spacing4),
              child: Column(
                children: [
                  _buildNavItem(
                      icon: Icons.dashboard_outlined,
                      label: 'Dashboard',
                      isSelected: _selectedNavItem == 'Dashboard',
                      colorScheme: colorScheme,
                      editorial: editorial,
                      navigateToLink: 'form-list'),
                  _buildNavItem(
                      icon: Icons.edit_note_outlined,
                      label: 'Form Builder',
                      isSelected: _selectedNavItem == 'Form Builder',
                      colorScheme: colorScheme,
                      editorial: editorial,
                      navigateToLink: 'form-list'),
                  _buildNavItem(
                      icon: Icons.calendar_today_outlined,
                      label: 'Events',
                      isSelected: _selectedNavItem == 'Events',
                      colorScheme: colorScheme,
                      editorial: editorial,
                      navigateToLink: 'form-list'),
                  _buildNavItem(
                      icon: Icons.settings_outlined,
                      label: 'Settings',
                      isSelected: _selectedNavItem == 'Settings',
                      colorScheme: colorScheme,
                      editorial: editorial,
                      navigateToLink: 'form-list'),
                ],
              ),
            ),
          ),

          // Bottom Section
          Container(
            padding: const EdgeInsets.all(EditorialSpacing.spacing6),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: colorScheme.outline.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                _buildNavItem(
                    icon: Icons.help_outline,
                    label: 'Help Center',
                    isSelected: false,
                    colorScheme: colorScheme,
                    editorial: editorial,
                    navigateToLink: 'form-list'),
                _buildNavItem(
                    icon: Icons.person_outline,
                    label: 'Account',
                    isSelected: false,
                    colorScheme: colorScheme,
                    editorial: editorial,
                    navigateToLink: 'form-list'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required ColorScheme colorScheme,
    required EditorialThemeData editorial,
    required String navigateToLink,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: isSelected
            ? colorScheme.surfaceContainerHighest
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            setState(() {
              _selectedNavItem = label;
              context.goNamed(navigateToLink);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: EditorialSpacing.spacing4,
              vertical: EditorialSpacing.spacing3,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: EditorialSpacing.spacing3),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopNavigation(
      ColorScheme colorScheme, EditorialThemeData editorial) {
    return Container(
      height: 64,
      padding:
          const EdgeInsets.symmetric(horizontal: EditorialSpacing.spacing8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Search Bar
          Container(
            width: 320,
            height: 40,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search events, forms, or clients...',
                hintStyle: editorial.captionStyle,
                prefixIcon: Icon(
                  Icons.search,
                  size: 18,
                  color: colorScheme.onSurfaceVariant,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: EditorialSpacing.spacing4,
                  vertical: EditorialSpacing.spacing2,
                ),
              ),
            ),
          ),

          const SizedBox(width: EditorialSpacing.spacing8),

          const Spacer(),

          // Right Section
          Row(
            children: [
              // Notifications
              Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: colorScheme.error,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.surface,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: EditorialSpacing.spacing4),

              // Divider
              Container(
                width: 1,
                height: 32,
                color: colorScheme.outline.withOpacity(0.2),
              ),

              const SizedBox(width: EditorialSpacing.spacing4),

              // Profile Section
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorScheme.primary.withOpacity(0.1),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 16,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: EditorialSpacing.spacing2),
                  Text(
                    'Alex Rivera',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(FormStatus formStatus) {
    switch (formStatus) {
      case FormStatus.draft:
        return Theme.of(context).colorScheme.primary;
      default:
        return Theme.of(context).colorScheme.inversePrimary;
    }
  }

  Widget _buildEventRow({
    required DynamicFormModel formModel,
    required ColorScheme colorScheme,
    required EditorialThemeData editorial,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(EditorialSpacing.spacing6),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.format_align_center,
                          size: 20,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: EditorialSpacing.spacing3),
                      Text(
                        formModel.name ?? '',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
                // Expanded(
                //   flex: 2,
                //   child: Text(
                //     '',
                //     // event['client'] as String,
                //     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                //           color: colorScheme.onSurfaceVariant,
                //         ),
                //   ),
                // ),
                Expanded(
                  child: Text(
                    formModel.createdAt != null
                        ? DateFormat('yyyy-MM-dd')
                            .format(formModel.modifiedDate!)
                        : '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: EditorialSpacing.spacing3,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: (_getStatusColor(
                              formModel.formStatus ?? FormStatus.draft))
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      formModel.formStatus?.name.toUpperCase() ?? '',
                      style: editorial.metadataStyle.copyWith(
                        color: _getStatusColor(
                            formModel.formStatus ?? FormStatus.draft),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert,
                      color: colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardContent(
      ColorScheme colorScheme, EditorialThemeData editorial) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(EditorialSpacing.spacing8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forms',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Welcome back, Alex. You have 4 meetings scheduled for today.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      context.goNamed('form-builder');
                    },
                    icon: const Icon(Icons.description_outlined, size: 18),
                    label: const Text('Create Form'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.onSecondaryContainer,
                      side: BorderSide(
                          color: colorScheme.outline.withOpacity(0.1)),
                    ),
                  ),
                ],
              ),
            ],
          ),

          _buildActiveEventsSection(colorScheme, editorial)
        ],
      ),
    );
  }

  Widget _buildMetricsGrid(
      ColorScheme colorScheme, EditorialThemeData editorial) {
    return Row(
      children: [
        // Portfolio Overview - Large Card
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(EditorialSpacing.spacing6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primaryContainer,
                  colorScheme.primary,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: EditorialElevation.cardShadow(
                colorScheme.brightness == Brightness.dark,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PORTFOLIO OVERVIEW',
                  style: editorial.metadataStyle.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.8),
                    fontSize: 10,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: EditorialSpacing.spacing4),
                Row(
                  children: [
                    Text(
                      '24',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    const SizedBox(width: EditorialSpacing.spacing2),
                    Text(
                      'Active Events',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: colorScheme.onPrimary.withOpacity(0.9),
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: EditorialSpacing.spacing6),
                Row(
                  children: [
                    // Client avatars (placeholder)
                    Row(
                      children: List.generate(
                        3,
                        (index) => Container(
                          margin: const EdgeInsets.only(right: 4),
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colorScheme.onPrimary,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.person,
                            size: 16,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: colorScheme.onPrimary.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '+12',
                          style: editorial.captionStyle.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: EditorialSpacing.spacing4),
                    Text(
                      'Managed by you this month',
                      style: editorial.captionStyle.copyWith(
                        color: colorScheme.onPrimary.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: EditorialSpacing.spacing6),

        // Smaller metric cards
        Expanded(
          child: Column(
            children: [
              _buildMetricCard(
                icon: Icons.fact_check_outlined,
                title: 'Pending Forms',
                value: '08',
                subtitle: 'Needs Review',
                badgeColor: colorScheme.tertiary,
                colorScheme: colorScheme,
                editorial: editorial,
              ),
              const SizedBox(height: EditorialSpacing.spacing4),
              _buildMetricCard(
                icon: Icons.groups_outlined,
                title: 'Meetings Today',
                value: '04',
                subtitle: 'Next: 2:30 PM - Tech Rehearsal',
                colorScheme: colorScheme,
                editorial: editorial,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    Color? badgeColor,
    required ColorScheme colorScheme,
    required EditorialThemeData editorial,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(EditorialSpacing.spacing6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.05),
        ),
        boxShadow: EditorialElevation.cardShadow(
          colorScheme.brightness == Brightness.dark,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: badgeColor?.withOpacity(0.1) ??
                  colorScheme.secondaryContainer.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: badgeColor ?? colorScheme.secondary,
              size: 20,
            ),
          ),
          const SizedBox(height: EditorialSpacing.spacing4),
          Text(
            title.toUpperCase(),
            style: editorial.metadataStyle.copyWith(fontSize: 10),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: colorScheme.onSurface,
                ),
          ),
          if (badgeColor != null) ...[
            const SizedBox(height: EditorialSpacing.spacing4),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: EditorialSpacing.spacing2,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: badgeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.priority_high,
                    size: 12,
                    color: badgeColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'NEEDS REVIEW',
                    style: editorial.metadataStyle.copyWith(
                      fontSize: 8,
                      color: badgeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            const SizedBox(height: EditorialSpacing.spacing2),
            Text(
              subtitle,
              style: editorial.captionStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActiveEventsSection(
      ColorScheme colorScheme, EditorialThemeData editorial) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       'Active Events',
        //       style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        //             fontWeight: FontWeight.w900,
        //           ),
        //     ),
        //     TextButton(
        //       onPressed: () {},
        //       child: Text(
        //         'View all schedules',
        //         style: Theme.of(context).textTheme.labelMedium?.copyWith(
        //               color: colorScheme.secondary,
        //               fontWeight: FontWeight.bold,
        //             ),
        //       ),
        //     ),
        //   ],
        // ),
        const SizedBox(height: EditorialSpacing.spacing6),
        FutureBuilder(
          future: ref.watch(formBuilderViewModelProvider.notifier).loadForms(),
          builder: (context, snapshot) {
            return Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: colorScheme.outline.withOpacity(0.05),
                ),
                boxShadow: EditorialElevation.cardShadow(
                  colorScheme.brightness == Brightness.dark,
                ),
              ),
              child: Column(
                children: [
                  // Table Header
                  Container(
                    padding: const EdgeInsets.all(EditorialSpacing.spacing6),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLow,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'FORM NAME',
                            style:
                                editorial.metadataStyle.copyWith(fontSize: 10),
                          ),
                        ),
                        // Expanded(
                        //   flex: 2,
                        //   child: Text(
                        //     'CLIENT',
                        //     style:
                        //         editorial.metadataStyle.copyWith(fontSize: 10),
                        //   ),
                        // ),
                        Expanded(
                          child: Text(
                            'LAST DATE',
                            style:
                                editorial.metadataStyle.copyWith(fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'STATUS',
                            style:
                                editorial.metadataStyle.copyWith(fontSize: 10),
                          ),
                        ),
                        const SizedBox(width: 40),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      children: [
                        if (snapshot.connectionState == ConnectionState.waiting)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        if (snapshot.connectionState != ConnectionState.waiting)
                          // Table Rows
                          ...List.generate(
                            snapshot.data?.length ?? 0,
                            (index) => _buildEventRow(
                              formModel: snapshot.data![index],
                              colorScheme: colorScheme,
                              editorial: editorial,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRecentActivitySection(
      ColorScheme colorScheme, EditorialThemeData editorial) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
        const SizedBox(height: EditorialSpacing.spacing6),
        ...List.generate(
          3,
          (index) => _buildActivityItem(index, colorScheme, editorial),
        ),
        const SizedBox(height: EditorialSpacing.spacing4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(EditorialSpacing.spacing4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.outline.withOpacity(0.3),
              style: BorderStyle.solid,
              width: 2,
            ),
          ),
          child: TextButton(
            onPressed: () {},
            child: Text(
              'VIEW ALL NOTIFICATIONS',
              style: editorial.metadataStyle.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(
      int index, ColorScheme colorScheme, EditorialThemeData editorial) {
    final activities = [
      {
        'icon': Icons.description_outlined,
        'title': 'New Form Submission',
        'description': 'Lumina Global submitted Catering Requirements',
        'time': '12 minutes ago',
        'iconColor': colorScheme.primary,
      },
      {
        'icon': Icons.update,
        'title': 'Event Status Changed',
        'description': 'Miller-Smith Wedding moved to Planning',
        'time': '2 hours ago',
        'iconColor': colorScheme.secondary,
      },
      {
        'icon': Icons.chat_outlined,
        'title': 'New Message',
        'description': 'Client "NexGen Corp" sent a message regarding AV setup',
        'time': 'Yesterday, 4:45 PM',
        'iconColor': colorScheme.tertiary,
      },
    ];

    final activity = activities[index];

    return Container(
      margin: const EdgeInsets.only(bottom: EditorialSpacing.spacing4),
      padding: const EdgeInsets.all(EditorialSpacing.spacing5),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.05),
        ),
        boxShadow: EditorialElevation.cardShadow(
          colorScheme.brightness == Brightness.dark,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: (activity['iconColor'] as Color).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              activity['icon'] as IconData,
              size: 20,
              color: activity['iconColor'] as Color,
            ),
          ),
          const SizedBox(width: EditorialSpacing.spacing4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['title'] as String,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  activity['description'] as String,
                  style: editorial.captionStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  activity['time'] as String,
                  style: editorial.metadataStyle.copyWith(
                    fontSize: 10,
                    color: colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsSection(
      ColorScheme colorScheme, EditorialThemeData editorial) {
    return Container(
      padding: const EdgeInsets.all(EditorialSpacing.spacing8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Venue Occupancy Analysis',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: EditorialSpacing.spacing2),
                Text(
                  'Your current venue booking rate is 15% higher than last quarter. Consider opening more weekend slots for Q4.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: EditorialSpacing.spacing12),
          Row(
            children: [
              _buildStatColumn('88%', 'OCCUPANCY', colorScheme, editorial),
              Container(
                width: 1,
                height: 48,
                margin: const EdgeInsets.symmetric(
                    horizontal: EditorialSpacing.spacing8),
                color: colorScheme.outline.withOpacity(0.2),
              ),
              _buildStatColumn('12k', 'ATTENDEES', colorScheme, editorial),
              Container(
                width: 1,
                height: 48,
                margin: const EdgeInsets.symmetric(
                    horizontal: EditorialSpacing.spacing8),
                color: colorScheme.outline.withOpacity(0.2),
              ),
              _buildStatColumn('4.9', 'RATING', colorScheme, editorial),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(
    String value,
    String label,
    ColorScheme colorScheme,
    EditorialThemeData editorial,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: colorScheme.primary,
              ),
        ),
        Text(
          label,
          style: editorial.metadataStyle.copyWith(fontSize: 10),
        ),
      ],
    );
  }
}
