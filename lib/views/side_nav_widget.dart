// lib/views/side_nav_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/models/user_model.dart';
import 'package:venue_flow_app/providers/auth_provider.dart';
import 'package:venue_flow_app/providers/navigation_provider.dart';
import 'package:venue_flow_app/providers/viewmodel_provider.dart';
import 'package:venue_flow_app/theme/editorial_theme_data.dart';
import 'package:venue_flow_app/theme/spacing.dart';
import 'package:venue_flow_app/viewmodels/navigation_viewmodel.dart';

class SideNavWidget extends ConsumerStatefulWidget {
  const SideNavWidget({super.key});

  @override
  ConsumerState<SideNavWidget> createState() => _SideNavWidgetState();
}

class _SideNavWidgetState extends ConsumerState<SideNavWidget> {
  @override
  void initState() {
    super.initState();
    
    // Update navigation state based on current route when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentRoute = GoRouterState.of(context).uri.path;
      ref.read(navigationStateProvider.notifier).updateFromRoute(currentRoute);
      ref.read(currentRouteProvider.notifier).state = currentRoute;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial;
    final navigationState = ref.watch(navigationStateProvider);
    final currentUser = ref.watch(currentUserProvider);

    // Listen to route changes to update navigation state
    ref.listen(currentRouteProvider, (previous, next) {
      ref.read(navigationStateProvider.notifier).updateFromRoute(next);
    });

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
          // Logo Section (same as before)
          _buildLogoSection(colorScheme, editorial, context),

          // Navigation Items
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: EditorialSpacing.spacing4),
              child: FutureBuilder(
                future: _loadNavigationData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Column(
                    children: [
                      // Static navigation items
                      ..._buildStaticNavItems(
                        navigationState.selectedItem,
                        colorScheme,
                        editorial,
                        currentUser,
                      ),
                      
                      // Dynamic form navigation items
                      if (snapshot.data != null)
                        ..._buildDynamicNavItems(
                          snapshot.data!,
                          navigationState.selectedItem,
                          colorScheme,
                          editorial,
                          currentUser,
                        ),
                    ],
                  );
                },
              ),
            ),
          ),

          // Bottom Section (same as before)
          _buildBottomSection(navigationState.selectedItem, colorScheme, editorial),
        ],
      ),
    );
  }

  // Build static navigation items based on user role
  List<Widget> _buildStaticNavItems(
    String selectedItem,
    ColorScheme colorScheme,
    EditorialThemeData editorial,
    UserModel? currentUser,
  ) {
    final items = <Widget>[];

    // Dashboard - available to all
    items.add(_buildNavItem(
      icon: Icons.dashboard_outlined,
      label: 'Dashboard',
      isSelected: selectedItem == 'Dashboard',
      colorScheme: colorScheme,
      editorial: editorial,
      onTap: () => _navigateToItem('Dashboard', '/dashboard'),
    ));

    // Role-specific items
    if (currentUser?.isCoordinator == true) {
      items.addAll([
        _buildNavItem(
          icon: Icons.edit_note_outlined,
          label: 'Form Builder',
          isSelected: selectedItem == 'Form Builder',
          colorScheme: colorScheme,
          editorial: editorial,
          onTap: () => _navigateToItem('Form Builder', '/form-list'),
        ),
        _buildNavItem(
          icon: Icons.calendar_today_outlined,
          label: 'Events',
          isSelected: selectedItem == 'Events',
          colorScheme: colorScheme,
          editorial: editorial,
          onTap: () => _navigateToItem('Events', '/events'),
        ),
        _buildNavItem(
          icon: Icons.analytics_outlined,
          label: 'Analytics',
          isSelected: selectedItem == 'Analytics',
          colorScheme: colorScheme,
          editorial: editorial,
          onTap: () => _navigateToItem('Analytics', '/analytics'),
        ),
      ]);
    }

    if (currentUser?.isClient == true) {
      items.add(_buildNavItem(
        icon: Icons.assignment_outlined,
        label: 'My Forms',
        isSelected: selectedItem == 'My Forms',
        colorScheme: colorScheme,
        editorial: editorial,
        onTap: () => _navigateToItem('My Forms', '/client/forms'),
      ));
    }

    items.add(_buildNavItem(
      icon: Icons.settings_outlined,
      label: 'Settings',
      isSelected: selectedItem == 'Settings',
      colorScheme: colorScheme,
      editorial: editorial,
      onTap: () => _navigateToItem('Settings', '/settings'),
    ));

    return items;
  }

  // Build dynamic navigation items for forms
  List<Widget> _buildDynamicNavItems(
    List<dynamic> formData,
    String selectedItem,
    ColorScheme colorScheme,
    EditorialThemeData editorial,
    UserModel? currentUser,
  ) {
    if (currentUser?.isClient != true || formData.isEmpty) {
      return [];
    }

    return [
      // Divider
      Container(
        margin: const EdgeInsets.symmetric(vertical: EditorialSpacing.spacing2),
        height: 1,
        color: colorScheme.outline.withOpacity(0.1),
      ),
      
      // Section header
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: EditorialSpacing.spacing4,
          vertical: EditorialSpacing.spacing2,
        ),
        child: Text(
          'AVAILABLE FORMS',
          style: editorial.labelUppercase.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontSize: 10,
          ),
        ),
      ),
      
      // Form items
      ...formData.take(5).map((form) { // Limit to 5 forms
        final formName = form.name ?? 'Unnamed Form';
        final formId = form.id ?? '';
        
        return _buildNavItem(
          icon: Icons.description_outlined,
          label: formName,
          isSelected: selectedItem == formName,
          colorScheme: colorScheme,
          editorial: editorial,
          onTap: () => _navigateToForm(formName, formId),
        );
      }).toList(),
    ];
  }

  Future<List<dynamic>> _loadNavigationData() async {
    try {
      final forms = await ref
          .read(formBuilderViewModelProvider.notifier)
          .getFormNames();
      return forms ?? [];
    } catch (e) {
      return [];
    }
  }

  void _navigateToItem(String itemName, String route) {
    ref.read(navigationStateProvider.notifier).selectNavItem(itemName, route);
    ref.read(currentRouteProvider.notifier).state = route;
    context.go(route);
  }

  void _navigateToForm(String formName, String formId) {
    final route = '/client/forms/$formId';
    ref.read(navigationStateProvider.notifier).selectNavItem(formName, route);
    ref.read(currentRouteProvider.notifier).state = route;
    context.go(route);
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required ColorScheme colorScheme,
    required EditorialThemeData editorial,
    required VoidCallback onTap,
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
          onTap: onTap,
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
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: isSelected
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection(ColorScheme colorScheme, EditorialThemeData editorial, BuildContext context) {
    return Container(
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
    );
  }

  Widget _buildBottomSection(String selectedItem, ColorScheme colorScheme, EditorialThemeData editorial) {
    return Container(
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
            isSelected: selectedItem == 'Help Center',
            colorScheme: colorScheme,
            editorial: editorial,
            onTap: () => _navigateToItem('Help Center', '/help'),
          ),
          _buildNavItem(
            icon: Icons.person_outline,
            label: 'Account',
            isSelected: selectedItem == 'Account',
            colorScheme: colorScheme,
            editorial: editorial,
            onTap: () => _navigateToItem('Account', '/account'),
          ),
        ],
      ),
    );
  }
}