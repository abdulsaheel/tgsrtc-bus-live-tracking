import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/config/app_config.dart';
import '../../../core/prefs/app_prefs.dart';
import '../../../data/models/bus_service.dart';
import '../../../data/models/bus_trip.dart';
import '../../../data/models/city.dart';
import '../../../data/models/live_data.dart';
import '../../../data/models/planned_trip.dart';
import '../../../data/models/service_category.dart';
import '../../../data/models/stop.dart';
import '../../../data/models/trip_detail.dart';
import '../../../data/models/vehicle.dart';
import '../../../data/repositories/location_service.dart';
import '../../../data/repositories/transit_repository.dart';
import 'journey_controller.dart';

/// All cities (cached in repo).
final citiesProvider = FutureProvider<List<City>>(
  (ref) => ref.watch(transitRepositoryProvider).cities(),
);

/// Currently selected city. Null until resolved (persisted → detected → prompt).
final selectedCityProvider = StateProvider<City?>((ref) => null);

/// Currently selected service category (City / District / Airport).
/// City is the default — users expect their own city's buses first.
final selectedCategoryProvider =
    StateProvider<ServiceCategory>((ref) => ServiceCategory.city);

/// True while we're actively GPS-detecting the city.
final cityDetectingProvider = StateProvider<bool>((ref) => false);

/// Resolves the initial city ONCE on launch:
/// 1) last persisted city (if still served), else
/// 2) GPS auto-detect (if enabled), persisting the result, else
/// 3) leave null → the UI prompts the user to pick.
/// Returns the resolved city (or null if the user must choose).
final cityInitProvider = FutureProvider<City?>((ref) async {
  final cities = await ref.watch(citiesProvider.future);
  final prefs = ref.watch(appPrefsProvider);

  City? resolved;

  // 1) Persisted choice.
  final savedId = prefs.cityId;
  if (savedId != null) {
    resolved = cities.where((c) => c.id == savedId).firstOrNull;
  }

  // 2) Auto-detect on first launch.
  if (resolved == null && prefs.autoDetect) {
    ref.read(cityDetectingProvider.notifier).state = true;
    try {
      resolved = await ref.read(locationServiceProvider).detectCity();
      if (resolved != null) await prefs.setCity(resolved.id, resolved.name);
    } finally {
      ref.read(cityDetectingProvider.notifier).state = false;
    }
  }

  if (resolved != null) {
    ref.read(selectedCityProvider.notifier).state = resolved;
  }
  return resolved; // null → prompt to choose
});

/// Persist + set the selected city (used by the picker and Settings).
Future<void> chooseCity(WidgetRef ref, City city) async {
  await ref.read(appPrefsProvider).setCity(city.id, city.name);
  ref.read(selectedCityProvider.notifier).state = city;
}

/// All routes for the selected category. Listed by default; the UI filters
/// this client-side via search.
/// - City/Airport: scoped to the selected city (operationType=2).
/// - District: statewide intercity list (no city filter).
final cityRoutesProvider = FutureProvider.autoDispose<List<BusService>>((ref) {
  final cat = ref.watch(selectedCategoryProvider);
  final api = ref.watch(transitRepositoryProvider).api;

  if (!cat.cityScoped) {
    return api.distinctServices(); // statewide district services
  }

  final city = ref.watch(selectedCityProvider);
  if (city == null) return Future.value(const []);
  return api.cityRoutes(
    cityId: city.id,
    operationType: cat.operationType,
    isAirport: cat.isAirport,
  );
});

/// Live buses for a tapped service.
/// - City/Airport: the `/trips/routeNumber` endpoint filters server-side by
///   routeNumber + cityId (operationType=2).
/// - District: those services have NO routeNumber, and the endpoint can't
///   filter intercity services — operationType=2 returns 400 ("please enter
///   cityId") and operationType=1 ignores the filter, returning ALL live
///   intercity trips. So we fetch the statewide op=1 list and match
///   client-side by serviceName (== the district service's `name`).
final routeSearchProvider = FutureProvider.autoDispose
    .family<List<BusTrip>, String>((ref, query) async {
  final city = ref.watch(selectedCityProvider);
  final cat = ref.watch(selectedCategoryProvider);
  final api = ref.watch(transitRepositoryProvider).api;

  final q = query.trim();
  if (q.isEmpty) return const [];

  if (!cat.cityScoped) {
    // District / statewide: fetch all live intercity trips, filter by name.
    final all = await api.searchByRoute(routeNumber: q, operationType: 1);
    return all.where((t) => t.serviceName == q).toList();
  }

  if (city == null) return const [];
  return api.searchByRoute(
        routeNumber: q,
        cityId: city.id,
        operationType: cat.operationType,
        isAirport: cat.isAirport,
      );
});

