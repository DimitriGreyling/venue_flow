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
    final data = await _apiClient.getJson('/dashboard/summary');
    return DashboardSummary.fromJson(data);
  }
}
