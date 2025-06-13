

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  static String eventsKey =  dotenv.env['THE_EVENTS_KEY'] ?? 'No API Key Found';

}
