import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:venue_flow_app/app/shell/app_shell.dart';
import 'package:venue_flow_app/features/bookings/presentation/bookings_screen.dart';
import 'package:venue_flow_app/features/customers/presentation/customers_screen.dart';
import 'package:venue_flow_app/features/dashboard/presentation/dashboard_screen.dart';
import 'package:venue_flow_app/features/home/presentation/home_screen.dart';
import 'package:venue_flow_app/features/login/application/auth_controller.dart';
import 'package:venue_flow_app/features/login/presentation/login_screen.dart';
import 'package:venue_flow_app/features/venues/presentation/venues_screen.dart';

import 'global_popup.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);
  final isAuthenticated = authState.valueOrNull != null;

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    redirect: (_, state) {
      final location = state.matchedLocation;
      final protectedRoutes = <String>{
        '/dashboard',
        '/venues',
        '/customers',
        '/bookings',
      };
      final isProtectedRoute = protectedRoutes.contains(location);
      final isAuthRoute = location == '/sign-in';

      if (!isAuthenticated && isProtectedRoute) {
        return '/';
      }

      if (isAuthenticated && isAuthRoute) {
        return '/dashboard';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const HomeScreen(),
      ),
      ShellRoute(
        builder: (_, __, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (_, __) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/venues',
            builder: (_, __) => const VenuesScreen(),
          ),
          GoRoute(
            path: '/customers',
            builder: (_, __) => const CustomersScreen(),
          ),
          GoRoute(
            path: '/bookings',
            builder: (_, __) => const BookingsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/sign-in',
        builder: (_, __) => const LoginScreen(),
      ),
    ],
  );
});
