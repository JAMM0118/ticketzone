import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';
import 'package:ticketzone/presentation/providers/events/events_repository_provider.dart';

final getEventsByCategoryProvider = StateNotifierProvider<EventsNotifier, List<EventEntity>>((ref){
  final fetchMoreEventsByCategory = ref.watch(eventsRepositoryProvider).getEventsByCategory;
  
  return EventsNotifier(
    fetchMoreEventsByCategory: fetchMoreEventsByCategory,
  );
});

typedef GetEventsByCategoryCallBack = Future<List<EventEntity>> Function({required String genreId,int page, int limit});

class EventsNotifier extends StateNotifier<List<EventEntity>> {
 
  int currentPageEventsByCategory = 0;
  int currentItemCountEventsByCategory = 10;
  bool isLoading = false;
  GetEventsByCategoryCallBack fetchMoreEventsByCategory;

  EventsNotifier({required this.fetchMoreEventsByCategory}) : super([]);

  Future<void> loadNextPageEventsByCategory({required String genreId}) async {
    
    if (isLoading) return;
    isLoading = true;
    if (currentItemCountEventsByCategory * currentPageEventsByCategory > 1000 || currentItemCountEventsByCategory > 199) {
      currentItemCountEventsByCategory = 10;
      currentPageEventsByCategory++;
    }

    final List<EventEntity> newEventsByCategory = await fetchMoreEventsByCategory(
      genreId:genreId, page: currentPageEventsByCategory, limit: currentItemCountEventsByCategory);
    final existingIds = state.map((e) => e.id).toSet();
    state = [...state, ...newEventsByCategory.where((event) => !existingIds.contains(event.id))];
    await Future.delayed(const Duration(milliseconds: 500 ));
    isLoading = false;
    currentItemCountEventsByCategory+=10;   
  }

  Future<void> resetCategories() async{
    state = [];
    currentPageEventsByCategory = 0;
    currentItemCountEventsByCategory = 10;
  }
}
