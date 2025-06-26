import 'package:go_router/go_router.dart';
import 'package:ticketzone/presentation/screens/scanner_qr_screen/scanner_qr_screen.dart';
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
  
    GoRoute(
      path: '/',
      builder: (context, state) =>const LoginScreen(),
    ),

    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    GoRoute(
      path: '/loginSupervisor',
      builder: (context, state) => const LoginSupervisorScreen(),
    ),

    GoRoute(
      path: '/homeSupervisor',
      builder: (context, state) => const HomeSupervisorScreen(),
    ),

    GoRoute(
      path: '/scannerQR',
      builder: (context, state) => const ScannerQRScreen(),
    ),


  ],
);
