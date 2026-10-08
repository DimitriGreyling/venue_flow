import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/venues/presentation/venue_list_screen.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: '/venues',
    routes: [
      GoRoute(
        path: '/venues',
        builder: (context, state) => const VenueListScreen(),
      ),
    ],
  );
}