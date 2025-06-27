class DbTicketsBoughtEntity {
  final int? id;
  final String ticketId;
  final String imageUrl;
  final String name;
  String? verified;
  final String startDate;
  final String startTime;
  final String country;
  final String latitude;
  final String longitude;
  final int userId;

  DbTicketsBoughtEntity({
    this.verified,
    this.id,
    required this.userId,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.startTime,
    required this.ticketId,
    required this.imageUrl,
    required this.name,
    required this.startDate,
  });
}