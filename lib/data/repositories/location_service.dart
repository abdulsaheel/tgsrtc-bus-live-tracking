import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../models/city.dart';
import 'transit_repository.dart';

final locationServiceProvider = Provider<LocationService>(
  (ref) => LocationService(ref.watch(transitRepositoryProvider)),
);

/// Detects the user's TGSRTC city from GPS.
///
/// Strategy: get a position, ask the API for nearby stops, and read the city id
/// embedded in the nearest stop's `metadata` (values include the city id). Match
/// that against the served-cities list. Data-driven — no hardcoded coordinates.
class LocationService {
  LocationService(this._repo);
  final TransitRepository _repo;

  /// Returns the detected served [City], or null if it can't be determined
  /// (permission denied, GPS off, outside Telangana, etc.). Never throws.
  Future<City?> detectCity() async {
    try {
      final pos = await _currentPosition();
      if (pos == null) return null;

      final cities = await _repo.cities();
      final cityIds = {for (final c in cities) c.id: c};

      final nearby = await _repo.api.nearbyStops(
        latitude: pos.latitude,
        longitude: pos.longitude,
        maxDistance: 5000,
        limit: 5,
      );

      // Scan metadata values of the nearest stops for a known city id.
      for (final stop in nearby) {
        final meta = stop.metadata;
        if (meta != null) {
          for (final v in meta.values) {
            if (v is String && cityIds.containsKey(v)) {
              return cityIds[v];
            }
          }
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Public: current device position, or null if unavailable/denied.
  Future<Position?> currentPosition() => _currentPosition();

  Future<Position?> _currentPosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) return null;
    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }
    if (perm == LocationPermission.denied ||
        perm == LocationPermission.deniedForever) {
      return null;
    }
    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.low),
    );
  }
}
