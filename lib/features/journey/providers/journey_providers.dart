import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../data/models/bus_trip.dart';
import '../../../data/models/planned_trip.dart';
import '../../../data/models/stop.dart';
import '../../../data/repositories/transit_repository.dart';
import '../../track/providers/track_providers.dart';

/// Stage stops for the selected city (used as From/To options).
final cityStopsProvider = FutureProvider<List<Stop>>((ref) async {
  final city = ref.watch(selectedCityProvider);
  if (city == null) return const [];
  final stops = await ref.watch(transitRepositoryProvider).api.stops(
        cityId: city.id,
      );
  stops.sort((a, b) => a.name.compareTo(b.name));
  return stops;
});

/// Selected origin / destination stage stops.
final fromStopProvider = StateProvider<Stop?>((ref) => null);
final toStopProvider = StateProvider<Stop?>((ref) => null);

/// A travel option: a scheduled trip, flagged live if a bus is running it now
/// (with the handles needed to open live tracking).
class JourneyOption {
  JourneyOption(this.trip, {this.liveVehicleId, this.liveTripId});
  final PlannedTrip trip;
  final int? liveVehicleId;
  final int? liveTripId;
  bool get isLive => liveVehicleId != null;
}

/// All options between From/To: full SCHEDULE (planned) cross-referenced with
/// buses running RIGHT NOW (betweenTwoLocations) so live ones are trackable.
/// Null until both stops are chosen.
final journeyResultProvider =
    FutureProvider.autoDispose<List<JourneyOption>?>((ref) async {
  final from = ref.watch(fromStopProvider);
  final to = ref.watch(toStopProvider);
  final city = ref.watch(selectedCityProvider);
  if (from == null || to == null || city == null) return null;

  final api = ref.watch(transitRepositoryProvider).api;
  final fromGeo = from.geozoneType ?? 'stage';
  final toGeo = to.geozoneType ?? 'stage';

  // Fetch schedule + live concurrently.
  final results = await Future.wait([
    api.plannedBetween(
      fromId: from.id,
      toId: to.id,
      cityId: city.id,
      fromGeozoneType: fromGeo,
      toGeozoneType: toGeo,
    ),
    api
        .searchBetween(
          fromId: from.id,
          toId: to.id,
          cityId: city.id,
          fromGeozoneType: fromGeo,
          toGeozoneType: toGeo,
        )
        .then((r) => r.trips)
        .catchError((_) => <BusTrip>[]), // live is best-effort
  ]);

  final planned = results[0] as List<PlannedTrip>;
  final live = (results[1] as List).cast<BusTrip>();
  // Map serviceName → live handles for quick lookup.
  final liveByService = {
    for (final t in live)
      if (t.serviceName != null) t.serviceName!.trim(): t,
  };

  final options = [
    for (final p in planned)
      () {
        final l = liveByService[p.serviceName?.trim()];
        return JourneyOption(
          p,
          liveVehicleId: l?.vehicleId,
          liveTripId: l?.id,
        );
      }(),
  ];

  // Live first, then by scheduled departure time.
  options.sort((a, b) {
    if (a.isLive != b.isLive) return a.isLive ? -1 : 1;
    final ta = a.trip.from?.plannedTime ?? 1 << 30;
    final tb = b.trip.from?.plannedTime ?? 1 << 30;
    return ta.compareTo(tb);
  });
  return options;
});
