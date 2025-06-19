import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';
import 'package:ticketzone/presentation/widgets/events/event_poster_link.dart';

class EventMasonry extends StatefulWidget {

  final List<EventEntity> events;
  final VoidCallback? loadNextPage;

  const EventMasonry({
    super.key, 
    required this.events, 
    this.loadNextPage
  });

  @override
  State<EventMasonry> createState() => _EventMasonryState();
}

class _EventMasonryState extends State<EventMasonry> {

  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(widget.loadNextPage == null) return;
      
      if ((scrollController.position.pixels + 2500) >= scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: MasonryGridView.count(
          physics: const AlwaysScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          controller: scrollController,
          itemCount: widget.events.length,
          itemBuilder: (context, index) {
            if(index == 1){
              return Column(
                children: [
                const SizedBox(height: 20),
                EventPosterLink(event: widget.events[index],)
                ],
              );
            }
            return EventPosterLink(
              event: widget.events[index],);
          },
        ),
    );
  }
}
