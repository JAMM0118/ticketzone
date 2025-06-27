import 'package:postgres/postgres.dart';
import 'package:ticketzone/domain/entities/db_tickets_bought_entity.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';

class DbTicketsBoughtModel {
  final int userId;
  final String ticketId;
  final String imageUrl;
  final String name;
  final String startDate;
  final String startTime;
  final String country;
  final String latitude;
  final String longitude;
  String? verified;
  final int? id;

  DbTicketsBoughtModel({
    this.id,
    required this.userId,
    required this.startTime,
    required this.ticketId,
    required this.imageUrl,
    required this.name,
    required this.startDate,
    required this.country,
    required this.latitude,
    required this.longitude,
    this.verified,
  });

  factory DbTicketsBoughtModel.fromJson(ResultRow result) => DbTicketsBoughtModel(
    id:  result[0] as int ,
    ticketId: result[1] as String ,
    imageUrl: result[2] as String,
    name: result[3] as String,
    startDate: result[4] as String,
    startTime: result[5] as String,
    country: result[6] as String,
    latitude: result[7] as String,
    longitude: result[8] as String,
    userId: result[9] as int,
    verified: result[10] != null ? result[10] as String :'not verified' ,
  );

  factory DbTicketsBoughtModel.fromEventEntity(EventEntity eventEntity,int userId) => DbTicketsBoughtModel(
    userId: userId,
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
    userId: userId,
    verified: verified,
    id: id 
  );
}