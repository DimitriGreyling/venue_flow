import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:venue_flow_app/views/event_list_page.dart';
import 'package:venue_flow_app/views/home_logged_out_page.dart';
import 'package:venue_flow_app/views/view_form_page.dart';
import '../providers/auth_provider.dart';
import '../views/form_builder_page.dart';
import '../views/form_list_page.dart';
import '../views/home_page.dart';
import '../views/login_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
GoRouter? _previousRouter;

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authViewModelProvider);

  final previousLocation =
      _previousRouter?.routeInformationProvider.value.uri.toString();

  final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: previousLocation ?? '/home',
    redirect: (context, state) {
      final isAuthenticated = authState.isAuthenticated;
      final isLoading = authState.isLoading;

      final isAuthPage = state.matchedLocation == '/home' ||
          state.matchedLocation == '/signup';

      if (isLoading) {
        return null;
      }

      if (!isAuthenticated && !isAuthPage) {
        final from = Uri.encodeComponent(state.uri.toString());
        return '/login?from=$from';
      }

      if (isAuthenticated && isAuthPage) {
        final from = state.uri.queryParameters['from'];
        if (from != null && from.isNotEmpty) {
          return Uri.decodeComponent(from);
        }

        return authState.user?.isCoordinator == true
            ? '/coordinator'
            : '/client';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeLoggedOutPage(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/coordinator',
        name: 'coordinator-dashboard',
        builder: (context, state) => const DashboardPage(),
        routes: [
          GoRoute(
            path: 'form-builder',
            name: 'form-builder',
            builder: (context, state) {
              final id = state.uri.queryParameters['id'];
              final formModel = state.extra != null
                  ? (state.extra as Map)['formModel']
                  : null;
              return FormBuilderPage(
                formId: id,
                formModel: formModel,
              );
            },
          ),
          GoRoute(
            path: 'form-list',
            name: 'form-list',
            builder: (context, state) => const FormListPage(),
          ),
          GoRoute(
            path: 'event-list',
            name: 'event-list',
            builder: (context, state) => const EventListPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/client',
        name: 'client-dashboard',
        builder: (context, state) => const DashboardPage(),
        routes: [
          GoRoute(
            path: '/view-form',
            name: 'view-form',
            builder: (context, state) {
              final id = state.uri.queryParameters['id'];
              return ViewFormPage();
            },
          ),
        ],
      ),
    ],
  );

  _previousRouter = router;
  return router;
});
