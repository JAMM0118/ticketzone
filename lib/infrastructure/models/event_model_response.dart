class EventModelResponse {
  EventResponseEmbedded embedded;
  EventResponseLinks links;
  Page page;

  EventModelResponse({
    required this.embedded,
    required this.links,
    required this.page,
  });

}

class EventResponseEmbedded {
  List<Event> events;

  EventResponseEmbedded({
    required this.events,
  });

}

class Event {
  String name;
  String type;
  String id;
  bool test;
  String url;
  String locale;
  List<Image> images;
  Sales sales;
  Dates dates;
  List<Classification> classifications;
  Promoter promoter;
  List<Promoter> promoters;
  String info;
  String pleaseNote;
  Seatmap seatmap;
  Accessibility accessibility;
  TicketLimit ticketLimit;
  AgeRestrictions ageRestrictions;
  Ticketing ticketing;
  EventLinks links;
  EventEmbedded embedded;

  Event({
    required this.name,
    required this.type,
    required this.id,
    required this.test,
    required this.url,
    required this.locale,
    required this.images,
    required this.sales,
    required this.dates,
    required this.classifications,
    required this.promoter,
    required this.promoters,
    required this.info,
    required this.pleaseNote,
    required this.seatmap,
    required this.accessibility,
    required this.ticketLimit,
    required this.ageRestrictions,
    required this.ticketing,
    required this.links,
    required this.embedded,
  });

}

class Accessibility {
  String info;
  int ticketLimit;
  String id;

  Accessibility({
    required this.info,
    required this.ticketLimit,
    required this.id,
  });

}

class AgeRestrictions {
  bool legalAgeEnforced;
  String id;

  AgeRestrictions({
    required this.legalAgeEnforced,
    required this.id,
  });

}

class Classification {
  bool primary;
  Genre segment;
  Genre genre;
  Genre subGenre;
  Genre type;
  Genre subType;
  bool family;

  Classification({
    required this.primary,
    required this.segment,
    required this.genre,
    required this.subGenre,
    required this.type,
    required this.subType,
    required this.family,
  });

}

class Genre {
  String id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

}

class Dates {
  Start start;
  String timezone;
  Status status;
  bool spanMultipleDays;

  Dates({
    required this.start,
    required this.timezone,
    required this.status,
    required this.spanMultipleDays,
  });

}

class Start {
  DateTime localDate;
  String localTime;
  DateTime dateTime;
  bool dateTbd;
  bool dateTba;
  bool timeTba;
  bool noSpecificTime;

  Start({
    required this.localDate,
    required this.localTime,
    required this.dateTime,
    required this.dateTbd,
    required this.dateTba,
    required this.timeTba,
    required this.noSpecificTime,
  });

}

class Status {
  String code;

  Status({
    required this.code,
  });

}

class EventEmbedded {
  List<Venue> venues;
  List<Attraction> attractions;

  EventEmbedded({
    required this.venues,
    required this.attractions,
  });

}

class Attraction {
  String name;
  String type;
  String id;
  bool test;
  String url;
  String locale;
  ExternalLinks externalLinks;
  List<Image> images;
  List<Classification> classifications;
  UpcomingEvents upcomingEvents;
  AttractionLinks links;

  Attraction({
    required this.name,
    required this.type,
    required this.id,
    required this.test,
    required this.url,
    required this.locale,
    required this.externalLinks,
    required this.images,
    required this.classifications,
    required this.upcomingEvents,
    required this.links,
  });

}

class ExternalLinks {
  List<Facebook> twitter;
  List<Facebook> facebook;
  List<Facebook> wiki;
  List<Facebook> instagram;
  List<Facebook> homepage;

  ExternalLinks({
    required this.twitter,
    required this.facebook,
    required this.wiki,
    required this.instagram,
    required this.homepage,
  });

}

class Facebook {
  String url;

  Facebook({
    required this.url,
  });

}

class Image {
  Ratio ratio;
  String url;
  int width;
  int height;
  bool fallback;
  String? attribution;

  Image({
    required this.ratio,
    required this.url,
    required this.width,
    required this.height,
    required this.fallback,
    this.attribution,
  });

}

