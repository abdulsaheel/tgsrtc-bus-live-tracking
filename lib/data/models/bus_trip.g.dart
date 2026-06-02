// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripEndpoint _$TripEndpointFromJson(Map<String, dynamic> json) =>
    _TripEndpoint(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      eta: (json['eta'] as num?)?.toInt(),
      etd: (json['etd'] as num?)?.toInt(),
      entryTime: (json['entryTime'] as num?)?.toInt(),
      plannedTime: (json['plannedTime'] as num?)?.toInt(),
      plannedExitTime: (json['plannedExitTime'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TripEndpointToJson(_TripEndpoint instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'eta': instance.eta,
      'etd': instance.etd,
      'entryTime': instance.entryTime,
      'plannedTime': instance.plannedTime,
      'plannedExitTime': instance.plannedExitTime,
    };

_BusTrip _$BusTripFromJson(Map<String, dynamic> json) => _BusTrip(
  id: (json['id'] as num).toInt(),
  vehicleId: (json['vehicleId'] as num?)?.toInt(),
  vehicleNumber: json['vehicleNumber'] as String?,
  serviceId: (json['serviceId'] as num?)?.toInt(),
  serviceName: json['serviceName'] as String?,
  serviceType: json['serviceType'] as String?,
  depotName: json['depot'] as String?,
  duration: (json['duration'] as num?)?.toInt(),
  totalStops: _intOrNull(json['totalStops']),
  status: (json['status'] as num?)?.toInt(),
  from: json['from'] == null
      ? null
      : TripEndpoint.fromJson(json['from'] as Map<String, dynamic>),
  to: json['to'] == null
      ? null
      : TripEndpoint.fromJson(json['to'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BusTripToJson(_BusTrip instance) => <String, dynamic>{
  'id': instance.id,
  'vehicleId': instance.vehicleId,
  'vehicleNumber': instance.vehicleNumber,
  'serviceId': instance.serviceId,
  'serviceName': instance.serviceName,
  'serviceType': instance.serviceType,
  'depot': instance.depotName,
  'duration': instance.duration,
  'totalStops': instance.totalStops,
  'status': instance.status,
  'from': instance.from,
  'to': instance.to,
};

_BusSearchResponse _$BusSearchResponseFromJson(Map<String, dynamic> json) =>
    _BusSearchResponse(
      trips:
          (json['trips'] as List<dynamic>?)
              ?.map((e) => BusTrip.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <BusTrip>[],
    );

Map<String, dynamic> _$BusSearchResponseToJson(_BusSearchResponse instance) =>
    <String, dynamic>{'trips': instance.trips};
