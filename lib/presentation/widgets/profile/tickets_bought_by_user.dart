import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketzone/domain/entities/db_tickets_bought_entity.dart';
import 'package:ticketzone/domain/entities/db_user_entity.dart';

class TicketsBoughtByUser extends StatelessWidget {
  final List<DbTicketsBoughtEntity> ticketsBought;
  final DbUserEntity userInSession;

  const TicketsBoughtByUser({
    super.key,
    required this.ticketsBought,
    required this.userInSession,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: ticketsBought.map((e) => e.userId).contains(userInSession.id),
      replacement: const Center( child: Text( 'No tickets bought yet',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,),),),
      child: Column(
        children: [
          Text('Tickets Bought',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,),),
          SizedBox(height: 20),
          Container(
            height: 270,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ticketsBought.length,
                  itemBuilder: (context, index) {
                    if (ticketsBought[index].userId != userInSession.id) return const SizedBox.shrink();
                  
                    return GestureDetector(
                      onTap:() => context.push('/event/${ticketsBought[index].ticketId}',),
                      child: FadeInRight(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: 120,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.network( ticketsBought[index].imageUrl,height: 170,fit: BoxFit.cover,
                                  loadingBuilder: (context,child,loadingProgress,) {
                                    if (loadingProgress == null) return child;
                                    return Center(child: CircularProgressIndicator(strokeWidth: 2,),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(ticketsBought[index].name,textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white,),
                              overflow: TextOverflow.visible,),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
