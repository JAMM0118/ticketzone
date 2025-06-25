import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/infrastructure/datasources/event_datasource_impl.dart';
import 'package:ticketzone/infrastructure/repositories/event_repository_impl.dart';

final eventsRepositoryProvider = Provider((ref){

  return EventRepositoyImpl(eventDataSource: EventDataSourceImpl());
});
