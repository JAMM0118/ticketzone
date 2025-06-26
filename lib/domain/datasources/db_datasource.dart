import 'package:ticketzone/domain/entities/db_tickets_bought_entity.dart';
import 'package:ticketzone/domain/entities/db_user_entity.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';

abstract class DbDataSource {
  Future<List<DbTicketsBoughtEntity>> getTicketsBought();
  Future<void> addTicket(EventEntity event);
  Future<DbUserEntity> getUserToLogin(DbUserEntity user);
  Future<void> registerUser(DbUserEntity user);
}