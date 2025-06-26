import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketzone/presentation/providers/database/db_tickets_bought_provider.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketsBought = ref.watch(getTicketsBoughtProvider);
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
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 240,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        image: DecorationImage(
                          opacity: 0.5,
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/images/profile_background.webp',
                          ),
                        ),
                      ),

                      child: SizedBox(),
                    ),
                    Container(
                      height: 5,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 170),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(
                              'assets/images/profile.png',
                            ),
                          ),
                        ),
                        SizedBox(width: 2),

                        Column(
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'John Doe',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "John.doe@gtu.com",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Tickets Bought',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 270,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: ticketsBought.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap:
                              () => context.push(
                                '/event/${ticketsBought[index].ticketId}',
                              ),
                          child: FadeInRight(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              width: 120,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image.network(
                                      ticketsBought[index].imageUrl,
                                      height: 170,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (
                                        context,
                                        child,
                                        loadingProgress,
                                      ) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    ticketsBought[index].name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () => context.go('/'),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
