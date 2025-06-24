import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';
import 'package:ticketzone/presentation/providers/providers.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedEventsProvider = StateNotifierProvider<SearchedEventNotifier, List<EventEntity>>((ref) {
      final eventRepository = ref.read(eventsRepositoryProvider);

      return SearchedEventNotifier(
        searchEvent: eventRepository.searchEvents,
        ref: ref,
      );
    });

typedef SearchedEventCallback = Future<List<EventEntity>> Function(String query);

class SearchedEventNotifier extends StateNotifier<List<EventEntity>> {
  final SearchedEventCallback searchEvent;
  final Ref ref;
  SearchedEventNotifier({required this.searchEvent, required this.ref})
    : super([]);

  Future<List<EventEntity>> searchEventByQuery(String query) async {
    final List<EventEntity> events = await searchEvent(query);

    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = events;

    return events;
  }
}
