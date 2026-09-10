import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/error/failure.dart';
import 'package:venue_flow_app/core/network/api_client.dart';
import 'package:venue_flow_app/core/network/dio_provider.dart';
import 'package:venue_flow_app/features/dashboard/domain/dashboard_summary.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final dio = ref.read(dioProvider);
  return DashboardRepository(ApiClient(dio));
});

class DashboardRepository {
  DashboardRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<DashboardSummary> fetchSummary() async {
    try {
      final data = await _apiClient.getJson('/dashboard/summary');
      return DashboardSummary.fromJson(data);
    } on Failure catch (_) {
      return const DashboardSummary(
        venueName: 'North Tower',
        occupancyRate: 86.4,
        revenue: 48250,
        activeBookings: 134,
        pendingAlerts: 9,
        lastUpdated: 'Fallback snapshot',
      );
    } on DioException catch (_) {
      return const DashboardSummary(
        venueName: 'North Tower',
        occupancyRate: 86.4,
        revenue: 48250,
        activeBookings: 134,
        pendingAlerts: 9,
        lastUpdated: 'Fallback snapshot',
      );
    }
  }
}
