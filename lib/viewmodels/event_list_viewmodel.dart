import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/models/event_model.dart';
import 'package:venue_flow_app/models/user_model.dart';
import 'package:venue_flow_app/repositories/event_repository.dart';

class EventListState {
  final List<EventModel> events;
  final bool isLoading;
  final String? error;

  const EventListState({
    this.events = const [],
    this.isLoading = false,
    this.error,
  });

  EventListState copyWith({
    List<EventModel>? events,
    bool? isLoading,
    String? error,
  }) {
    return EventListState(
      events: events ?? this.events,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class EventListViewModel extends StateNotifier<EventListState> {
  final UserModel? Function() _getCurrentUser;
  final IEventRepository _eventRepository;

  EventListViewModel({
    required IEventRepository eventRepository,
    required UserModel? Function() getCurrentUser,
  })  : _eventRepository = eventRepository,
        _getCurrentUser = getCurrentUser,
        super(const EventListState());

  UserModel? get currentUser => _getCurrentUser();

  Future<void> loadEvents() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final events = await _eventRepository.search(
        searchString: null,
        pageNumber: 1,
        pageSize: 10,
      );

      state = state.copyWith(events: events.data, isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addEvent(EventModel eventModel) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final newEvent = await _eventRepository.addEvent(eventModel: eventModel);
      if (newEvent != null) {
        state = state.copyWith(
          events: [...state.events, newEvent],
          isLoading: false,
          error: null,
        );
      } else {
        throw Exception('Failed to create event');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateEvent(EventModel eventModel) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final updatedEvent = await _eventRepository.updateEvent(eventModel: eventModel);
      if (updatedEvent != null) {
        final updatedEvents = state.events.map((e) => e.id == updatedEvent.id ? updatedEvent : e).toList();
        state = state.copyWith(events: updatedEvents, isLoading: false, error: null);
      } else {
        throw Exception('Failed to update event');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
