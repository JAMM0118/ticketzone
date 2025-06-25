import 'package:ticketzone/domain/datasources/db_datasource.dart';
import 'package:ticketzone/domain/entities/db_tickets_bought_entity.dart';
import 'package:ticketzone/infrastructure/models/db_tickets_bought_model.dart';
import 'package:ticketzone/shared/data/database.dart';

class DbDatasourceImpl implements DbDataSource{

  @override
  Future<List<DbTicketsBoughtEntity>> getTicketsBought() async{
    final database = await Database().ticketsBought();
    print('Tickets Bought: $database');
    final List<DbTicketsBoughtEntity> tickets = database.map(
      (ticket) => DbTicketsBoughtModel.fromJson(ticket).toDbTicketsBoughtEntity()
    ).toList();

    return tickets;
  }
}