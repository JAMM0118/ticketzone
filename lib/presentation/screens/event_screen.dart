import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';
import 'package:ticketzone/presentation/providers/events/event_info_provider.dart';
import 'package:ticketzone/presentation/widgets/events/event_details.dart';
import 'package:ticketzone/presentation/widgets/shared/custom_sliver_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class EventScreen extends ConsumerStatefulWidget {
  final String eventId;
  const EventScreen({super.key, required this.eventId});

  @override
  EventScreenState createState() => EventScreenState();
}

void _launchURL({required String buyUrl}) async {
  final Uri url = Uri.parse(buyUrl);
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'No se pudo abrir $url';
  }
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

    if (event == null) return Scaffold(body: Center(child: CircularProgressIndicator(strokeWidth: 2)),);
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(

      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          CustomSliverAppBar(event: event),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => EventDetails(event: event),
              childCount: 1,
            ),
          ),         
        ],
      ),
      bottomSheet:  Container(
        height: 80,
        width: size.width * 0.75,
        foregroundDecoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: const BorderRadius.only(    
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        decoration: BoxDecoration(
          color: event.isOnSale ? colors.onPrimary.withValues(alpha: 0.5) : Colors.grey,    
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),)
            ),
            
          onPressed: () => event.isOnSale ? _launchURL(buyUrl: event.buyUrl) : null,
          child: Text(
            event.isOnSale ? "BUY TICKET" : "SOLD OUT",
            style: TextStyle(color: Colors.white
                , fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}