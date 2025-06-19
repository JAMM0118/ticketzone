import 'package:go_router/go_router.dart';
import 'package:ticketzone/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: '/event/:eventId',
          builder: (context, state) {
            final eventId = state.pathParameters['eventId'];
            return EventScreen(eventId: eventId ?? 'no-id');
          },
        ),
      ],
    ),
  ],
);
