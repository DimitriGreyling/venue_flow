import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:venue_flow_app/constants/supabase_table_names.dart';
import 'package:venue_flow_app/models/event_model.dart';

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
  final SupabaseClient _client;

  EventRepository({
    required SupabaseClient client,
  }) : _client = client;

  final _tableName = SupabaseTableNames.eventTable;

  @override
  Future<List<EventModel>> getEventsbyTenant({
    required String tenantId,
  }) async {
    final response =
        await _client.from(_tableName).select().eq('tenant_id', tenantId);

    return response.map((x)=> EventModel.fromJson(x)).toList();
  }

  @override
  Future<EventModel?> addEvent({
    required EventModel eventModel,
  }) async {
    final response =
        await _client.from(_tableName).insert(eventModel.toJson()).select();

    return response.map((x) => EventModel.fromJson(x)).first;
  }

  @override
  Future<EventModel?> updateEvent({
    required EventModel eventModel,
  }) async {
    final response =
        await _client.from(_tableName).update(eventModel.toJson()).select();

    return response.map((x) => EventModel.fromJson(x)).first;
  }
}
