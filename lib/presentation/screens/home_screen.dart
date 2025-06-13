import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/presentation/providers/events_providers.dart';
import 'package:ticketzone/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _HomeView());
  }
}

class _HomeView extends ConsumerStatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(getEventsProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final getEvents = ref.watch(getEventsProvider);
    return Column(
      children: [
        CustomAppbar(),
        Expanded(
          child:
              getEvents.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                    itemCount: getEvents.length,
                    itemBuilder: (context, index) {
                      final event = getEvents[index];
                      return ListTile(
                        title: Text(event.name),
                        subtitle: Text(
                          'Fecha: ${event.startDate} \nHora: ${event.startTime}',
                        ),
                        trailing: Text('${event.segment} - ${event.genre}'),
                        leading: const Icon(Icons.event),
                      );
                    },
                  ),
        ),
      ],
    );
  }
}
