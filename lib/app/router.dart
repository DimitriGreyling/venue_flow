import 'package:go_router/go_router.dart';
import 'package:venue_flow_app/features/dashboard/presentation/dashboard_screen.dart';
import 'package:venue_flow_app/features/home/presentation/home_screen.dart';

import '../features/login/presentation/login_screen.dart';

class AppRouter {
  AppRouter();

  final GoRouter router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/',
        redirect: (_, __) => '/home',
      ),
      GoRoute(
        path: '/home',
        builder: (_, __) => const HomeScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (_, __) => const DashboardScreen(),
      ),
      GoRoute(path: '/sign-in', builder: (_, __) => const LoginScreen()),
    ],
  );
}
