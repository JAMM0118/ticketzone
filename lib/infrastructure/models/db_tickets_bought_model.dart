import 'package:postgres/postgres.dart';
import 'package:ticketzone/domain/entities/db_tickets_bought_entity.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';

class DbTicketsBoughtModel {
  final String ticketId;
  final String imageUrl;
  final String name;
  final String startDate;
  final String startTime;
  final String country;
  final String latitude;
  final String longitude;

  DbTicketsBoughtModel({
    required this.startTime,
    required this.ticketId,
    required this.imageUrl,
    required this.name,
    required this.startDate,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  factory DbTicketsBoughtModel.fromJson(ResultRow result) => DbTicketsBoughtModel(
    ticketId: result[1] as String ,
    imageUrl: result[2] as String,
    name: result[3] as String,
    startDate: result[4] as String,
    startTime: result[5] as String,
    country: result[6] as String,
    latitude: result[7] as String,
    longitude: result[8] as String,
  );

  factory DbTicketsBoughtModel.fromEventEntity(EventEntity eventEntity) => DbTicketsBoughtModel(
    ticketId: eventEntity.id,
    imageUrl: eventEntity.imageUrl,
    name: eventEntity.name,
    startDate: eventEntity.startDate,
    startTime: eventEntity.startTime,
    country: eventEntity.country,
    latitude: eventEntity.latitude,
    longitude: eventEntity.longitude,
  );

  DbTicketsBoughtEntity toDbTicketsBoughtEntity() => DbTicketsBoughtEntity(
    ticketId: ticketId,
    name: name,
    startDate: startDate,
    imageUrl: imageUrl,
    startTime: startTime,
    country: country,
    latitude: latitude,
    longitude: longitude,
  );

}