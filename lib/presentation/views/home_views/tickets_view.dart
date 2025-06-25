import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketzone/presentation/providers/database/db_providers.dart';

class TicketsView extends ConsumerStatefulWidget {
  const TicketsView({super.key});

  @override
  TicketsViewState createState() => TicketsViewState();
}

class TicketsViewState extends ConsumerState<TicketsView> {
  @override
  void initState() {
    super.initState();
        ref.read(getTicketsBoughtProvider.notifier).loadTicketsBought();
  }

  @override
  Widget build(BuildContext context) {
    final getTicketsBought = ref.watch(getTicketsBoughtProvider);

    return Visibility(
      visible: getTicketsBought.isNotEmpty,
      replacement: const Center(child: Text('No tickets bought yet',
      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold
      ),),),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tickets'),
          centerTitle: true,
        ),
        body:ListView.builder(
          itemCount: getTicketsBought.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(getTicketsBought[index].imageUrl),
                  ),
                  title: Text(getTicketsBought[index].name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Fecha: ',style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),),
                          Text(getTicketsBought[index].startDate),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Hora: ',style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),),
                          Text(getTicketsBought[index].startTime),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    context.push('/event/${getTicketsBought[index].ticketId}');
                  },
                ),
              ],
            );
          },
        
         )
      ),
    );
  }
}