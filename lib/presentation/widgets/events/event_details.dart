import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';
import 'package:ticketzone/presentation/widgets/events/event_specific_info.dart';
import 'package:ticketzone/presentation/widgets/events/event_sales_info.dart';

class EventDetails extends StatelessWidget {
  final EventEntity event;
  const EventDetails({required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FadeInUp(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    children: [
                      Image.network(event.imageUrl, width: size.width * 0.35),
                      const SizedBox(height: 10),
                      event.isOnSale
                          ? EventSalesInfo(
                            size: size,
                            title: "OnSale",
                            startDate: event.startDateSale,
                            endDate: event.endDateSale,
                            color: Colors.green,
                            colorDates: Colors.white,
                          ): const SizedBox(),
                      const SizedBox(height: 10),
                      event.isPreSale
                          ? EventSalesInfo(
                            size: size,
                            title: "PreSale",
                            startDate: event.startDatePreSale,
                            endDate: event.endDatePreSale,
                            color: Colors.yellow,
                            colorDates: Colors.black,
                          ): const SizedBox(),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: (size.width - 55) * 0.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(event.description, maxLines: 5,overflow: TextOverflow.ellipsis,),
                      const SizedBox(height: 10),
                      EventSpecificInfo(title: "Date", subtitle: event.startDate),
                      const SizedBox(height: 5),
                      EventSpecificInfo(title: "Time", subtitle: event.startTime),
                      const SizedBox(height: 5),
                      EventSpecificInfo(title: "Location", subtitle: event.location),
                      const SizedBox(height: 5),
                      EventSpecificInfo(title: "City", subtitle: event.city),
                      const SizedBox(height: 5),
                      EventSpecificInfo(title: "Country", subtitle: event.country),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Chip(
              label: Text("${event.segment}  - ${event.genre} "),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}