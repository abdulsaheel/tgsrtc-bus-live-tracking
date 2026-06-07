import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_detail.freezed.dart';
part 'trip_detail.g.dart';

/// A single point on a polyline (lat/lng).
@freezed
abstract class PolylinePoint with _$PolylinePoint {
  const factory PolylinePoint({
    required double lat,
    required double lng,
  }) = _PolylinePoint;

  factory PolylinePoint.fromJson(Map<String, dynamic> json) =>
      _$PolylinePointFromJson(json);
}

/// Geometry on a stop point. coordinates = [lng, lat].
@freezed
abstract class PointGeometry with _$PointGeometry {
  const factory PointGeometry({
    String? type,
    // Tolerant: only keep a flat [lng, lat] pair; ignore nested geometries.
    @JsonKey(fromJson: _coords) @Default(<double>[]) List<double> coordinates,
    String? address,
  }) = _PointGeometry;

  factory PointGeometry.fromJson(Map<String, dynamic> json) =>
      _$PointGeometryFromJson(json);
}

List<double> _coords(Object? v) {
  if (v is List && v.every((e) => e is num)) {
    return v.map((e) => (e as num).toDouble()).toList();
  }
  return const [];
}

/// A stop within a trip (TripDetailModel.points / PanctualityResponse.points).
@freezed
abstract class TripPoint with _$TripPoint {
  const TripPoint._();

  const factory TripPoint({
    required int id,
    required String name,
    @Default(0) int sequence,
    int? eta,
    int? etd,
    int? plannedTime,
    int? plannedExitTime,
    int? entryTime,
    int? exitTime,
    @JsonKey(name: 'myRoute') @Default(false) bool onRoute,
    PointGeometry? geometry,
  }) = _TripPoint;

  factory TripPoint.fromJson(Map<String, dynamic> json) =>
      _$TripPointFromJson(json);

  /// Scheduled arrival (epoch s) / actual recorded arrival, if passed.
  bool get isPassed => (entryTime ?? 0) > 0;

  double? get latitude =>
      geometry != null && geometry!.coordinates.length >= 2
          ? geometry!.coordinates[1]
          : null;
  double? get longitude =>
      geometry != null && geometry!.coordinates.isNotEmpty
          ? geometry!.coordinates[0]
          : null;
}

/// GET /v2.0|v3.0/trips/details/{tripId} → full trip detail.
@freezed
abstract class TripDetail with _$TripDetail {
  const factory TripDetail({
    required int id,
    int? vehicleId,
    String? vehicleNumber,
    int? serviceId,
    String? serviceName,
    String? serviceType,
    String? depotName,
    String? driverName,
    String? driverMobile,
    String? helpline,
    int? duration,
    int? plannedStartTime,
    int? plannedEndTime,
    int? status,
    String? statusStr,
    @Default(<TripPoint>[]) List<TripPoint> points,
    @Default(<PolylinePoint>[]) List<PolylinePoint> polylinePoints,
  }) = _TripDetail;

  factory TripDetail.fromJson(Map<String, dynamic> json) =>
      _$TripDetailFromJson(json);
}
