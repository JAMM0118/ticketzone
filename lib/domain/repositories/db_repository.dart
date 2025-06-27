import 'package:ticketzone/domain/entities/db_tickets_bought_entity.dart';
import 'package:ticketzone/domain/entities/db_user_entity.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';

abstract class DbRepository {
  Future<List<DbTicketsBoughtEntity>> getTicketsBought();
  Future<void> addTicket(EventEntity event,int userId);
  Future<DbUserEntity> getUserToLogin(DbUserEntity user);  
  Future<void> registerUser(DbUserEntity user);
  Future<DbUserEntity> getUserByEmail(String email);
  Future<void> updateVerifiedTicket(DbTicketsBoughtEntity ticket);
  Future<List<DbUserEntity>> loadAllUsers();

}