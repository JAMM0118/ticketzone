import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';
import 'package:ticketzone/presentation/providers/events/events_repository_provider.dart';

final getEventsProvider = StateNotifierProvider<EventsNotifier, List<EventEntity>>((ref){
  final fetchMoreEvents = ref.watch(eventsRepositoryProvider).getEvents;
  
  return EventsNotifier(
    fetchMoreEvents: fetchMoreEvents,
  );
});


typedef EventCallBack = Future<List<EventEntity>> Function({int page, int limit});

class EventsNotifier extends StateNotifier<List<EventEntity>> {
 
  int currentPage = 0;
  int currentItemCount = 10;
  bool isLoading = false;
  EventCallBack fetchMoreEvents;
  EventsNotifier(
    {required this.fetchMoreEvents}
  
  ) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentItemCount+=10;
    if (currentItemCount * currentPage > 1000 || currentItemCount > 199) {
      currentItemCount = 10;
      currentPage++;
    }

    final List<EventEntity> newEvents = await fetchMoreEvents(page: currentPage, limit: currentItemCount);
    final existingIds = state.map((e) => e.id).toSet();
    state = [...state, ...newEvents.where((event) => !existingIds.contains(event.id))];
    await Future.delayed(const Duration(milliseconds: 500 ));
    isLoading = false;
   
  }

}