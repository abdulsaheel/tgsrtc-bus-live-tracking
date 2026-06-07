import 'package:freezed_annotation/freezed_annotation.dart';

part 'punctuality.freezed.dart';
part 'punctuality.g.dart';

/// GET /v2.0/trips/history/{serviceId} — the service's most recent recorded run,
/// stop-by-stop. `entryTime`/`exitTime` are the ACTUAL times the bus reached /
/// left each stop on that run (epoch seconds) — used to show "last arrived at".
@freezed
abstract class PunctualityResponse with _$PunctualityResponse {
  const factory PunctualityResponse({
    int? serviceId,
    String? serviceName,
    String? serviceType,
    @Default(<PunctualityPoint>[]) List<PunctualityPoint> points,
  }) = _PunctualityResponse;

  factory PunctualityResponse.fromJson(Map<String, dynamic> json) =>
      _$PunctualityResponseFromJson(json);
}

@freezed
abstract class PunctualityPoint with _$PunctualityPoint {
  const factory PunctualityPoint({
    required int id,
    String? name,
    int? entryTime,
    int? exitTime,
    int? eta,
    int? etd,
  }) = _PunctualityPoint;

  factory PunctualityPoint.fromJson(Map<String, dynamic> json) =>
      _$PunctualityPointFromJson(json);
}
