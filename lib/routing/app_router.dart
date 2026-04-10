import 'package:go_router/go_router.dart';
import 'package:venue_flow_app/views/form_builder_page.dart';
import 'package:venue_flow_app/views/form_list_page.dart';
import 'package:venue_flow_app/views/home_page.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
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
      builder: (context, state) {
        final id = state.uri.queryParameters['id'];
        final formModel = state.extra != null ? (state.extra as Map<String, dynamic>)['formModel'] : null;

        return FormBuilderPage(formId: id,formModel: formModel,);
      },
    ),
    GoRoute(
      path: '/form-list',
      name: 'form-list',
      builder: (context, state) => FormListPage(),
    ),
  ],
);
