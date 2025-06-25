import 'package:postgres/postgres.dart';
import 'package:ticketzone/config/environment/environment.dart';

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

  Future<Result> ticketsBought() async{
    return await connection().then((conn) { 
      final query = conn.execute('SELECT * FROM ticketsbought');
      return query;
      }
    );
  }
}
