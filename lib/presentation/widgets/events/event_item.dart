import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';

class EventItem extends StatelessWidget {
  final EventEntity event;
  final Function onEventSelected;
  const EventItem({super.key, required this.event, required this.onEventSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onEventSelected(context, event);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  event.imageUrl,
                  loadingBuilder:(context, child, loadingProgress) => FadeInLeft(child: child),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: size.width * 0.6,
              child: FadeInRight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (event.name.length > 50)
                        ? Text("${event.name.substring(0, 50)}...",style: textStyles.titleMedium)
                        : Text(event.name, style: textStyles.titleMedium),

                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text("Fecha: ",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(event.startDate),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
