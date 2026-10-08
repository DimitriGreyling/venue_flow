import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/auth_session.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/venues/presentation/venue_list_screen.dart';
import '../error/error_service.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen(authSessionProvider, (_, __) => refresh.value++);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/login',
    refreshListenable: refresh,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (_, __) =>
        const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/venues', builder: (_, __) => const VenueListScreen()),
    ],
    redirect: (_, state) {
      final auth = ref.read(authSessionProvider);
      final loc = state.matchedLocation;

      // Wait while reading token
      if (auth.isLoading) return loc == '/splash' ? null : '/splash';

      final isAuthed = auth.value ?? false;

      if (!isAuthed) {
        // Logged-out users can only access login/splash
        if (loc == '/login' || loc == '/splash') return null;
        return '/login';
      }

      // Logged-in users should not be on login/splash
      if (loc == '/login' || loc == '/splash') return '/venues';
      return null;
    },
  );
}