// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PolylinePoint _$PolylinePointFromJson(Map<String, dynamic> json) =>
    _PolylinePoint(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$PolylinePointToJson(_PolylinePoint instance) =>
    <String, dynamic>{'lat': instance.lat, 'lng': instance.lng};

_PointGeometry _$PointGeometryFromJson(Map<String, dynamic> json) =>
    _PointGeometry(
      type: json['type'] as String?,
      coordinates: json['coordinates'] == null
          ? const <double>[]
          : _coords(json['coordinates']),
      address: json['address'] as String?,
    );

Map<String, dynamic> _$PointGeometryToJson(_PointGeometry instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
      'address': instance.address,
    };

_TripPoint _$TripPointFromJson(Map<String, dynamic> json) => _TripPoint(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  sequence: (json['sequence'] as num?)?.toInt() ?? 0,
  eta: (json['eta'] as num?)?.toInt(),
  etd: (json['etd'] as num?)?.toInt(),
  plannedTime: (json['plannedTime'] as num?)?.toInt(),
  plannedExitTime: (json['plannedExitTime'] as num?)?.toInt(),
  onRoute: json['myRoute'] as bool? ?? false,
  geometry: json['geometry'] == null
      ? null
      : PointGeometry.fromJson(json['geometry'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TripPointToJson(_TripPoint instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sequence': instance.sequence,
      'eta': instance.eta,
      'etd': instance.etd,
      'plannedTime': instance.plannedTime,
      'plannedExitTime': instance.plannedExitTime,
      'myRoute': instance.onRoute,
      'geometry': instance.geometry,
    };

_TripDetail _$TripDetailFromJson(Map<String, dynamic> json) => _TripDetail(
  id: (json['id'] as num).toInt(),
  vehicleId: (json['vehicleId'] as num?)?.toInt(),
  vehicleNumber: json['vehicleNumber'] as String?,
  serviceId: (json['serviceId'] as num?)?.toInt(),
  serviceName: json['serviceName'] as String?,
  serviceType: json['serviceType'] as String?,
  depotName: json['depotName'] as String?,
  driverName: json['driverName'] as String?,
  driverMobile: json['driverMobile'] as String?,
  helpline: json['helpline'] as String?,
  duration: (json['duration'] as num?)?.toInt(),
  plannedStartTime: (json['plannedStartTime'] as num?)?.toInt(),
  plannedEndTime: (json['plannedEndTime'] as num?)?.toInt(),
  status: (json['status'] as num?)?.toInt(),
  statusStr: json['statusStr'] as String?,
  points:
      (json['points'] as List<dynamic>?)
          ?.map((e) => TripPoint.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TripPoint>[],
  polylinePoints:
      (json['polylinePoints'] as List<dynamic>?)
          ?.map((e) => PolylinePoint.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PolylinePoint>[],
);

Map<String, dynamic> _$TripDetailToJson(_TripDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vehicleId': instance.vehicleId,
      'vehicleNumber': instance.vehicleNumber,
      'serviceId': instance.serviceId,
      'serviceName': instance.serviceName,
      'serviceType': instance.serviceType,
      'depotName': instance.depotName,
      'driverName': instance.driverName,
      'driverMobile': instance.driverMobile,
      'helpline': instance.helpline,
      'duration': instance.duration,
      'plannedStartTime': instance.plannedStartTime,
      'plannedEndTime': instance.plannedEndTime,
      'status': instance.status,
      'statusStr': instance.statusStr,
      'points': instance.points,
      'polylinePoints': instance.polylinePoints,
    };
