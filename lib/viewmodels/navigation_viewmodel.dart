// lib/providers/navigation_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/routing/app_routes.dart';

// Navigation state model
class NavigationState {
  final String selectedItem;
  final String selectedRoute;

  const NavigationState({
    required this.selectedItem,
    required this.selectedRoute,
  });

  NavigationState copyWith({
    String? selectedItem,
    String? selectedRoute,
  }) {
    return NavigationState(
      selectedItem: selectedItem ?? this.selectedItem,
      selectedRoute: selectedRoute ?? this.selectedRoute,
    );
  }
}

// Navigation state notifier
class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier() : super(const NavigationState(
    selectedItem: 'Dashboard',
    selectedRoute: AppRoutePaths.home,
  ));

  void selectNavItem(String item, String route) {
    state = state.copyWith(selectedItem: item, selectedRoute: route);
  }

  void updateFromRoute(String currentRoute) {
    // Map routes to navigation items
    final routeToItemMap = {
      AppRoutePaths.coordinatorDashboard: 'Dashboard',
      AppRoutePaths.clientDashboard: 'Dashboard',
      AppRoutePaths.coordinatorFormBuilder: 'Form Builder',
      AppRoutePaths.coordinatorFormList: 'Form Builder',
      AppRoutePaths.clientViewForm: 'Forms',
      AppRoutePaths.coordinatorEvents: 'Events',
      AppRoutePaths.coordinatorAnalytics: 'Analytics',
      AppRoutePaths.settings: 'Settings',
    };

    String selectedItem = 'Dashboard';
    
    // Check if current route matches any nav item
    for (final entry in routeToItemMap.entries) {
      if (currentRoute.startsWith(entry.key)) {
        selectedItem = entry.value;
        break;
      }
    }

    // Check for dynamic form routes
    if (currentRoute.contains('/forms/') && !currentRoute.contains('/form-')) {
      selectedItem = 'Forms'; // For specific form pages
    }

    state = state.copyWith(
      selectedItem: selectedItem,
      selectedRoute: currentRoute,
    );
  }
}

// Provider for navigation state
final navigationStateProvider = StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  return NavigationNotifier();
});

// Provider for current route tracking
final currentRouteProvider = StateProvider<String>((ref) => AppRoutePaths.home);