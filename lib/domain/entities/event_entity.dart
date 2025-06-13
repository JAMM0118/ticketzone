class EventEntity {
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

  EventEntity({
    required this.startTime,
    required this.startDatePreSale,
    required this.endDatePreSale,
    required this.startDateSale,
    required this.endDateSale,
    required this.imageUrl,
    required this.id,
    required this.name,
    required this.genre,
    required this.segment,
    required this.startDate,
    required this.location,
  });

}
