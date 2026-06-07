import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_screen.dart';
import '../../features/journey/presentation/journey_screen.dart';
import '../../features/nearby/presentation/nearby_screen.dart';
import '../../features/track/presentation/airport_screen.dart';
import '../../features/track/presentation/bus_search_screen.dart';
import '../../features/track/presentation/city_screen.dart';
import '../../features/track/presentation/live_map_screen.dart';
import '../../data/models/service_category.dart';

/// Home-grid navigation: a landing [HomeScreen] pushes into dedicated, purpose-
/// built screens (City / District / Airport / Near me / Plan). The live map is
/// a full-screen push; the active-journey PiP floats globally (mounted in the
/// MaterialApp builder).
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', name: 'home', builder: (_, _) => const HomeScreen()),
    GoRoute(path: '/city', name: 'city', builder: (_, _) => const CityScreen()),
    GoRoute(
        path: '/district',
        name: 'district',
        builder: (_, _) => const BusSearchScreen(
              category: ServiceCategory.district,
              title: 'District Buses',
            )),
    GoRoute(
        path: '/airport',
        name: 'airport',
        builder: (_, _) => const AirportScreen()),
    GoRoute(
        path: '/nearby', name: 'nearby', builder: (_, _) => const NearbyScreen()),
    GoRoute(
        path: '/plan', name: 'plan', builder: (_, _) => const JourneyScreen()),
    GoRoute(
      path: '/journey',
      name: 'journey',
      builder: (context, state) =>
          JourneyScreen(fromSeed: state.uri.queryParameters['from']),
    ),
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
