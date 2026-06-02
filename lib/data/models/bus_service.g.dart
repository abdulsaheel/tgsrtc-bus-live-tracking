// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BusService _$BusServiceFromJson(Map<String, dynamic> json) => _BusService(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  serviceType: json['serviceType'] as String?,
  routeNumber: json['routeNumber'] as String?,
);

Map<String, dynamic> _$BusServiceToJson(_BusService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'serviceType': instance.serviceType,
      'routeNumber': instance.routeNumber,
    };
