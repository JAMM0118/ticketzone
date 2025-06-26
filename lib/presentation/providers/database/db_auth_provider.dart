import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/domain/entities/db_user_entity.dart';
import 'package:ticketzone/presentation/providers/database/db_repository_provider.dart';


final getUserToLoginProvider = StateNotifierProvider<UserNotifier, DbUserEntity>((ref){
  final fetchUser = ref.watch(dbRepositoryProvider).getUserToLogin;
  
  return UserNotifier(
    fetchUser: fetchUser,
  );
});


final registerUserProvider = StateNotifierProvider<UserNotifier, DbUserEntity>((ref){
  final fetchRegisterUser = ref.watch(dbRepositoryProvider).registerUser;
  
  return UserNotifier(
    fetchRegisterUser: fetchRegisterUser
  );
});

typedef UserCallBack = Future<DbUserEntity> Function(DbUserEntity userEntity);
typedef RegisterCallBack = Future<void> Function(DbUserEntity userEntity);

class UserNotifier extends StateNotifier<DbUserEntity> {
  bool isLoading = false;
  final UserCallBack? fetchUser;
  final RegisterCallBack? fetchRegisterUser;

  UserNotifier({this.fetchRegisterUser,this.fetchUser}) : super(DbUserEntity(fullName: '',email: '', password: '',));

  Future<void> login(DbUserEntity userEntity) async{
    if (isLoading) return;
    isLoading = true;
    
    await fetchUser!(userEntity);
    isLoading = false;
  }
  Future<void> registerUser(DbUserEntity eventEntity) async {
    if (isLoading) return;
    isLoading = true;
    
    await fetchRegisterUser!(eventEntity);
    isLoading = false;
  }
}
