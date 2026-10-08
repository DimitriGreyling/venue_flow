import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/auth_session.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/home/presentation/home_screen.dart';
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
    initialLocation: '/home',
    refreshListenable: refresh,
    routes: [
      GoRoute(path: '/', redirect: (_, __) => '/home'),
      GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/venues', builder: (_, __) => const VenueListScreen()),
    ],
    // redirect: (_, state) {
    //   final auth = ref.read(authSessionProvider);
    //
    //   // Mid-login: stay where you are
    //   if (auth.isLoading) return null;
    //
    //   final isAuthed = auth.value ?? false;
    //   final loc = state.matchedLocation;
    //   final goingToLogin = loc == '/login';
    //
    //   if (!isAuthed) {
    //     if (goingToLogin) return null;
    //     // Remember where the user was trying to go
    //     final from = Uri.encodeComponent(state.uri.toString());
    //     return '/login?from=$from';
    //   }
    //
    //   if (goingToLogin) {
    //     // Return to the original URL, or home
    //     final from = state.uri.queryParameters['from'];
    //     if (from != null && from.isNotEmpty && !from.startsWith('/login')) {
    //       return from;
    //     }
    //     return '/home';
    //   }
    //
    //   return null; // logged in: stay on the current URL
    // },

    redirect: (_, state) {
      final auth = ref.read(authSessionProvider);

      // Mid-login: stay where you are
      if (auth.isLoading) return null;

      final isAuthed = auth.value ?? false;
      final loc = state.matchedLocation;
      final goingToLogin = loc == '/login';

      // Routes a logged-out user may visit
      const publicRoutes = {'/home'};

      if (!isAuthed) {
        if (goingToLogin || publicRoutes.contains(loc)) return null;
        final from = Uri.encodeComponent(state.uri.toString());
        return '/login?from=$from';
      }

      if (goingToLogin) {
        final from = state.uri.queryParameters['from'];
        if (from != null && from.isNotEmpty && !from.startsWith('/login')) {
          return from;
        }
        return '/home';
      }

      return null;
    },
  );
}
