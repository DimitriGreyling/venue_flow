import 'package:venue_flow_app/constants/api_contract.dart';
import 'package:venue_flow_app/models/event_model.dart';
import 'package:venue_flow_app/models/paged_response.dart';
import 'package:venue_flow_app/shared/helpers/api_client.dart';

abstract class IEventRepository {
  Future<PagedResponse<EventModel>> search(
      {String? searchString, int? pageNumber = 1, int? pageSize = 10});
  Future<EventModel?> addEvent({
    required EventModel eventModel,
  });
  Future<EventModel?> updateEvent({
    required EventModel eventModel,
  });
  Future<void> deleteEvent({
    required String eventId,
  });
}

class EventRepository extends IEventRepository {
  EventRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<PagedResponse<EventModel>> search(
      {String? searchString, int? pageNumber = 1, int? pageSize = 10}) async {
    final response = await _apiClient.dio.get(
      ApiEndpoints.events,
      queryParameters: {
        ApiQueryKeys.search: searchString,
        ApiQueryKeys.pageNumber: pageNumber,
        ApiQueryKeys.pageSize: pageSize,
      },
    );

    return PagedResponse<EventModel>.fromJson(
      response.data,
      (json) => EventModel.fromJson(json),
    );
  }

  @override
  Future<EventModel?> addEvent({
    required EventModel eventModel,
  }) async {
    final response = await _apiClient.dio.post(
      ApiEndpoints.events,
      data: eventModel.toJson(),
    );

    if (response.statusCode == 201) {
      return EventModel.fromJson(response.data);
    } else {
      throw Exception('Failed to create event');
    }
  }

  @override
  Future<EventModel?> updateEvent({
    required EventModel eventModel,
  }) async {
    final response = await _apiClient.dio.put(
      '${ApiEndpoints.events}/${eventModel.id}',
      data: eventModel.toJson(),
    );

    if (response.statusCode == 200) {
      return EventModel.fromJson(response.data);
    } else {
      throw Exception('Failed to update event');
    }
  }

  @override
  Future<void> deleteEvent({
    required String eventId,
  }) async {
    final response = await _apiClient.dio.delete(
      '${ApiEndpoints.events}/$eventId',
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete event');
    }
  }
}
