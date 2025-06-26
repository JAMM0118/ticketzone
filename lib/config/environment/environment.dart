import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  static String eventsKey =  dotenv.env['THE_EVENTS_KEY'] ?? 'No API Key Found';
  static String databaseHost = dotenv.env['DATABASE_HOST'] ?? 'No Database Host Found';
  static String databaseName = dotenv.env['DATABASE_NAME'] ?? 'No Database Name Found';
  static String databaseUser = dotenv.env['DATABASE_USER'] ?? 'No Database User Found';
  static String databasePassword = dotenv.env['DATABASE_PASSWORD'] ?? 'No Database Password Found';

}
