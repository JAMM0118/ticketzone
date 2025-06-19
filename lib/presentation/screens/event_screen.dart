import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';
import 'package:ticketzone/presentation/providers/event_info_provider.dart';

class EventScreen extends ConsumerStatefulWidget {
  final String eventId;
  const EventScreen({super.key, required this.eventId});

  @override
  EventScreenState createState() => EventScreenState();
}

class EventScreenState extends ConsumerState<EventScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(eventInfoProvider.notifier).loadEvent(widget.eventId);
  }

  @override
  Widget build(BuildContext context) {
    final EventEntity? event = ref.watch(eventInfoProvider)[widget.eventId];

    if (event == null)return Scaffold( body: Center(child: CircularProgressIndicator(strokeWidth: 2)),);
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(event: event),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _EventDetails(event: event),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _EventDetails extends StatelessWidget {
  final EventEntity event;
  const _EventDetails({required this.event});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FadeInUp(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    children: [
                      Image.network(event.imageUrl, width: size.width * 0.35),
                      const SizedBox(height: 10),
                      event.isOnSale ? _EventSalesInfo(size: size, title:"OnSale" ,startDate: event.startDateSale,endDate: event.endDateSale, color: Colors.green,): const SizedBox(),
                      const SizedBox(height: 10,),
                      event.isPreSale ? _EventSalesInfo(size: size, title:"PreSale" ,startDate: event.startDatePreSale,endDate: event.endDatePreSale, color: Colors.red,) : const SizedBox(),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: (size.width - 55) * 0.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        event.description,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      _EventInfo(title: "Date", subtitle: event.startDate),
                      const SizedBox(height: 5),
                      _EventInfo(title: "Time", subtitle: event.startTime),
                      const SizedBox(height: 5),
                      _EventInfo(title: "Location", subtitle: event.location),
                      const SizedBox(height: 5),
                      _EventInfo(title: "City", subtitle: event.city),
                      const SizedBox(height: 5),
                      _EventInfo(title:"Country", subtitle:  event.country),
                       
                    ],
                  ),
                ),
              ],
            ),
          ),
           Container(
             alignment: Alignment.center,
             child: Chip(
               label: Text("${event.segment}  - ${event.genre} "),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(20),
               ),
             ),
           ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _EventSalesInfo extends StatelessWidget {
  final Size size;
  final String title;
  final Color color;
  final String startDate;
  final String endDate;
  const _EventSalesInfo({
    required this.color,
    required this.size,
    required this.title,
    required this.startDate,
    required this.endDate, 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.35,
    
      child: Container(
        decoration: BoxDecoration(
          color: color,
          
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(         
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border(bottom: BorderSide(color: Colors.white),right: BorderSide(color: Colors.white)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(title, textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),         
            Center(
              child: Text(
                  "Start: ${startDate.substring(0, 10)}",
                  style: TextStyle(fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                  "End: ${endDate.substring(0, 10)}",
                  style: TextStyle(fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
            ),  
            const SizedBox(height: 10),       
          ],
        ),
      ),
    );
  }
}

class _EventInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  const _EventInfo({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$title: ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Flexible(
          child: Text(
            subtitle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final EventEntity event;
  const _CustomSliverAppBar({required this.event});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        title: Text(
          event.name,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                event.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return FadeIn(child: child);
                  return const SizedBox();
                },
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.5, 1.0],
                    colors: [Colors.transparent, Colors.black87],
                  ),
                ),
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0, 0.3],
                    colors: [Colors.black87, Colors.transparent],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

