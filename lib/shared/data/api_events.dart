import 'package:dio/dio.dart';
import 'package:ticketzone/config/environment/environment.dart';

class ApiEvents {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://app.ticketmaster.com/discovery/v2',
    queryParameters: {
      'countryCode': 'US',
      'apikey': Environment.eventsKey,
    }
  ));

  Future<List<dynamic>> getApiEvents({int page = 0, int limit = 10}) async {
    try {
      final response = await dio.get('/events',
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
      final response = await dio.get('/events/$id');
      if (response.statusCode == 200) return response.data;
      throw Exception('Failed to load event by ID');
      
    } catch (e) {
      throw Exception('Failed to load event by ID: $e');
    }
  }
}