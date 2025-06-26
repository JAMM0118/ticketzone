import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'events/events_providers.dart';

final initialLoadingProvider = Provider<bool>((ref){
   final step1 = ref.watch(getEventsProvider).isEmpty;
   if(step1 ) return true;
    
   return false;
});

final loadingProvider = StateProvider<bool>((ref) => false );

