import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/features/dashboard/data/dashboard_repository.dart';
import 'package:venue_flow_app/features/dashboard/domain/dashboard_summary.dart';

final dashboardControllerProvider = AsyncNotifierProvider<DashboardController, DashboardSummary>(() {
  return DashboardController();
});

class DashboardController extends AsyncNotifier<DashboardSummary> {
  @override
  Future<DashboardSummary> build() async {
    final repository = ref.read(dashboardRepositoryProvider);
    return repository.fetchSummary();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(dashboardRepositoryProvider);
      return repository.fetchSummary();
    });
  }
}
