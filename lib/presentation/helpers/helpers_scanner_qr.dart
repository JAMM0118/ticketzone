import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketzone/domain/entities/db_tickets_bought_entity.dart';
import 'package:ticketzone/domain/entities/db_user_entity.dart';
import 'package:ticketzone/presentation/helpers/helpers.dart';
import 'package:ticketzone/presentation/providers/database/db_tickets_bought_provider.dart';
import 'package:ticketzone/presentation/providers/helpers_providers.dart';

Widget barcodePreview( List<DbTicketsBoughtEntity> tickets,List<DbUserEntity> users,WidgetRef ref,
BuildContext context) {
  final value = ref.watch(barCodeProvider);
  final loading = ref.watch(loadingProvider);
  popScannerScreen()=> context.pop();

  verifiedMessage() => ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: const Text('Ticket verified successfully!',
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  duration: const Duration(seconds: 3),),);

  if (value == null) {
      return const Text('Scan something!',overflow: TextOverflow.fade,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);
  }
    
  final ticketsByUser =tickets.where((ticket) =>ticket.userId ==users.
  firstWhere((user) => user.id == ticket.userId).id,).toList();
  
  final ticketsId =ticketsByUser.where((ticket) => ticket.verified != 'verified').toList();
  final ticketsVerified =ticketsByUser.where((ticket) => ticket.verified == 'verified').toList();

  if ((ticketsVerified.map((ticket) => ticket.ticketId).contains(value.rawValue)) && !loading) {
      return const Text('This ticket was already used',
      style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,));
  }

  if (!ticketsId.map((ticket) => ticket.ticketId).contains(value.rawValue) && !loading) {
      return const Text('This ticket is not part of our events.',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);
      
  }

  return FilledButton(
    onPressed: () async {
        final ticketToUpadte = ticketsId.firstWhere((ticket) => ticket.ticketId == value.rawValue,);
        ticketToUpadte.verified = 'verified';
        await ref.read(updateTicketBoughtProvider.notifier).updateTicket(ticketToUpadte);
        isLoading(ref: ref);
        await Future.delayed(const Duration(seconds: 1));
        verifiedMessage();
        isNotLoading(ref: ref);
        popScannerScreen();
      },
      child: const Text('Verified Ticket'),
    );
}


        