/// Single live-data source shared by the live screen, the PiP, and the iOS
/// Live Activity. If [vehicleId] is the bus currently being FOLLOWED, the
/// foreground-service isolate is already polling it — reuse that snapshot
/// (zero extra network). Otherwise (just browsing a bus) run our own poll.
final sharedLiveProvider =
    Provider.autoDispose.family<AsyncValue<LiveData>, int>((ref, vehicleId) {
  final j = ref.watch(journeyControllerProvider);
  if (j.vehicleId == vehicleId && j.live != null) {
    return AsyncData(j.live!);
  }
  return ref.watch(liveVehicleProvider(vehicleId));
});

/// Stops for the District from→to picker: ALL op=1 stops (both `place`
/// destinations like "X (ALL)" AND `stage` stops like "MIYAPUR X Road") for the
/// selected city — matching the official app's getAllStops(op=1, cityId). Each
/// stop carries its own geozoneType, used verbatim in the search. Falls back to
/// Hyderabad (richest network) when no city is selected.
final districtStopsProvider = FutureProvider.autoDispose<List<Stop>>((ref) async {
  final api = ref.watch(transitRepositoryProvider).api;
  // Official app: getAllStops(operationType=1, cityId="") — statewide.
  var stops = await api.stops(cityId: '', operationType: 1, isAirport: false);
  if (stops.isEmpty) {
    // Defensive fallback: a hub city's op=1 list still carries the global
    // "place" destinations if the empty-cityId call ever returns nothing.
    final cities = await ref.watch(citiesProvider.future);
    final hub = cities.firstWhere(
      (c) => c.name.toUpperCase().contains('HYDERABAD'),
      orElse: () => cities.first,
    );
    stops = await api.stops(cityId: hub.id, operationType: 1, isAirport: false);
  }
  // Places (intercity destinations) first, then stages; alpha within each.
  stops.sort((a, b) {
    final pa = (a.geozoneType ?? '') == 'place' ? 0 : 1;
    final pb = (b.geozoneType ?? '') == 'place' ? 0 : 1;
    return pa != pb ? pa - pb : a.name.compareTo(b.name);
  });
  return stops;
});

/// City stage stops (for the City "between stops" picker) in the selected city.
final cityStageStopsProvider = FutureProvider.autoDispose<List<Stop>>((ref) async {
  final city = ref.watch(selectedCityProvider);
  if (city == null) return const [];
  final cat = ref.watch(selectedCategoryProvider);
  final stops = await ref
      .watch(transitRepositoryProvider)
      .api
      .stops(cityId: city.id, operationType: cat.operationType, isAirport: cat.isAirport);
  return stops.where((s) => (s.geozoneType ?? 'stage') == 'stage').toList()
    ..sort((a, b) => a.name.compareTo(b.name));
});

/// The user's last-known location (lat, lng) as strings — passed to the
/// between search exactly like the official app (MyLocLat / MyLocLng). Fast,
/// non-blocking; null if unavailable.
final userLatLngProvider =
    FutureProvider.autoDispose<(String, String)?>((ref) async {
  try {
    final pos = await Geolocator.getLastKnownPosition();
    if (pos == null) return null;
    return (pos.latitude.toString(), pos.longitude.toString());
  } catch (_) {
    return null;
  }
});

