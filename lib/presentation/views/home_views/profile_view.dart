import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketzone/presentation/providers/database/db_auth_provider.dart';
import 'package:ticketzone/presentation/providers/database/db_tickets_bought_provider.dart';
import 'package:ticketzone/presentation/widgets/profile/profile_photos_style.dart';
import 'package:ticketzone/presentation/widgets/profile/tickets_bought_by_user.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketsBought = ref.watch(getTicketsBoughtProvider);
    final userInSession = ref.watch(getUserByEmailProvider);
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfilePhotosStyle(userInSession: userInSession),
            SizedBox(height: 20),
            TicketsBoughtByUser(ticketsBought: ticketsBought, userInSession: userInSession),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () => context.go('/'),
              child: Text('Logout',style:TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
