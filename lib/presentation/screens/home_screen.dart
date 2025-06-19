import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/presentation/providers/providers.dart';
import 'package:ticketzone/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomAppbar(),
        forceMaterialTransparency: true,
        elevation: 0,
      ),
      body: _HomeView(),
      bottomNavigationBar: const CustomBottomNavigation(),
      );
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
    final initialLoading = ref.watch(initialLoadingProvider);
    final getEvents = ref.watch(getEventsProvider);

    return Visibility(
      visible: !initialLoading,
      replacement: FullScreenLoader(),
      child: EventMasonry(
        events: getEvents,
        loadNextPage: (){
          ref.read(getEventsProvider.notifier).loadNextPage();
        },
        ),
    );
  }
}
