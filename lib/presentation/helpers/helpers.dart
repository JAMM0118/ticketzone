import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/domain/entities/db_tickets_bought_entity.dart';
import 'package:ticketzone/domain/entities/event_entity.dart';
import 'package:ticketzone/presentation/providers/events/events_by_category_provider.dart';
import 'package:ticketzone/presentation/widgets/events/event_masonry.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/providers.dart';

void verifiedFormLogin({required WidgetRef ref}) async {
  await ref.read(loginFormProvider.notifier).onFormSubmit();
}

void verifiedFormRegister({required WidgetRef ref}) async {
  await ref.read(registerFormProvider.notifier).onFormSubmit();
}

void isLoading({required WidgetRef ref}) {
  ref.read(loadingProvider.notifier).update((state) => true);
}

void loadingLogin( {required WidgetRef ref,String go = '',}) async {
  final loginForm = ref.watch(loginFormProvider);
  
  isLoading(ref: ref);
  ref.read(userEmailProvider.notifier).update((state) => loginForm.email.value);
  
  if (go.isNotEmpty) await ref.read(getUserByEmailProvider.notifier).getUserByEmail(ref.watch(userEmailProvider));
}

void isNotLoading({required WidgetRef ref}) {
  ref.read(loadingProvider.notifier).update((state) => false);
}

Widget showFilter({required String filterActive, required List<EventEntity> getEventsByCategory, required WidgetRef ref}) {
      if (getEventsByCategory.isEmpty) {
        searchEventByCategory(ref: ref, filterActive: filterActive);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            const SizedBox(height: 10),
            Text('Loading events filtered...', style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),)
          ],
        );
      }
      return EventMasonry(
      events: getEventsByCategory,
      loadNextPage: () => ref.read(getEventsByCategoryProvider.notifier).loadNextPageEventsByCategory(genreId: filterActive)
      );
    }

void searchEventByCategory({required WidgetRef ref, required String filterActive}) async{
  await ref.read(getEventsByCategoryProvider.notifier).loadNextPageEventsByCategory(genreId: filterActive);
}

void buyTicket({ required String buyUrl, required EventEntity eventEntity, required WidgetRef ref}) async {
    final userId = ref.watch(getUserByEmailProvider);
    isLoading(ref: ref);
    
    await ref.read(insertTicketBoughtProvider.notifier).addTicketBought(eventEntity, userId.id!);
    await ref.read(getTicketsBoughtProvider.notifier).loadTicketsBought();
    
    isNotLoading(ref: ref);
    
    final Uri url = Uri.parse(buyUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir $url';
    }
}

searchLocation(DbTicketsBoughtEntity ticket) async {
  final Uri url = Uri.parse(
    "https://www.google.com/maps/dir/${ticket.country}/'${ticket.latitude},${ticket.longitude}'",
  );
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'No se pudo abrir $url';
  }
}