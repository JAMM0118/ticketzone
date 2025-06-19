

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
  final String description;
  final String city;
  final String country;
  final bool isPreSale;
  final bool isOnSale;
    

  EventModel(  {
    required this.isPreSale,
    required this.isOnSale,
    required this.description,
    required this.startDatePreSale,
    required this.endDatePreSale,
    required this.genre,
    required this.startDateSale,
    required this.endDateSale,
    required this.startTime,
    required this.imageUrl,
    required this.id,
    required this.city,
    required this.country,
    required this.name,
    required this.segment,
    required this.startDate,
    required this.location,
  });


  factory EventModel.fromJson(Map<String, dynamic> json) =>
  EventModel(
    description: json['info'] ?? 'Sin descripción',
      id: json['id'],
      name: json['name'],
      segment: json['classifications'] != null
          ? json['classifications'][0]['segment']['name'] : 'Sin segmento',
      genre:  json['classifications'][0]['genre']['name'] ?? 'Sin género',
      startDate: json['dates']['start']['localDate'] ?? 'Sin fecha',
      city: json['_embedded']['venues'][0]['city']['name'] ?? 'Sin ciudad',
      country: json['_embedded']['venues'][0]['country']['name'] ?? 'Sin país',
      location: json['_embedded']['venues'][0]['name'] ?? 'Sin ubicación',
      imageUrl: json['images'][0]['url'] ?? 'https://th.bing.com/th/id/OIP.4tyogNao9BwGLjbwnePUmAHaHa?r=0&rs=1&pid=ImgDetMain',
      startTime: json['dates']['start']['localTime'] ?? 'Sin hora',
      startDateSale: json['sales']['public']['startDateTime'] ?? 'Sin fecha',
      endDateSale: json['sales']['public']['endDateTime'] ?? 'Sin fecha',
      startDatePreSale: json['sales']['presales'] != null
          ? json['sales']['presales'][0]['startDateTime'] : 'Sin fecha',
      endDatePreSale: json['sales']['presales'] != null
          ? json['sales']['presales'][0]['endDateTime'] : 'Sin fecha',
      isPreSale: json['sales']['presales'] != null ? true : false,
      isOnSale: (json['sales']['public']['startDateTime'] != null && json['sales']['public']['endDateTime'] != null)
      ? true : false,
    );


  EventEntity toEventEntity() => EventEntity(
      id: id,
      description: description,
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
      city: city,
      country: country,
      isPreSale: isPreSale,
      isOnSale: isOnSale,
      
    );
   
  
}