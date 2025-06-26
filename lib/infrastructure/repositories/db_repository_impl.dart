import 'package:ticketzone/domain/datasources/db_datasource.dart';
import 'package:ticketzone/domain/entities/db_tickets_bought_entity.dart';
import 'package:ticketzone/domain/entities/db_user_entity.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';
import 'package:ticketzone/domain/repositories/db_repository.dart';

class DbRepositoryImpl  implements DbRepository{
 
  final DbDataSource dbDataSource;
  
  DbRepositoryImpl({required this.dbDataSource});
 
  @override
  Future<List<DbTicketsBoughtEntity>> getTicketsBought() {
    return dbDataSource.getTicketsBought();
  }

  @override
  Future<void> addTicket(EventEntity event) {
    return dbDataSource.addTicket(event);
  }

  @override
  Future<DbUserEntity> getUserToLogin(DbUserEntity user) {
    return dbDataSource.getUserToLogin(user);
  }
  
  @override
  Future<void> registerUser(DbUserEntity user) {
    return dbDataSource.registerUser(user);
  }
  
  
}