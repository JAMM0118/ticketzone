import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
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
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: CustomAppbar(),
              titlePadding: EdgeInsets.zero,
            ),
          ),
          SliverFillViewport(       
            delegate: SliverChildBuilderDelegate((context, index) {
              return EventMasonry(
                events: getEvents,
                loadNextPage: () {
                  ref.read(getEventsProvider.notifier).loadNextPage();
                },
              );
            }, 
            childCount: 1
            ),
          ),
        ],
      ),
    );
  }
}
