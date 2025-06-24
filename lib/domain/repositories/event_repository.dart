
import 'package:ticketzone/domain/entities/event_entity.dart';

abstract class EventRepository {
  Future<List<EventEntity>> getEvents({int page = 0, int limit = 10});
  Future<EventEntity> getEventById(String id);
  Future<List<EventEntity>> searchEvents(String query);
}