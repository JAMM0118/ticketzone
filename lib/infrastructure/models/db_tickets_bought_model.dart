import 'package:postgres/postgres.dart';
import 'package:ticketzone/domain/entities/db_tickets_bought_entity.dart';

class DbTicketsBoughtModel {
  final String ticketId;
  final String imageUrl;
  final String name;
  final String startDate;
  final String startTime;

  DbTicketsBoughtModel({
    required this.startTime,
    required this.ticketId,
    required this.imageUrl,
    required this.name,
    required this.startDate,
  });

  factory DbTicketsBoughtModel.fromJson(ResultRow result) => DbTicketsBoughtModel(
    ticketId: result[1] as String,
    imageUrl: result[2] as String,
    name: result[3] as String,
    startDate: result[4] as String,
    startTime: result[5] as String,
    
  );

  DbTicketsBoughtEntity toDbTicketsBoughtEntity() => DbTicketsBoughtEntity(
    ticketId: ticketId,
    name: name,
    startDate: startDate,
    imageUrl: imageUrl,
    startTime: startTime,
  );
}