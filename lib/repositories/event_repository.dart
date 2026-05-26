import 'package:venue_flow_app/models/event_model.dart';
import 'package:venue_flow_app/shared/helpers/api_client.dart';

abstract class IEventRepository {
  Future<List<EventModel>> getEventsbyTenant({
    required String tenantId,
  });
  Future<EventModel?> addEvent({
    required EventModel eventModel,
  });
  Future<EventModel?> updateEvent({
    required EventModel eventModel,
  });
}

class EventRepository extends IEventRepository {
  EventRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<List<EventModel>> getEventsbyTenant({
    required String tenantId,
  }) async {
    return [];
    // final response =
    //     await _apiClient.from(_tableName).select().eq('tenant_id', tenantId);

    // return response.map((x) => EventModel.fromJson(x)).toList();
  }

  @override
  Future<EventModel?> addEvent({
    required EventModel eventModel,
  }) async {
    return null;
  }

  @override
  Future<EventModel?> updateEvent({
    required EventModel eventModel,
  }) async {
    return null;
  }
}
