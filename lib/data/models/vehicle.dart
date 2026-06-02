import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle.freezed.dart';
part 'vehicle.g.dart';

/// GET /v2.0/vehicles
/// → [{id, name, registrationNumber, serviceType, operationType}]
@freezed
abstract class Vehicle with _$Vehicle {
  const factory Vehicle({
    required int id,
    required String name,
    String? registrationNumber,
    String? serviceType,
    int? operationType,
  }) = _Vehicle;

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);
}
