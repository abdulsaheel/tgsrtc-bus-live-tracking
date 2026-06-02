import 'package:freezed_annotation/freezed_annotation.dart';

part 'stop.freezed.dart';
part 'stop.g.dart';

/// GET /v3.0/stops → [{id, name, geozoneType}]  (id is a String here)
@freezed
abstract class Stop with _$Stop {
  const factory Stop({
    required String id,
    required String name,
    String? geozoneType,
  }) = _Stop;

  factory Stop.fromJson(Map<String, dynamic> json) => _$StopFromJson(json);
}

/// GET /v2.0/stops/nearby → GeoJSON-style stops with coordinates + distance.
/// (id is an int here.)
@freezed
abstract class NearbyStop with _$NearbyStop {
  const NearbyStop._();

  const factory NearbyStop({
    required int id,
    required String name,
    StopGeometry? geometry,
    String? address,
    double? distance,
    String? geozoneType,
    double? buffer,
    Map<String, dynamic>? metadata,
  }) = _NearbyStop;

  factory NearbyStop.fromJson(Map<String, dynamic> json) =>
      _$NearbyStopFromJson(json);

  double? get latitude =>
      geometry != null && geometry!.coordinates.length >= 2
          ? geometry!.coordinates[1]
          : null;
  double? get longitude =>
      geometry != null && geometry!.coordinates.isNotEmpty
          ? geometry!.coordinates[0]
          : null;
}

/// GeoJSON Point: coordinates are [longitude, latitude].
@freezed
abstract class StopGeometry with _$StopGeometry {
  const factory StopGeometry({
    String? type,
    // Tolerant: only keep a flat [lng, lat] pair; ignore nested geometries.
    @JsonKey(fromJson: _coords) @Default(<double>[]) List<double> coordinates,
  }) = _StopGeometry;

  factory StopGeometry.fromJson(Map<String, dynamic> json) =>
      _$StopGeometryFromJson(json);
}

List<double> _coords(Object? v) {
  if (v is List && v.every((e) => e is num)) {
    return v.map((e) => (e as num).toDouble()).toList();
  }
  return const [];
}
