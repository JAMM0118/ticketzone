import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/domain/entities/db_tickets_bought_entity.dart';
import 'package:ticketzone/presentation/providers/database/db_repository_provider.dart';

final getTicketsBoughtProvider = StateNotifierProvider<TicketsBoughtNotifier, List<DbTicketsBoughtEntity>>((ref){
  final fetchMoreTicketsBought = ref.watch(dbRepositoryProvider).getTicketsBought;
  
  return TicketsBoughtNotifier(
    getTicketsBought: fetchMoreTicketsBought,
  );
});

typedef TicketsBoughtCallBack = Future<List<DbTicketsBoughtEntity>> Function();


class TicketsBoughtNotifier extends StateNotifier<List<DbTicketsBoughtEntity>> {
  bool isLoading = false;
  final TicketsBoughtCallBack getTicketsBought;

  TicketsBoughtNotifier({required this.getTicketsBought}) : super([]);

  Future<void> loadTicketsBought() async{
    if (isLoading) return;
    isLoading = true;
    
    final List<DbTicketsBoughtEntity> newTicketsBought = await getTicketsBought();
    state = [...state, ...newTicketsBought];
    isLoading = false;

  }
}

