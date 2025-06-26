import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';
import 'package:ticketzone/presentation/delegates/search_event_delegate.dart';
import 'package:ticketzone/presentation/providers/providers.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar( {super.key,});

  @override
  Widget build(BuildContext context,ref) {

    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: SizedBox(
        width: double.infinity,
        
        child: Row(
          children: [
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 18),
               child: Image.asset(
                'assets/images/logo.png',
                width: 34,
                height: 40,),
             ),
            
            Text(
              'Welcome 🤩',
              style: titleStyle
      
            ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  final searchEvents = ref.read(searchedEventsProvider);
                  final searchQuery = ref.read(searchQueryProvider);
                  showSearch<EventEntity?>(
                    query: searchQuery,
                    context: context, 
                    delegate: SearchEventDelegate(
                      initialEvents: searchEvents,
                      searchEvent: ref.read(searchedEventsProvider.notifier).searchEventByQuery ,
                    )
                  ).then((event) {
                    if (event == null) return;
      
                      context.push('/event/${event.id}');                   
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}