enum Ratio {
  THE_169,
  THE_32,
  THE_43
}

class AttractionLinks {
  First self;

  AttractionLinks({
    required this.self,
  });

}

class First {
  String href;

  First({
    required this.href,
  });

}

class UpcomingEvents {
  int tmr;
  int ticketmaster;
  int total;
  int filtered;
  int? archtics;

  UpcomingEvents({
    required this.tmr,
    required this.ticketmaster,
    required this.total,
    required this.filtered,
    this.archtics,
  });

}

class Venue {
  String name;
  String type;
  String id;
  bool test;
  String url;
  String locale;
  List<Image> images;
  String postalCode;
  String timezone;
  City city;
  State state;
  Country country;
  Address address;
  Location location;
  List<Genre> markets;
  List<Dma> dmas;
  BoxOfficeInfo boxOfficeInfo;
  String parkingDetail;
  UpcomingEvents upcomingEvents;
  Ada ada;
  AttractionLinks links;

  Venue({
    required this.name,
    required this.type,
    required this.id,
    required this.test,
    required this.url,
    required this.locale,
    required this.images,
    required this.postalCode,
    required this.timezone,
    required this.city,
    required this.state,
    required this.country,
    required this.address,
    required this.location,
    required this.markets,
    required this.dmas,
    required this.boxOfficeInfo,
    required this.parkingDetail,
    required this.upcomingEvents,
    required this.ada,
    required this.links,
  });

}

class Ada {
  String adaPhones;
  String adaCustomCopy;
  String adaHours;

  Ada({
    required this.adaPhones,
    required this.adaCustomCopy,
    required this.adaHours,
  });

}

class Address {
  String line1;

  Address({
    required this.line1,
  });

}

class BoxOfficeInfo {
  String openHoursDetail;

  BoxOfficeInfo({
    required this.openHoursDetail,
  });

}

class City {
  String name;

  City({
    required this.name,
  });

}

class Country {
  String name;
  String countryCode;

  Country({
    required this.name,
    required this.countryCode,
  });

}

class Dma {
  int id;

  Dma({
    required this.id,
  });

}

class Location {
  String longitude;
  String latitude;

  Location({
    required this.longitude,
    required this.latitude,
  });

}

class State {
  String name;
  String stateCode;

  State({
    required this.name,
    required this.stateCode,
  });

}

class EventLinks {
  First self;
  List<First> attractions;
  List<First> venues;

  EventLinks({
    required this.self,
    required this.attractions,
    required this.venues,
  });

}

class Promoter {
  String id;
  String name;
  String description;

  Promoter({
    required this.id,
    required this.name,
    required this.description,
  });

}

class Sales {
  Public public;
  List<Presale> presales;

  Sales({
    required this.public,
    required this.presales,
  });

}

class Presale {
  DateTime startDateTime;
  DateTime endDateTime;
  String name;

  Presale({
    required this.startDateTime,
    required this.endDateTime,
    required this.name,
  });

}

class Public {
  DateTime startDateTime;
  bool startTbd;
  bool startTba;
  DateTime endDateTime;

  Public({
    required this.startDateTime,
    required this.startTbd,
    required this.startTba,
    required this.endDateTime,
  });

}

class Seatmap {
  String staticUrl;
  String id;

  Seatmap({
    required this.staticUrl,
    required this.id,
  });

}

class TicketLimit {
  String info;
  String id;

  TicketLimit({
    required this.info,
    required this.id,
  });

}

class Ticketing {
  AllInclusivePricing safeTix;
  AllInclusivePricing allInclusivePricing;
  String id;

  Ticketing({
    required this.safeTix,
    required this.allInclusivePricing,
    required this.id,
  });

}

class AllInclusivePricing {
  bool enabled;

  AllInclusivePricing({
    required this.enabled,
  });

}

class EventResponseLinks {
  First first;
  First self;
  First next;
  First last;

  EventResponseLinks({
    required this.first,
    required this.self,
    required this.next,
    required this.last,
  });

}

class Page {
  int size;
  int totalElements;
  int totalPages;
  int number;

  Page({
    required this.size,
    required this.totalElements,
    required this.totalPages,
    required this.number,
  });

}
