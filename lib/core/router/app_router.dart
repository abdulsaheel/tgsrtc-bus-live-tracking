import 'package:go_router/go_router.dart';

import '../../features/journey/presentation/journey_screen.dart';
import '../../features/nearby/presentation/nearby_screen.dart';
import '../../features/track/presentation/live_map_screen.dart';
import '../../features/track/presentation/track_screen.dart';
import '../widgets/app_shell.dart';

/// go_router config. Named routes per ui-ux-pro-max Flutter guidance.
final appRouter = GoRouter(
  initialLocation: '/track',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => AppShell(shell: shell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/track',
            name: 'track',
            builder: (_, _) => const TrackScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/nearby',
            name: 'nearby',
            builder: (_, _) => const NearbyScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/plan',
            name: 'plan',
            builder: (_, _) => const JourneyScreen(),
          ),
        ]),
      ],
    ),
    // Journey planner (full-screen push).
    GoRoute(
      path: '/journey',
      name: 'journey',
      builder: (context, state) =>
          JourneyScreen(fromSeed: state.uri.queryParameters['from']),
    ),
    // Live map is a full-screen push (outside the shell).
    GoRoute(
      path: '/live/:vehicleId',
      name: 'live',
      builder: (context, state) => LiveMapScreen(
        vehicleId: int.parse(state.pathParameters['vehicleId']!),
        title: state.uri.queryParameters['title'] ?? 'Live bus',
        tripId: int.tryParse(state.uri.queryParameters['tripId'] ?? ''),
      ),
    ),
  ],
);
