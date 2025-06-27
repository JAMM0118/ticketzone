
import 'package:ticketzone/domain/datasources/event_datasource.dart';
import 'package:ticketzone/domain/entities/categories_entity.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';
import 'package:ticketzone/domain/repositories/event_repository.dart';

class EventRepositoyImpl  implements EventRepository{
 
  final EventDataSource eventDataSource;
  
  EventRepositoyImpl({required this.eventDataSource});
 
  @override
  Future<List<EventEntity>> getEvents({int page = 0 , int limit= 10}) async {
    return eventDataSource.getEvents(page: page, limit: limit);
  }
  
  @override
  Future<EventEntity> getEventById(String id) {
    return eventDataSource.getEventById(id);
  }
  
  @override
  Future<List<EventEntity>> searchEvents(String query) {
    return eventDataSource.searchEvents(query);
  }

  @override
  Future<List<EventEntity>> getEventsByCategory({required String genreId, int page = 0, int limit = 10}) {
    return eventDataSource.getEventsByCategory(genreId: genreId, page: page, limit: limit);
  }

  @override
  Future<List<CategoriesEntity>> loadCategories() {
    return eventDataSource.loadCategories();
  }  
}
