import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:ticketzone/presentation/helpers/helpers.dart';
import 'package:ticketzone/presentation/providers/events/categories_provider.dart';
import 'package:ticketzone/presentation/providers/events/events_by_category_provider.dart';
import 'package:ticketzone/presentation/widgets/events/filter_events_by_category.dart';
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
    ref.read(getTicketsBoughtProvider.notifier).loadTicketsBought();
  }

  @override
  Widget build(BuildContext context) {
  
    final initialLoading = ref.watch(initialLoadingProvider);
    final getEvents = ref.watch(getEventsProvider);
    final getEventsByCategory = ref.watch(getEventsByCategoryProvider);
    final userInSession = ref.watch(getUserByEmailProvider);
    final filterActive = ref.watch(categoryProvider);
    final colors = Theme.of(context).colorScheme;
    return Visibility(
      visible: !initialLoading,
      replacement: FullScreenLoader(),
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: CustomAppbar(userName: userInSession.fullName!,),
                  titlePadding: EdgeInsets.zero,),),
              SliverFillViewport(       
                delegate: SliverChildBuilderDelegate((context, index) {
                  return filterActive.isNotEmpty ? showFilter(
                    filterActive: filterActive,
                    ref: ref, 
                    getEventsByCategory: getEventsByCategory)
                  :EventMasonry(
                    events: getEvents,
                    loadNextPage: () =>ref.read(getEventsProvider.notifier).loadNextPage(),
                  );
                }, 
                childCount: 1
                ),
              ),
            ],
          ),

         filterActive.isNotEmpty? Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: colors.primary,width: 1),borderRadius: BorderRadius.circular(18)),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child:  Icon(Icons.arrow_forward_rounded, size: 38, color: colors.primary,),
              onPressed: () async{
                ref.read(categoryProvider.notifier).update((state) => '');
                await ref.read(getEventsByCategoryProvider.notifier).resetCategories();
                await Future.delayed(const Duration(milliseconds: 500));
              }
            ),
          ):Positioned(
            bottom: 20,
            right: 20,
            child: FilterEventsByCategory(colors: colors),
          ),
        ],
      ),
    );
  }
}
