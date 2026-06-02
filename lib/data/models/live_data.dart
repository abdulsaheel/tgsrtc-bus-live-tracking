import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_data.freezed.dart';
part 'live_data.g.dart';

/// GET /v2.0/vehicles/{vehicleId} → live GPS position. ⭐ core tracking model.
/// gpsTime/gprsTime are unix SECONDS.
@freezed
abstract class LiveData with _$LiveData {
  const LiveData._();

  const factory LiveData({
    required int id,
    required String name,
    String? vehicleNumber,
    int? tripId,
    required double latitude,
    required double longitude,
    @Default(0) double heading,
    @JsonKey(name: 'speedKph') @Default(0) double speedKph,
    String? address,
    int? status,
    int? ignition,
    String? statusStr,
    int? gpsTime,
    int? gprsTime,
    int? currentPointId,
    int? nextPointId,
    int? previousPointId,
    double? distanceFromPrevious,
  }) = _LiveData;

  factory LiveData.fromJson(Map<String, dynamic> json) =>
      _$LiveDataFromJson(json);

  DateTime? get gpsTimestamp => gpsTime == null
      ? null
      : DateTime.fromMillisecondsSinceEpoch(gpsTime! * 1000);

  /// Whether the GPS fix is older than the staleness threshold (default 60s).
  bool isStale(Duration threshold) {
    final ts = gpsTimestamp;
    if (ts == null) return true;
    return DateTime.now().difference(ts) > threshold;
  }

  bool get hasNoData => status == 5 || (statusStr?.toLowerCase() == 'no data');
}
