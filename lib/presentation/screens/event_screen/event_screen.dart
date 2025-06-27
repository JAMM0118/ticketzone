import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';
import 'package:ticketzone/presentation/providers/providers.dart';
import 'package:ticketzone/presentation/widgets/widgets.dart';
import '../../helpers/helpers.dart';

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
    final getTicketsBought = ref.watch(getTicketsBoughtProvider);
    final userInSession = ref.watch(getUserByEmailProvider);
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;

    if (event == null) return Scaffold( body: Center(child: CircularProgressIndicator(strokeWidth: 2)), );
    final ticketBought = getTicketsBought.where(
      (ticket) => ticket.ticketId == event.id && ticket.userId == userInSession.id
    ).isNotEmpty;
    final loading = ref.watch(loadingProvider);
    return Scaffold(
      body:Stack(
        children: [
          CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers:[
              CustomSliverAppBar(event: event),
              SliverList(
                  delegate: SliverChildBuilderDelegate( 
                    (context, index) => EventDetails(event: event), childCount: 1,
                  ),
                ),
              ],
          ),
          if (loading) const ProcessingLoader(message: "Processing ticket purchase...",),   
        ],
      ),
      bottomSheet: Container(
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
          color: ticketBought ? Colors.grey.withValues(alpha: 0.5) 
          :event.isOnSale
                  ? colors.onPrimary.withValues(alpha: 0.5)
                  : Colors.grey,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ElevatedButton(     
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), ),),
          onPressed: ()  => ( ticketBought ? null :  event.isOnSale ?
           buyTicket(buyUrl: event.buyUrl,eventEntity: event,ref: ref) : null),
          child: Text(ticketBought ? "TICKET BOUGHT" :
            event.isOnSale ? "BUY TICKET" : "SOLD OUT",
            style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
