import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/models/user_model.dart';
import 'package:venue_flow_app/providers/auth_provider.dart';
import 'package:venue_flow_app/providers/viewmodel_provider.dart';
import 'package:venue_flow_app/theme/editorial_theme_data.dart';
import 'package:venue_flow_app/theme/spacing.dart';

class SideNavWidget extends ConsumerStatefulWidget {
  const SideNavWidget({super.key});

  @override
  ConsumerState<SideNavWidget> createState() => _SideNavWidgetState();
}

class _SideNavWidgetState extends ConsumerState<SideNavWidget> {
  String _selectedNavItem = 'Dashboard';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial;

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
          // Container(
          //   margin: const EdgeInsets.symmetric(
          //     horizontal: EditorialSpacing.spacing6,
          //     vertical: EditorialSpacing.spacing4,
          //   ),
          //   width: double.infinity,
          //   child: ElevatedButton.icon(
          //     onPressed: () {},
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: colorScheme.primary,
          //       foregroundColor: colorScheme.onPrimary,
          //       padding: const EdgeInsets.symmetric(vertical: 12),
          //       elevation: 8,
          //       shadowColor: colorScheme.primary.withOpacity(0.2),
          //     ),
          //     icon: const Icon(Icons.add, size: 16),
          //     label: const Text('New Event'),
          //   ),
          // ),

          // Navigation Items
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: EditorialSpacing.spacing4),
              child: Consumer(
                builder: (context, ref, child) {
                  UserModel? currentUser = ref.watch(currentUserProvider);

                  final user =
                      ref.watch(authRepositoryProvider).getCurrentUser();
                  return FutureBuilder(
                    future: ref
                        .watch(formBuilderViewModelProvider.notifier)
                        .getFormNames(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return Column(
                        children: [
                          _buildNavItem(
                              icon: Icons.dashboard_outlined,
                              label: 'Dashboard',
                              isSelected: _selectedNavItem == 'Dashboard',
                              colorScheme: colorScheme,
                              editorial: editorial,
                              navigateToLink: 'dashboard'),
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
                          //TODO:: IMPLEMENT proper form navigation
                          if (snapshot.data != null &&
                              snapshot.data!.isNotEmpty &&
                              currentUser?.role == UserRole.client)
                            ...snapshot.data!.map((x) {
                              return _buildNavItem(
                                  icon: Icons.settings_outlined,
                                  label: x.name ?? '',
                                  isSelected: _selectedNavItem == x.name,
                                  colorScheme: colorScheme,
                                  editorial: editorial,
                                  navigateToLink: 'form-list');
                            }),
                        ],
                      );
                    },
                  );
                },
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
}
