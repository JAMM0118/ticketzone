import 'package:ticketzone/domain/datasources/event_datasource.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';
import 'package:ticketzone/infrastructure/models/event_model.dart';
import 'package:ticketzone/shared/data/api_events.dart';


class EventDataSourceImpl implements EventDataSource{
  @override
  Future<List<EventEntity>> getEvents({int page = 0, int limit = 10})  async{
    final apiEvents = await ApiEvents().getApiEvents(page: page, limit: limit);

    final List<EventEntity> newEvents = apiEvents.map(
      (event) => EventModel.fromJson(event).toEventEntity()
    ).toList();
    
    return newEvents;
  }
  
  @override
  Future<EventEntity> getEventById(String id) async{
    final apiEvent = await ApiEvents().getEventById(id);
    final EventEntity event = EventModel.fromJson(apiEvent).toEventEntity(); 
    return event;
  }

}