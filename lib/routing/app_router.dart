import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:venue_flow_app/routing/app_routes.dart';
import 'package:venue_flow_app/views/analytics_page.dart';
import 'package:venue_flow_app/views/calendar_page.dart';
import 'package:venue_flow_app/views/events_page.dart';
import 'package:venue_flow_app/views/home_logged_out_page.dart';
import 'package:venue_flow_app/views/settings_page.dart';
import 'package:venue_flow_app/views/view_form_page.dart';
import '../providers/auth_provider.dart';
import '../views/form_builder_page.dart';
import '../views/form_list_page.dart';
import '../views/home_page.dart';
import '../views/login_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
GoRouter? _previousRouter;

class _AuthLoadingPage extends StatelessWidget {
  const _AuthLoadingPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authViewModelProvider);

  final previousLocation =
      _previousRouter?.routeInformationProvider.value.uri.toString();

  final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: previousLocation ?? AppRoutePaths.home,
    redirect: (context, state) {
      final isAuthenticated = authState.isAuthenticated;
      final isLoading = authState.isLoading;
      final isProfileHydrated = authState.user != null;

      final isAuthPage =
          state.matchedLocation == AppRoutePaths.home ||
          state.matchedLocation == AppRoutePaths.signup ||
          state.matchedLocation == AppRoutePaths.login;

      if (isAuthenticated && !isProfileHydrated) {
        if (state.matchedLocation != AppRoutePaths.authLoading) {
          return AppRoutePaths.authLoading;
        }
        return null;
      }

      if (!isAuthenticated &&
          state.matchedLocation == AppRoutePaths.authLoading) {
        return AppRoutePaths.login;
      }

      if (isLoading) {
        return null;
      }

      if (!isAuthenticated && !isAuthPage) {
        final from = Uri.encodeComponent(state.uri.toString());
        return '${AppRoutePaths.login}?from=$from';
      }

      if (isAuthenticated && isAuthPage) {
        final from = state.uri.queryParameters['from'];
        if (from != null && from.isNotEmpty) {
          return Uri.decodeComponent(from);
        }

        return authState.user?.isCoordinator == true
            ? AppRoutePaths.coordinatorDashboard
            : AppRoutePaths.clientDashboard;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutePaths.login,
        name: AppRouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutePaths.calendarPage,
        name: AppRouteNames.calendarPage,
        builder: (context, state) => const CalendarPage(),
      ),
      GoRoute(
        path: AppRoutePaths.home,
        name: AppRouteNames.home,
        builder: (context, state) => const HomeLoggedOutPage(),
      ),
      GoRoute(
        path: AppRoutePaths.authLoading,
        name: AppRouteNames.authLoading,
        builder: (context, state) => const _AuthLoadingPage(),
      ),
      GoRoute(
        path: AppRoutePaths.signup,
        name: AppRouteNames.signup,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutePaths.coordinatorDashboard,
        name: AppRouteNames.coordinatorDashboard,
        builder: (context, state) => const DashboardPage(),
        routes: [
          GoRoute(
            path: 'form-builder',
            name: AppRouteNames.formBuilder,
            builder: (context, state) {
              final id = state.uri.queryParameters['id'];
              final formModel =
                  state.extra != null
                      ? (state.extra as Map)['formModel']
                      : null;
              return FormBuilderPage(formId: id, formModel: formModel);
            },
          ),
          GoRoute(
            path: 'form-list',
            name: AppRouteNames.formList,
            builder: (context, state) => const FormListPage(),
          ),
          GoRoute(
            path: 'events',
            name: AppRouteNames.coordinatorEvents,
            builder: (context, state) => const EventsPage(),
          ),
          GoRoute(
            path: 'analytics',
            name: AppRouteNames.coordinatorAnalytics,
            builder: (context, state) => const AnalyticsPage(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutePaths.clientDashboard,
        name: AppRouteNames.clientDashboard,
        builder: (context, state) => const DashboardPage(),
        routes: [
          GoRoute(
            path: 'view-form',
            name: AppRouteNames.viewForm,
            builder: (context, state) {
              return const ViewFormPage();
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutePaths.settings,
        name: AppRouteNames.settings,
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );

  _previousRouter = router;
  return router;
});
