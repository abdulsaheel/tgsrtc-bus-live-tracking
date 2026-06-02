// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planned_trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlannedTrip _$PlannedTripFromJson(Map<String, dynamic> json) => _PlannedTrip(
  serviceId: (json['serviceId'] as num?)?.toInt(),
  serviceName: json['serviceName'] as String?,
  serviceType: json['serviceType'] as String?,
  totalStops: _intOrNull(json['totalStops']),
  duration: (json['duration'] as num?)?.toInt(),
  depot: json['depot'] as String?,
  from: json['from'] == null
      ? null
      : TripEndpoint.fromJson(json['from'] as Map<String, dynamic>),
  to: json['to'] == null
      ? null
      : TripEndpoint.fromJson(json['to'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PlannedTripToJson(_PlannedTrip instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
      'serviceName': instance.serviceName,
      'serviceType': instance.serviceType,
      'totalStops': instance.totalStops,
      'duration': instance.duration,
      'depot': instance.depot,
      'from': instance.from,
      'to': instance.to,
    };
