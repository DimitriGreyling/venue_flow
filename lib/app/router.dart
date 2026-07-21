import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/application/session_provider.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/customers/presentation/customers_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import 'shell/app_scaffold.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  // Forces GoRouter to re-run redirect when sessionProvider changes.
  final refresh = ValueNotifier<int>(0);
  ref.listen<AsyncValue<SessionState>>(sessionProvider, (_, __) {
    refresh.value++;
  });

  return GoRouter(
    initialLocation: '/dashboard',
    refreshListenable: refresh,
    redirect: (_, state) {
      final sessionAsync = ref.read(sessionProvider);

      // While hydrating token from storage, don't redirect yet.
      if (sessionAsync.isLoading) return null;

      final session = sessionAsync.valueOrNull;
      final isAuthed =
          (session?.isAuthenticated ?? false) &&
              ((session?.accessToken?.isNotEmpty ?? false));

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