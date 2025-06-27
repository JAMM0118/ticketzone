import 'package:ticketzone/domain/datasources/event_datasource.dart';
import 'package:ticketzone/domain/entities/categories_entity.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';
import 'package:ticketzone/infrastructure/models/categories_model.dart';
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
    final apiEvents = await ApiEvents().getEventById(id);
    final EventEntity event = EventModel.fromJson(apiEvents).toEventEntity(); 
    return event;
  }
  
  @override
  Future<List<EventEntity>> searchEvents(String query) async {
    if (query.isEmpty) return [];
    
    final apiEvents = await ApiEvents().searchEvents(query);
    
    final List<EventEntity> newEvents = apiEvents.map(
      (event) => EventModel.fromJson(event).toEventEntity()
    ).toList();
    
    return newEvents;
  }

  @override
  Future<List<EventEntity>> getEventsByCategory({required String genreId, int page = 0, int limit = 10}) async{
    final apiEvents = await ApiEvents().getEventsByCategory(genreId:genreId, page: page, limit: limit);

    final List<EventEntity> newEventsByCategory = apiEvents.map(
      (event) => EventModel.fromJson(event).toEventEntity()
    ).toList();
    
    return newEventsByCategory;
  }

  @override
  Future<List<CategoriesEntity>> loadCategories() async{
    final apiEvents = await ApiEvents().loadCategories();
    
    final List<CategoriesEntity> categories = [];

    for (dynamic category in apiEvents) {
      if (category['segment'] != null && category['segment']['name'] != 'Undefined') {
        final genres = category['segment']['_embedded']['genres'];
        for (int i = 0; i < genres.length; i++) {
          if(genres[i]['name'] != 'Undefined'){
            categories.add(CategoriesModel.fromJson(category, id: i).toCategoriesEntity());
          }
        }
      }
    }
    return categories;
  }
}
