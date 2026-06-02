import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_trip.freezed.dart';
part 'bus_trip.g.dart';

/// A trip endpoint within a search result (BusModel.From / .To).
@freezed
abstract class TripEndpoint with _$TripEndpoint {
  const TripEndpoint._();

  const factory TripEndpoint({
    int? id,
    String? name,
    int? eta,
    int? etd,
    int? entryTime,
    int? plannedTime,
    int? plannedExitTime,
  }) = _TripEndpoint;

  factory TripEndpoint.fromJson(Map<String, dynamic> json) =>
      _$TripEndpointFromJson(json);

  DateTime? _ts(int? s) =>
      s == null || s == 0 ? null : DateTime.fromMillisecondsSinceEpoch(s * 1000);

  /// Scheduled time at this point.
  DateTime? get plannedAt => _ts(plannedTime);

  /// Live predicted arrival at this point.
  DateTime? get etaAt => _ts(eta);
}

/// GET /v2.0|v3.0/trips/betweenTwoLocations item + /trips/routeNumber item.
/// BusModel (v2) and NewBusModel (v3) share this shape.
@freezed
abstract class BusTrip with _$BusTrip {
  const BusTrip._();

  const factory BusTrip({
    required int id,
    int? vehicleId,
    String? vehicleNumber,
    int? serviceId,
    String? serviceName,
    String? serviceType,
    @JsonKey(name: 'depot') String? depotName,
    int? duration,
    // Server sends int (v3) or String (v2) — coerce to int.
    @JsonKey(fromJson: _intOrNull) int? totalStops,
    int? status,
    TripEndpoint? from,
    TripEndpoint? to,
  }) = _BusTrip;

  factory BusTrip.fromJson(Map<String, dynamic> json) =>
      _$BusTripFromJson(json);

  /// Status 1 = bus is currently running/tracked.
  bool get isLive => status == 1 && vehicleId != null;

  /// Scheduled travel time between from→to, in minutes (null if unknown).
  int? get travelMinutes {
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

/// GET /v3.0/trips/betweenTwoLocations → {trips, myPoints}
@freezed
abstract class BusSearchResponse with _$BusSearchResponse {
  const factory BusSearchResponse({
    @Default(<BusTrip>[]) List<BusTrip> trips,
  }) = _BusSearchResponse;

  factory BusSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$BusSearchResponseFromJson(json);
}
