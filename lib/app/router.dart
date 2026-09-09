import 'package:go_router/go_router.dart';
import 'package:venue_flow_app/features/dashboard/presentation/dashboard_screen.dart';

class AppRouter {
  AppRouter();

  final GoRouter router = GoRouter(
    initialLocation: '/dashboard',
    routes: [
      GoRoute(
        path: '/',
        redirect: (_, __) => '/dashboard',
      ),
      GoRoute(
        path: '/dashboard',
        builder: (_, __) => const DashboardScreen(),
      ),
    ],
  );
}
