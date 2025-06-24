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
  final String buyUrl;

  EventModel({
    required this.isPreSale,
    required this.isOnSale,
    required this.description,
    required this.buyUrl,
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

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    description: json['info'] ?? 'No description available',
    id: json['id'],
    name: json['name'] ?? 'No name',
    segment:
        json['classifications'] != null
            && json['classifications'][0]['segment'] != null &&
                    json['classifications'][0]['segment']['name'] != null
            ? json['classifications'][0]['segment']['name']
            : 'No segment',
    genre:
        json['classifications'] != null &&
                json['classifications'][0]['genre'] != null &&
                json['classifications'][0]['genre']['name'] != null
            ? json['classifications'][0]['genre']['name']
            : 'No genre',
    startDate:
        json['dates'] != null &&
                json['dates']['start'] != null &&
                json['dates']['start']['localDate'] != null
            ? json['dates']['start']['localDate']
            : 'No date',
    city:
        json['_embedded'] != null &&
                json['_embedded']['venues'] != null &&
                json['_embedded']['venues'][0]['city'] != null
            ? json['_embedded']['venues'][0]['city']['name']
            : 'No city',
    country:
        json['_embedded'] != null &&
                json['_embedded']['venues'] != null &&
                json['_embedded']['venues'][0]['country'] != null
            ? json['_embedded']['venues'][0]['country']['name']
            : 'No country',
    location:
        json['_embedded'] != null &&
                json['_embedded']['venues'] != null &&
                json['_embedded']['venues'][0]['name'] != null
            ? json['_embedded']['venues'][0]['name']
            : 'No location',
    imageUrl:
        json['images'] != null && json['images'].isNotEmpty
            ? json['images'][0]['url']
            : 'https://th.bing.com/th/id/OIP.4tyogNao9BwGLjbwnePUmAHaHa?r=0&rs=1&pid=ImgDetMain',
    startTime:
        json['dates'] != null &&
                json['dates']['start'] != null &&
                json['dates']['start']['localTime'] != null
            ? json['dates']['start']['localTime']
            : 'No time',
    startDateSale:
        json['sales'] != null &&
            json['sales']['public'] != null &&
            json['sales']['public']['startDateTime'] != null
            
            ? json['sales']['public']['startDateTime']
            : 'No date',
    endDateSale:
        json['sales'] != null &&
            json['sales']['public'] != null &&
            json['sales']['public']['endDateTime'] != null
            ? json['sales']['public']['endDateTime']
            : 'No date',
    startDatePreSale:
        json['sales'] != null
            ? json['sales']['presales'] != null
                ? json['sales']['presales'][0]['startDateTime']
                : 'No date'
            : 'No date',
    endDatePreSale:
        json['sales'] != null
            ? json['sales']['presales'] != null
                ? json['sales']['presales'][0]['endDateTime']
                : 'No date'
            : 'No date',
    isPreSale:
        json['sales'] != null
            ? json['sales']['presales'] != null
                ? true
                : false
            : false,
    isOnSale:
        json['sales'] != null
            ? (json['sales']['public']['startDateTime'] != null &&
                    json['sales']['public']['endDateTime'] != null)
                ? true
                : false
            : false,
    buyUrl: json['url'] ?? 'No URL available',
  );

  EventEntity toEventEntity() => EventEntity(
    id: id,
    description: description,
    name: name,
    segment: segment,
    startDate: startDate,
    buyUrl: buyUrl,
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