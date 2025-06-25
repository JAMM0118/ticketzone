import 'package:ticketzone/domain/entities/db_tickets_bought_entity.dart';

abstract class DbRepository {
  Future<List<DbTicketsBoughtEntity>> getTicketsBought();
}