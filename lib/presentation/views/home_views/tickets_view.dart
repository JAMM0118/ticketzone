import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/presentation/providers/database/db_auth_provider.dart';
import 'package:ticketzone/presentation/providers/database/db_tickets_bought_provider.dart';
import 'package:ticketzone/presentation/widgets/tickets/ticket_items.dart';

class TicketsView extends ConsumerStatefulWidget {
  const TicketsView({super.key});

  @override
  TicketsViewState createState() => TicketsViewState();
}

class TicketsViewState extends ConsumerState<TicketsView> {
  @override
  Widget build(BuildContext context) {
    final getTicketsBought = ref.watch(getTicketsBoughtProvider);
    final userInSession = ref.watch(getUserByEmailProvider);

    return Visibility(
      visible: getTicketsBought.map((e) => e.userId).contains(userInSession.id),
      replacement: const Center(
        child: Text(
          'No tickets bought yet',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      child: Scaffold(
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 70),
          itemCount: getTicketsBought.length,
          itemBuilder: (context, index) {
            if (getTicketsBought[index].userId != userInSession.id) {
              return const SizedBox.shrink();
            }
            return TicketItems(ticket: getTicketsBought[index]);
          },
        ),
      ),
    );
  }
}
