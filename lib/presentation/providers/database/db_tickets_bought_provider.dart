import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/domain/entities/db_tickets_bought_entity.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';
import 'package:ticketzone/presentation/providers/database/db_repository_provider.dart';

final getTicketsBoughtProvider = StateNotifierProvider<TicketsBoughtNotifier, List<DbTicketsBoughtEntity>>((ref){
  final fetchTicketsBought = ref.watch(dbRepositoryProvider).getTicketsBought;
  
  return TicketsBoughtNotifier(
    fetchTicketsBought: fetchTicketsBought,
  );
});

final insertTicketBoughtProvider = StateNotifierProvider<TicketsBoughtNotifier, List<DbTicketsBoughtEntity>>((ref){
  final insertTicketBought = ref.watch(dbRepositoryProvider).addTicket;
  
  return TicketsBoughtNotifier(
    insertTicketBought: insertTicketBought,
  );
});

final  updateTicketBoughtProvider = StateNotifierProvider<TicketsBoughtNotifier, List<DbTicketsBoughtEntity>>((ref){
  final updateTicketBought = ref.watch(dbRepositoryProvider).updateVerifiedTicket;
  
  return TicketsBoughtNotifier(
    updateTicketBought: updateTicketBought,
  );
});

typedef TicketsBoughtCallBack = Future<List<DbTicketsBoughtEntity>> Function();
typedef InsertTicketBoughtCallBack = Future<void> Function(EventEntity eventEntity,int userId);
typedef UpdateTicketBoughtCallBack = Future<void> Function(DbTicketsBoughtEntity ticket);

class TicketsBoughtNotifier extends StateNotifier<List<DbTicketsBoughtEntity>> {
  bool isLoading = false;
  final TicketsBoughtCallBack? fetchTicketsBought;
  final InsertTicketBoughtCallBack? insertTicketBought;
  final UpdateTicketBoughtCallBack? updateTicketBought;

  TicketsBoughtNotifier({this.insertTicketBought, this.fetchTicketsBought,this.updateTicketBought}) : super([]);

  Future<void> loadTicketsBought() async{
    if (isLoading) return;
    isLoading = true;
    
    final List<DbTicketsBoughtEntity> newTicketsBought = await fetchTicketsBought!();
    final existingIds = state.map((e) => e.ticketId).toSet();
    state = [...state, ...newTicketsBought.where((ticket) => !existingIds.contains(ticket.ticketId))];
    isLoading = false;
  }
  Future<void> addTicketBought(EventEntity eventEntity, int userId) async {
    if (isLoading) return;
    isLoading = true;
    
    await insertTicketBought!(eventEntity, userId);
    isLoading = false;
  }

  Future<void> updateTicket(DbTicketsBoughtEntity ticket) async {
    if (isLoading) return;
    isLoading = true;
    
    await updateTicketBought!(ticket);
    isLoading = false;
  }
}
