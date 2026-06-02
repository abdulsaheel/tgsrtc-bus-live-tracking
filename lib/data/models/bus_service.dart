import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_service.freezed.dart';
part 'bus_service.g.dart';

/// GET /v2.0/services and /v3.0/distinctservices
/// → [{id, name, serviceType, routeNumber}]
@freezed
abstract class BusService with _$BusService {
  const factory BusService({
    required int id,
    required String name,
    String? serviceType,
    String? routeNumber,
  }) = _BusService;

  factory BusService.fromJson(Map<String, dynamic> json) =>
      _$BusServiceFromJson(json);
}
