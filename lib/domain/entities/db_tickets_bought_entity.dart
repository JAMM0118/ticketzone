class DbTicketsBoughtEntity {
  final String ticketId;
  final String imageUrl;
  final String name;
  final String startDate;
  final String startTime;

  DbTicketsBoughtEntity({
    required this.startTime,
    required this.ticketId,
    required this.imageUrl,
    required this.name,
    required this.startDate,
  });
}