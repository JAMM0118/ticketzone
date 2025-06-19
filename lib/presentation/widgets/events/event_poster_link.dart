import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';

class EventPosterLink extends StatelessWidget {
  final EventEntity event;
  const EventPosterLink({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final textStyle = Theme.of(context).textTheme;
     return FadeInUp(
      from: random.nextInt(100) * 80,
      delay: Duration(milliseconds: random.nextInt(450)),
      child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.blue.shade200.withValues(alpha:0.5),
                  ),
                ),
                width: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Banner(
                    message: event.isOnSale ? 'On Sale' : '',
                    location: BannerLocation.topStart,
                    shadow: BoxShadow(
                      color: Colors.black.withValues(alpha: 0),
                    ),
                    color:  event.isOnSale ? Colors.green : Colors.transparent,
                    child: Banner(
                      message: event.isPreSale ? 'On Presale' : '',
                      shadow: BoxShadow(
                        color: Colors.black.withValues(alpha: 0),
                      ),
                      location: BannerLocation.bottomEnd ,
                      color: event.isPreSale ? Colors.redAccent : Colors.transparent,
                      child: GestureDetector(
                        onTap: () =>context.push('/event/${event.id}'),
                        child: Image.network(
                          event.imageUrl,
                          fit: BoxFit.cover,
                          height: 300,
                          width: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(strokeWidth: 2
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 160,

                child: Text(
                  textAlign: TextAlign.center,
                  event.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle.titleSmall    
              )),
            
            ]),
      );
  }
}