/// from→to buses running RIGHT NOW — the EXACT official call (v3
/// getnewBusesList: cityId + user lat/lng + each stop's geozoneType).
/// Key = (fromId, toId, fromGeozone, toGeozone, op).
final betweenLiveProvider = FutureProvider.autoDispose
    .family<List<BusTrip>, (String, String, String, String, int)>((ref, k) async {
  final loc = await ref.watch(userLatLngProvider.future);
  // EXACTLY like the official app: District (op=1) sends cityId="" (statewide);
  // City (op=2) sends the selected city's id.
  final cityId = k.$5 == 1 ? '' : (ref.watch(selectedCityProvider)?.id ?? '');
  final resp = await ref.watch(transitRepositoryProvider).api.searchBetween(
        fromId: k.$1,
        toId: k.$2,
        fromGeozoneType: k.$3,
        toGeozoneType: k.$4,
        operationType: k.$5,
        cityId: cityId,
        latitude: loc?.$1,
        longitude: loc?.$2,
        serviceType: '',
      );
  return resp.trips;
});

/// from→to SCHEDULED timetable — official getnewPlannedtripList: cityId per
/// category, NO startTime/endTime (the app passes null). Loaded on demand.
final betweenPlannedProvider = FutureProvider.autoDispose
    .family<List<PlannedTrip>, (String, String, String, String, int)>((ref, k) {
  final cityId = k.$5 == 1 ? '' : (ref.watch(selectedCityProvider)?.id ?? '');
  return ref.watch(transitRepositoryProvider).api.plannedBetween(
        fromId: k.$1,
        toId: k.$2,
        fromGeozoneType: k.$3,
        toGeozoneType: k.$4,
        operationType: k.$5,
        cityId: cityId,
        serviceType: '',
      );
});

/// All bus (vehicle) numbers for the selected city + category — "by bus number".
final busNumbersProvider = FutureProvider.autoDispose<List<Vehicle>>((ref) async {
  final city = ref.watch(selectedCityProvider);
  if (city == null) return const [];
  final cat = ref.watch(selectedCategoryProvider);
  return ref
      .watch(transitRepositoryProvider)
      .api
      .busNumbers(cityId: city.id, operationType: cat.operationType, isAirport: cat.isAirport);
});

/// Trips of a service (by serviceId) — after picking a service/reservation no.
final tripsByServiceProvider =
    FutureProvider.autoDispose.family<List<BusTrip>, int>((ref, serviceId) {
  final cat = ref.watch(selectedCategoryProvider);
  return ref.watch(transitRepositoryProvider).api.tripsByServiceId(serviceId,
      operationType: cat.operationType,
      routeType: cat.operationType == 1 ? '1' : '2');
});

/// Per-stop punctuality (last recorded run's actual arrival time) for a
/// service, keyed by (serviceId, anyPointId, operationType). Returns a map of
/// pointId → actual entryTime (epoch s). Empty/absent when the service has no
/// history — callers must handle that gracefully (just don't show a time).
final punctualityProvider = FutureProvider.autoDispose
    .family<Map<int, int>, (int, int, int)>((ref, k) async {
  try {
    final resp = await ref.watch(transitRepositoryProvider).api.punctuality(
        k.$1, pointId: k.$2, operationType: k.$3);
    return {
      for (final p in resp.points)
        if ((p.entryTime ?? 0) > 0) p.id: p.entryTime!,
    };
  } catch (_) {
    return const {};
  }
});

/// Full trip detail (stops + road polyline) for drawing the route on the map.
final tripDetailProvider =
    FutureProvider.autoDispose.family<TripDetail, int>((ref, tripId) {
  return ref.watch(transitRepositoryProvider).api.tripDetail(tripId);
});

/// Live GPS position of a vehicle, re-polled every [AppConfig.livePollInterval].
/// Emits a stream so the UI can show smooth updates + "updated Xs ago".
final liveVehicleProvider =
    StreamProvider.autoDispose.family<LiveData, int>((ref, vehicleId) async* {
  final repo = ref.watch(transitRepositoryProvider);

  Future<LiveData> fetch() => repo.liveVehicle(vehicleId);

  // Emit immediately, then on each interval. Keep last value on transient error
  // so the map shows last-known position instead of going blank.
  LiveData? last;
  while (true) {
    try {
      last = await fetch();
      yield last;
    } catch (e) {
      if (last != null) {
        yield last; // hold last-known
      } else {
        rethrow; // first load failed → surface error state
      }
    }
    await Future<void>.delayed(AppConfig.livePollInterval);
  }
});
