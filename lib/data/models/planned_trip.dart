import 'package:freezed_annotation/freezed_annotation.dart';

import 'bus_trip.dart';

part 'planned_trip.freezed.dart';
part 'planned_trip.g.dart';

/// GET /v3.0/trips/planned → all SCHEDULED services between two stops.
/// Unlike betweenTwoLocations (live only), this returns full coverage, but has
/// no live vehicleId/tripId (it's a timetable entry, not a running trip).
@freezed
abstract class PlannedTrip with _$PlannedTrip {
  const PlannedTrip._();

  const factory PlannedTrip({
    int? serviceId,
    String? serviceName,
    String? serviceType,
    @JsonKey(fromJson: _intOrNull) int? totalStops,
    int? duration,
    @JsonKey(name: 'depot') String? depot,
    TripEndpoint? from,
    TripEndpoint? to,
  }) = _PlannedTrip;

  factory PlannedTrip.fromJson(Map<String, dynamic> json) =>
      _$PlannedTripFromJson(json);

  /// Scheduled trip length in minutes (prefers `duration`, falls back to the
  /// planned-time delta).
  int? get minutes {
    if (duration != null && duration! > 0) return (duration! / 60).round();
    final a = from?.plannedTime, b = to?.plannedTime;
    if (a == null || b == null || b <= a) return null;
    return ((b - a) / 60).round();
  }
}

int? _intOrNull(Object? v) => switch (v) {
      int i => i,
      num n => n.toInt(),
      String s => int.tryParse(s),
      _ => null,
    };
