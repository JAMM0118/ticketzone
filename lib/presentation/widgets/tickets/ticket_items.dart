import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketzone/domain/entities/db_tickets_bought_entity.dart';
import 'package:ticketzone/presentation/helpers/helpers.dart';
import 'package:ticketzone/presentation/widgets/qr_view/qr_view.dart';

class TicketItems extends StatelessWidget {
  final DbTicketsBoughtEntity ticket;
  const TicketItems({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {context.push('/event/${ticket.ticketId}')},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CircleAvatar(radius: 30,backgroundImage: NetworkImage(ticket.imageUrl),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(ticket.name,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  overflow: TextOverflow.visible),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text('Fecha: ',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(ticket.startDate),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Hora: ',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(ticket.startTime),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              IconButton(
                constraints: const BoxConstraints(
                  minWidth: 50,
                  minHeight: 50,
                  maxWidth: 50,
                  maxHeight: 50,
                ),

                onPressed:() => showDialog(
                context: context, builder: (context) {
                  return QRView(ticketId: ticket.ticketId);},),
                icon: Icon(Icons.qr_code_rounded),
                tooltip: 'QR Code',
                color: Theme.of(context).colorScheme.primary,
              ),
              IconButton(
                onPressed: ()=> searchLocation(ticket),
                icon: Icon(Icons.location_on_sharp),
                tooltip: 'Location',
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
