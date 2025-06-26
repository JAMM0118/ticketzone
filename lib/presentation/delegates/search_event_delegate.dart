import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';
import 'package:ticketzone/presentation/widgets/events/event_item.dart';

typedef SearchEventCallback = Future<List<EventEntity>> Function(String query);

class SearchEventDelegate extends SearchDelegate<EventEntity?> {
  final SearchEventCallback searchEvent;
  List<EventEntity> initialEvents;
  StreamController<List<EventEntity>> debounceEvents =
      StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchEventDelegate({required this.searchEvent, required this.initialEvents});

  void clearStreams() {
    debounceEvents.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final events = await searchEvent(query);
      initialEvents = events;
      debounceEvents.add(events);
      isLoadingStream.add(false);
    });
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialEvents,
      stream: debounceEvents.stream,
      builder: (context, snapshot) {
        final events = snapshot.data ?? [];
        return (events.isEmpty && query.isNotEmpty)
            ? const Center(child: Text("No events found", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
            : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return EventItem(
                  event: events[index],
                  onEventSelected: (context, event) {
                    clearStreams();
                    close(context, event);
                  },
                );
              },
            );
      },
    );
  }

  @override
  String? get searchFieldLabel => "Search Events";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 1),
              spins: 10,
              infinite: true,
              child: IconButton(
                icon: Icon(Icons.refresh_rounded),
                onPressed: () {},
              ),
            );
          }
          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => query = "",
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        clearStreams();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return buildResultsAndSuggestions();
  }
}
