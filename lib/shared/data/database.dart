import 'package:postgres/postgres.dart';
import 'package:ticketzone/config/environment/environment.dart';
import 'package:ticketzone/domain/entities/db_tickets_bought_entity.dart';
import 'package:ticketzone/domain/entities/db_user_entity.dart';

class Database {

  Future<Connection> connection() async {
    return await Connection.open(
      Endpoint(
        host: Environment.databaseHost,
        database: Environment.databaseName,
        username: Environment.databaseUser,
        password: Environment.databasePassword,
      ),
    );
  }

  Future<Result> getUser(DbUserEntity user) async{
    return await connection().then((conn) => conn.execute(
      r'SELECT * FROM users WHERE email=($1) AND password=($2);',
      parameters: [user.email, user.password]
    ));
  }

  Future<Result> getUserByEmail(String email) async{
    return await connection().then((conn) => conn.execute(
      r'SELECT * FROM users WHERE email=($1);',
      parameters: [email]
    ));
  }
  
  Future<Result> loadAllUsers() async {
    return await connection().then((conn) => conn.execute('SELECT * FROM users'));
  }

  Future<void> addUser(DbUserEntity user) async {
    await connection().then((conn) => conn.execute(
      r'INSERT INTO users (email,password,name) VALUES ($1,$2,$3)',
      parameters: [
        user.email,
        user.password,
        user.fullName,
      ]   
      )
    );
  }

  Future<Result> ticketsBought() async{
    return await connection().then((conn) => conn.execute('SELECT * FROM ticketsbought'));
  }

  Future<void> updateVerifiedTicket(DbTicketsBoughtEntity ticket) async {
    await connection().then((conn) => conn.execute(
      r'UPDATE ticketsbought SET verified=$1 WHERE id=$2',
      parameters: [ticket.verified, ticket.id]
    ));
  }

  Future<void> addTicket(DbTicketsBoughtEntity ticketBought) async {
    await connection().then((conn) => conn.execute(
      r'INSERT INTO ticketsbought (event_id,image_url,name,start_date,start_time,country,latitude,longitude,user_id) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9)',
      parameters: [
        ticketBought.ticketId,
        ticketBought.imageUrl,
        ticketBought.name,
        ticketBought.startDate,
        ticketBought.startTime,
        ticketBought.country,
        ticketBought.latitude,
        ticketBought.longitude,
        ticketBought.userId,
      ]   
      )
    );
  }
}
