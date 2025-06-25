import 'package:dio/dio.dart';
import 'package:ticketzone/config/environment/environment.dart';

class ApiEvents {
  final _dio = Dio(BaseOptions(
    baseUrl: 'https://app.ticketmaster.com/discovery/v2',
    queryParameters: {
      'apikey': Environment.eventsKey,
    }
  ));

  Future<List<dynamic>> getApiEvents({int page = 0, int limit = 10}) async {
    try {
      final response = await _dio.get('/events',
        queryParameters: {
        'page': page,
        'size': limit,
      });
      if (response.statusCode == 200) return response.data['_embedded']['events'];
      throw Exception('Failed to load events');
      
    } catch (e) {
      throw Exception('Failed to load events: $e');
    }
  }

  Future<dynamic> getEventById(String id) async {
    try {
      final response = await _dio.get('/events/$id');
      if (response.statusCode == 200) return response.data;
      throw Exception('Failed to load event by ID');
      
    } catch (e) {
      throw Exception('Failed to load event by ID: $e');
    }
  }

  Future<List<dynamic>> searchEvents(String query) async {
    try {
      final response = await _dio.get('/events',
        queryParameters: {
          'keyword': query,
        });
      if (response.statusCode == 200) {
        return response.data['_embedded'] != null 
        ? response.data['_embedded']['events']  ?? [] : [];}
      throw Exception('Failed to search events');
      
    } catch (e) {
      throw Exception('Failed to search events: $e');
    }
  }
  
}