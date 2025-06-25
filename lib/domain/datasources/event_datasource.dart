import 'package:ticketzone/domain/entities/event_entity.dart';

abstract class EventDataSource {
  Future<List<EventEntity>> getEvents({int page = 0, int limit = 10});
  Future<EventEntity> getEventById(String id);
  Future<List<EventEntity>> searchEvents(String query);
  //Future<List<EventEntity>> getEventsByCategory(String categoryId, {int page = 0, int limit = 10});

}