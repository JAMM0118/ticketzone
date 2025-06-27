import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketzone/presentation/providers/events/categories_provider.dart';

class FilterEventsByCategory extends ConsumerStatefulWidget {
  final ColorScheme colors;
  
  const FilterEventsByCategory({super.key,required this.colors,});

  @override
  FilterEventsByCategoryState createState() => FilterEventsByCategoryState();
}

class FilterEventsByCategoryState extends ConsumerState<FilterEventsByCategory> {

    @override
  void initState() {
    super.initState();
    ref.read(getCategoriesProvider.notifier).loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(getCategoriesProvider);
    final noEmptyCategories = categories.where((category) => category.category.isNotEmpty).toList();
    
    return FloatingActionButton(onPressed: ()=> showDialog(context: context, builder: 
    (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Filter Events By Category', textAlign: TextAlign.center, style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: widget.colors.primary )),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.7,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              content: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.4,
                child: Visibility(
                  visible: categories.isNotEmpty,
                  replacement: const Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text('Loading Categories...'),
                    ],
                  )),
                  child: ListView.builder(
                    itemCount: noEmptyCategories.length,
                    itemBuilder: (context, index) {
                      final category = noEmptyCategories[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        splashColor: Colors.transparent, 
                        subtitle: Divider(color: widget.colors.primary,thickness: 1, ),                       
                        title: Text('${category.category} - ${category.genreName}',  textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                        style:TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold)),
                        onTap: () {
                          ref.read(categoryProvider.notifier).update((state) => category.genreId);
                          context.pop();
                          }  
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }),
    shape: RoundedRectangleBorder(
      side: BorderSide(color: widget.colors.primary,width: 1),
      borderRadius: BorderRadius.circular(18)),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    child: Icon(Icons.view_headline_rounded,size: 38,color: widget.colors.primary,),);
  }
}
