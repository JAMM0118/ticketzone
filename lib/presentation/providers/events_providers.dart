import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';
import 'package:ticketzone/presentation/providers/events_repository_provider.dart';

final getEventsProvider = StateNotifierProvider<EventsNotifier, List<EventEntity>>((ref){
  final fetchMoreEvents = ref.watch(eventsRepositoryProvider).getEvents;
  
  return EventsNotifier(
    fetchMoreEvents: fetchMoreEvents,
  );
});


typedef EventCallBack = Future<List<EventEntity>> Function({int page, int limit});

class EventsNotifier extends StateNotifier<List<EventEntity>> {
 
  int curretPage = 0;
  int currentItemCount = 10;
  EventCallBack fetchMoreEvents;
  EventsNotifier(
    {required this.fetchMoreEvents}
  
  ) : super([]);

  Future<void> loadNextPage() async {
    
    currentItemCount++;
    if (currentItemCount * curretPage > 1000 || currentItemCount > 199) {
      currentItemCount = 1;
      curretPage++;
    }
    final List<EventEntity> newEvents = await fetchMoreEvents(page: curretPage, limit: currentItemCount);
    state = [...state, ...newEvents];
  }

}