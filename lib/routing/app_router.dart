import 'package:go_router/go_router.dart';
import 'package:venue_flow_app/views/form_builder_page.dart';
import 'package:venue_flow_app/views/home_page.dart';

final appRouter = GoRouter(
  initialLocation: '/form-builder',
  restorationScopeId: 'appRouter',
  routes: [
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: '/form-builder',
      name: 'form-builder',
      builder: (context, state) => FormBuilderPage(),
    ),
  ],
);
