import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/appointment/presentation/appointment_screen.dart';
import '../../features/appointment_configuration/presentation/appointment_configuration_screen.dart';
import '../../features/auth/presentation/auth_session.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/customers/presentation/customer_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/form/presentation/form_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/venues/presentation/venue_list_screen.dart';
import '../error/error_service.dart';

part 'app_router.g.dart';

/// Stores the GoRouter instance in a globally accessible variable so that
/// the current route can be retrieved from classes that do not have access
/// to a BuildContext or Riverpod Ref.
///
/// Example:
/// ```dart
/// static String get currentRoute {
///   return appRouterInstance
///       ?.routerDelegate.currentConfiguration.uri.toString() ?? '';
/// }
/// ```
GoRouter? appRouterInstance;

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen(authSessionProvider, (_, __) => refresh.value++);
  ref.onDispose(refresh.dispose);

  final appRouter = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/home',
    refreshListenable: refresh,
    routes: [
      GoRoute(path: '/', redirect: (_, __) => '/home'),
      GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/venues', builder: (_, __) => const VenueListScreen()),
      GoRoute(path: '/dashboard', builder: (_, __) => const DashboardScreen()),
      GoRoute(path: '/forms', builder: (_, __) => const FormScreen()),
      GoRoute(
        path: '/appointments',
        builder: (_, __) => const AppointmentScreen(),
      ),
      GoRoute(path: '/customers', builder: (_, __) => const CustomerScreen()),
      GoRoute(
        path: '/appointment-configuration',
        builder: (_, __) => const AppointmentConfigurationScreen(),
      ),
    ],
    redirect: (_, state) {
      final auth = ref.read(authSessionProvider);

      // Mid-login: stay where you are
      if (auth.isLoading) return null;

      final isAuthed = auth.value ?? false;
      final loc = state.matchedLocation;
      final goingToLogin = loc == '/login';

      // Routes a logged-out user may visit
      const publicRoutes = {'/home'};

      if (!isAuthed) {
        if (goingToLogin || publicRoutes.contains(loc)) return null;
        final from = Uri.encodeComponent(state.uri.toString());
        return '/login?from=$from';
      }

      if (goingToLogin) {
        final from = state.uri.queryParameters['from'];
        if (from != null && from.isNotEmpty && !from.startsWith('/login')) {
          return from;
        }
        return '/home';
      }

      return null;
    },
  );

  ///
  /// Set the app router instance to global accessible variable so that current route can be retrieved
  ///
  appRouterInstance = appRouter;

  return appRouter;
}
