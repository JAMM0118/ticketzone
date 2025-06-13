

import 'package:ticketzone/domain/entities/event_entity.dart';

class EventModel {

  final String id;
  final String name;
  final String segment;
  final String genre;
  final String startDate;
  final String location;
  final String imageUrl;
  final String startTime;
  final String startDateSale;
  final String endDateSale;
  final String startDatePreSale;
  final String endDatePreSale;

  EventModel( {
    required this.startDatePreSale,
    required this.endDatePreSale,
    required this.genre,
    required this.startDateSale,
    required this.endDateSale,
    required this.startTime,
    required this.imageUrl,
    required this.id,
    required this.name,
    required this.segment,
    required this.startDate,
    required this.location,
  });


  factory EventModel.fromJson(Map<String, dynamic> json) =>
  EventModel(
      id: json['id'],
      name: json['name'],
      segment: json['classifications'] != null
          ? json['classifications'][0]['segment']['name'] : 'Sin segmento',
      genre: json['classifications'] != null
          ? json['classifications'][0]['genre']['name'] : 'Sin género',
      startDate: json['dates']['start']['localDate'] ?? 'Sin fecha',
      location: json['locale'],
      imageUrl: json['images'][0]['url'] ?? 'Sin imagen',
      startTime: json['dates']['start']['localTime'] ?? 'Sin hora',
      startDateSale: json['sales']['public']['startDateTime'] ?? 'Sin fecha de venta',
      startDatePreSale: json['sales']['presales'] != null
          ? json['sales']['presales'][0]['startDateTime'] : 'Sin fecha de pre-venta',
      endDateSale: json['sales']['public']['endDateTime'] ?? 'Sin fecha de venta',
      endDatePreSale: json['sales']['presales'] != null
          ? json['sales']['presales'][1]['name'] : 'Sin fecha de pre-venta',
    
    );


  EventEntity toEventEntity() => EventEntity(
      id: id,
      name: name,
      segment: segment,
      startDate: startDate,
      location: location,
      imageUrl: imageUrl,
      startTime: startTime,
      genre: genre,
      startDateSale: startDateSale,
      endDateSale: endDateSale,
      startDatePreSale: startDatePreSale,
      endDatePreSale: endDatePreSale,
    );
   
  
}