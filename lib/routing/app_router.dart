import 'package:go_router/go_router.dart';
import 'package:venue_flow_app/views/home_page.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  restorationScopeId: 'appRouter',
  routes: [
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const DashboardPage(),
    ),    
  ],
);