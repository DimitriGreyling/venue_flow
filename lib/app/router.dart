import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:venue_flow_app/app/shell/app_shell.dart';
import 'package:venue_flow_app/features/dashboard/presentation/dashboard_screen.dart';
import 'package:venue_flow_app/features/login/application/auth_controller.dart';
import 'package:venue_flow_app/features/login/presentation/login_screen.dart';

import 'global_popup.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);
  final isAuthenticated = authState.valueOrNull != null;

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/sign-in',
    redirect: (_, state) {
      final location = state.matchedLocation;
      final isProtectedRoute = location == '/dashboard';
      final isAuthRoute = location == '/sign-in';

      if (!isAuthenticated && isProtectedRoute) {
        return '/sign-in';
      }

      if (isAuthenticated && isAuthRoute) {
        return '/dashboard';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        redirect: (_, __) => '/sign-in',
      ),
      GoRoute(
        path: '/dashboard',
        builder: (_, __) => const AppShell(child: DashboardScreen()),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (_, __) => const LoginScreen(),
      ),
    ],
  );
});
