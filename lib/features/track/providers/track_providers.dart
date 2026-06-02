import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../core/config/app_config.dart';
import '../../../core/prefs/app_prefs.dart';
import '../../../data/models/bus_service.dart';
import '../../../data/models/bus_trip.dart';
import '../../../data/models/city.dart';
import '../../../data/models/live_data.dart';
import '../../../data/models/service_category.dart';
import '../../../data/models/trip_detail.dart';
import '../../../data/repositories/location_service.dart';
import '../../../data/repositories/transit_repository.dart';

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

/// Search buses by route number within the selected city + category.
/// The category supplies the correct operationType/isAirport — without it,
/// District routes return empty under the default operationType=1.
final routeSearchProvider = FutureProvider.autoDispose
    .family<List<BusTrip>, String>((ref, routeNumber) async {
  final city = ref.watch(selectedCityProvider);
  final cat = ref.watch(selectedCategoryProvider);

  if (routeNumber.trim().isEmpty) return const [];
  if (cat.cityScoped && city == null) return const [];

  return ref.watch(transitRepositoryProvider).api.searchByRoute(
        routeNumber: routeNumber.trim(),
        cityId: cat.cityScoped ? city?.id : null,
        operationType: cat.operationType,
        isAirport: cat.isAirport,
      );
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
