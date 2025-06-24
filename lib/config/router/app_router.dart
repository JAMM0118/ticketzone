import 'package:go_router/go_router.dart';
import 'package:ticketzone/presentation/screens/screens.dart';
import 'package:ticketzone/presentation/views/views.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, child) => HomeScreen(childView: child),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeView(),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tickets',
              builder: (context, state) => const TicketsView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileView(),
            ),
          ],
        ),
      ],
    ),
    
    GoRoute(
      path: '/event/:eventId',
      builder: (context, state) {
        final eventId = state.pathParameters['eventId'];
        return EventScreen(eventId: eventId ?? 'no-id');
      },
    ),

    //ruta login

    // GoRoute(
    //   path: '/',
    //   builder: (context, state) => const HomeScreen(childView: TicketsView(),),
    //
    // ),
  ],
);
