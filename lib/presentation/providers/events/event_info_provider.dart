import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';
import 'package:ticketzone/presentation/providers/providers.dart';

final eventInfoProvider = StateNotifierProvider<EventMapNotifier, Map<String, EventEntity>>((ref) {
  final eventRepository = ref.watch(eventsRepositoryProvider);
  return EventMapNotifier(getEvent: eventRepository.getEventById);
});


typedef GetEventCallBack = Future<EventEntity> Function(String eventId);

class EventMapNotifier extends StateNotifier<Map<String, EventEntity>> {

  final GetEventCallBack getEvent;

  EventMapNotifier({required this.getEvent}) : super({});

  Future<void> loadEvent(String eventId) async{
    if(state[eventId] != null) return;

    final event = await getEvent(eventId);

    state = {...state, eventId: event};
  }
}