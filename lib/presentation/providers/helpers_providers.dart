import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'events/events_provider.dart';

final initialLoadingProvider = Provider<bool>((ref) {
   final step1 = ref.watch(getEventsProvider).isEmpty;
  
   if(step1) return true;
    
   return false;
});

final loadingProvider = StateProvider<bool>((ref) => false );

final userEmailProvider = StateProvider<String>((ref) => '');

final barCodeProvider = StateProvider<Barcode?>((ref) => null);

