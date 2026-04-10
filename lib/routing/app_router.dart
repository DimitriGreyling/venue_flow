import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/views/form_list_page.dart';
import 'package:venue_flow_app/views/home_page.dart';
import 'package:venue_flow_app/views/login_page.dart';
import '../providers/auth_provider.dart';
import '../views/form_builder_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authViewModelProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isAuthenticated = authState.isAuthenticated;
      final user = authState.user;

      // If not authenticated, redirect to login
      if (!isAuthenticated &&
          !state.matchedLocation.startsWith('/login') &&
          !state.matchedLocation.startsWith('/signup')) {
        return '/login';
      }

      // If authenticated, redirect from auth pages to appropriate dashboard
      if (isAuthenticated &&
          (state.matchedLocation.startsWith('/login') ||
              state.matchedLocation.startsWith('/signup'))) {
        if (user?.isCoordinator == true) {
          return '/coordinator';
        } else {
          return '/client';
        }
      }

      return null;
    },
    routes: [
      // Auth Routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const LoginPage(),
      ),

      // Coordinator Routes
      GoRoute(
        path: '/coordinator',
        name: 'coordinator-dashboard',
        builder: (context, state) => const DashboardPage(),
        routes: [
          GoRoute(
            path: '/form-builder',
            name: 'form-builder',
            builder: (context, state) {
              final id = state.uri.queryParameters['id'];
              final formModel = state.extra != null
                  ? (state.extra as Map<String, dynamic>)['formModel']
                  : null;
              return FormBuilderPage(
                formId: id,
                formModel: formModel,
              );
            },
          ),
          GoRoute(
            path: '/form-builder:id',
            name: 'form-builder-with-id',
            builder: (context, state) {
              final id = state.uri.queryParameters['id'];
              final formModel = state.extra != null
                  ? (state.extra as Map<String, dynamic>)['formModel']
                  : null;
              return FormBuilderPage(
                formId: id,
                formModel: formModel,
              );
            },
          ),
          GoRoute(
            path: '/form-list',
            name: 'form-list',
            builder: (context, state) => const FormListPage(),
          ),
        ],
      ),

      // Client Routes
      GoRoute(
        path: '/client',
        name: 'client-dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
    ],
  );
});
