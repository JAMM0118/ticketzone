import 'package:ticketzone/domain/datasources/db_datasource.dart';
import 'package:ticketzone/domain/entities/db_tickets_bought_entity.dart';
import 'package:ticketzone/domain/repositories/db_repository.dart';

class DbRepositoryImpl  implements DbRepository{
 
  final DbDataSource dbDataSource;
  
  DbRepositoryImpl({required this.dbDataSource});
 
  @override
  Future<List<DbTicketsBoughtEntity>> getTicketsBought() {
    return dbDataSource.getTicketsBought();
  }


}