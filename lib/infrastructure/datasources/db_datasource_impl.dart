import 'package:ticketzone/domain/datasources/db_datasource.dart';
import 'package:ticketzone/domain/entities/db_tickets_bought_entity.dart';
import 'package:ticketzone/domain/entities/db_user_entity.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';
import 'package:ticketzone/infrastructure/models/db_tickets_bought_model.dart';
import 'package:ticketzone/infrastructure/models/db_user_model.dart';
import 'package:ticketzone/shared/data/database.dart';

class DbDatasourceImpl implements DbDataSource{

  @override
  Future<List<DbTicketsBoughtEntity>> getTicketsBought() async{
    final database = await Database().ticketsBought();
    final List<DbTicketsBoughtEntity> tickets = database.map(
      (ticket) => DbTicketsBoughtModel.fromJson(ticket).toDbTicketsBoughtEntity()
    ).toList();

    return tickets;
  }

  @override
  Future<void> addTicket(EventEntity event) async{
    final ticketModel = DbTicketsBoughtModel.fromEventEntity(event).toDbTicketsBoughtEntity();
    await Database().addTicket(ticketModel);
  }

  @override
  Future<DbUserEntity> getUserToLogin(DbUserEntity userEntity) async {
    final userModel = await Database().getUser(userEntity);
    final DbUserEntity userLogin = DbUserModel.fromJson(userModel.first).toDbUserEntity();
    
    return userLogin;
  }
  
  @override
  Future<void> registerUser(DbUserEntity user) async{
    await Database().addUser(user); 
  }
  
  
}