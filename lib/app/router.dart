import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/customers/presentation/customers_screen.dart';
import '../features/auth/application/session_provider.dart';
import 'shell/app_scaffold.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final session = ref.watch(sessionProvider);

  return GoRouter(
    initialLocation: '/dashboard',
    redirect: (_, state) {
      final isAuthed = session.valueOrNull?.isAuthenticated ?? false;
      final isLogin = state.matchedLocation == '/login';

      if (!isAuthed && !isLogin) return '/login';
      if (isAuthed && isLogin) return '/dashboard';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (_, __, child) => AppScaffold(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (_, __) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/customers',
            builder: (_, __) => const CustomersScreen(),
          ),
        ],
      ),
    ],
  );
});