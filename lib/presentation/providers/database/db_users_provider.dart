import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/domain/entities/db_user_entity.dart';
import 'package:ticketzone/presentation/providers/database/db_repository_provider.dart';

final getAllUsersProvider = StateNotifierProvider<AllUsersNotifier, List<DbUserEntity>>((ref){
  final fetchAllUsers = ref.watch(dbRepositoryProvider).loadAllUsers;
  
  return AllUsersNotifier(
    fetchAllUsers: fetchAllUsers,
  );
});

typedef AllUsersCallBack = Future<List<DbUserEntity>> Function();

class AllUsersNotifier extends StateNotifier<List<DbUserEntity>> {
  bool isLoading = false;
  final AllUsersCallBack fetchAllUsers;

  AllUsersNotifier({required this.fetchAllUsers}) : super([]);

  Future<void> loadAllUsers() async{
    if (isLoading) return;
    isLoading = true;
    
    final List<DbUserEntity> allUsers = await fetchAllUsers();
    state = allUsers;
    isLoading = false;
  }
}
