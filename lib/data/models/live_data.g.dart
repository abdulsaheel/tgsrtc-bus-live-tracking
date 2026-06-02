// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LiveData _$LiveDataFromJson(Map<String, dynamic> json) => _LiveData(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  vehicleNumber: json['vehicleNumber'] as String?,
  tripId: (json['tripId'] as num?)?.toInt(),
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  heading: (json['heading'] as num?)?.toDouble() ?? 0,
  speedKph: (json['speedKph'] as num?)?.toDouble() ?? 0,
  address: json['address'] as String?,
  status: (json['status'] as num?)?.toInt(),
  ignition: (json['ignition'] as num?)?.toInt(),
  statusStr: json['statusStr'] as String?,
  gpsTime: (json['gpsTime'] as num?)?.toInt(),
  gprsTime: (json['gprsTime'] as num?)?.toInt(),
  currentPointId: (json['currentPointId'] as num?)?.toInt(),
  nextPointId: (json['nextPointId'] as num?)?.toInt(),
  previousPointId: (json['previousPointId'] as num?)?.toInt(),
  distanceFromPrevious: (json['distanceFromPrevious'] as num?)?.toDouble(),
);

Map<String, dynamic> _$LiveDataToJson(_LiveData instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'vehicleNumber': instance.vehicleNumber,
  'tripId': instance.tripId,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'heading': instance.heading,
  'speedKph': instance.speedKph,
  'address': instance.address,
  'status': instance.status,
  'ignition': instance.ignition,
  'statusStr': instance.statusStr,
  'gpsTime': instance.gpsTime,
  'gprsTime': instance.gprsTime,
  'currentPointId': instance.currentPointId,
  'nextPointId': instance.nextPointId,
  'previousPointId': instance.previousPointId,
  'distanceFromPrevious': instance.distanceFromPrevious,
};
