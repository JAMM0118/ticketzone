
import 'package:ticketzone/domain/entities/event_entity.dart';

abstract class EventDataSource {
  Future<List<EventEntity>> getEvents({int page = 0, int limit = 10});
  Future<EventEntity> getEventById(String id);
}