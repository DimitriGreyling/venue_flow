import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      
      final events = await _eventRepository.getEventsbyTenant(
        tenantId: currentUser?.tenantId ?? '',
      );
      state = state.copyWith(
        events: [],//events,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  
}
