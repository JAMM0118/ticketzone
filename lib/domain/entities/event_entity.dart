class EventEntity {
  final String id;
  final String name;
  final String segment;
  final String description;
  final String genre;
  final String location;
  final String country;
  final String buyUrl;
  final String city;
  final String imageUrl;
  final String startDate;
  final String startTime;
  final String startDateSale;
  final String endDateSale;
  final bool isPreSale;
  final bool isOnSale;
  final String startDatePreSale;
  final String endDatePreSale;
  final String latitude;
  final String longitude;

  EventEntity({
    required this.isPreSale,
    required this.buyUrl,
    required this.isOnSale,
    required this.country,
    required this.city,
    required this.description,
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
    required this.latitude,
    required this.longitude,
  });
}
