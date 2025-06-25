import 'package:ticketzone/domain/entities/db_tickets_bought_entity.dart';

abstract class DbDataSource {
  Future<List<DbTicketsBoughtEntity>> getTicketsBought();
}