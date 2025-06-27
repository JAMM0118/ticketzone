import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/domain/entities/categories_entity.dart';
import 'package:ticketzone/presentation/providers/events/events_repository_provider.dart';

final categoryProvider = StateProvider<String>((ref) => '');

final getCategoriesProvider = StateNotifierProvider<CategoriesNotifier, List<CategoriesEntity>>((ref){
  final fetchCategories = ref.watch(eventsRepositoryProvider).loadCategories;
  
  return CategoriesNotifier(
    fetchCategories: fetchCategories,
  );
});

typedef GetCategoriesCallBack = Future<List<CategoriesEntity>> Function();

class CategoriesNotifier extends StateNotifier<List<CategoriesEntity>> {
  bool isLoading = false;
  final GetCategoriesCallBack fetchCategories;

  CategoriesNotifier({required this.fetchCategories}) : super([]);

  Future<void> loadCategories() async {
    if (isLoading) return;
    isLoading = true;
  
    final List<CategoriesEntity> categories = await fetchCategories();
    state = categories;
    await Future.delayed(const Duration(milliseconds: 500 ));
    isLoading = false;
    
  }
}