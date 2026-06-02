import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/models/stop.dart';
import '../../../data/repositories/location_service.dart';
import '../../../data/repositories/transit_repository.dart';

/// Current device position (null if permission denied / GPS off).
final currentPositionProvider = FutureProvider<Position?>(
  (ref) => ref.watch(locationServiceProvider).currentPosition(),
);

/// LatLng convenience for the map.
final currentLatLngProvider = Provider<LatLng?>((ref) {
  final pos = ref.watch(currentPositionProvider).asData?.value;
  return pos == null ? null : LatLng(pos.latitude, pos.longitude);
});

/// Nearby stops for the current position, sorted by distance.
final nearbyStopsProvider = FutureProvider<List<NearbyStop>>((ref) async {
  final pos = await ref.watch(currentPositionProvider.future);
  if (pos == null) return const [];
  final stops = await ref.watch(transitRepositoryProvider).api.nearbyStops(
        latitude: pos.latitude,
        longitude: pos.longitude,
        maxDistance: 3000,
        limit: 40,
      );
  stops.sort((a, b) => (a.distance ?? 1e9).compareTo(b.distance ?? 1e9));
  return stops;
});
