// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Vehicle _$VehicleFromJson(Map<String, dynamic> json) => _Vehicle(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  registrationNumber: json['registrationNumber'] as String?,
  serviceType: json['serviceType'] as String?,
  operationType: (json['operationType'] as num?)?.toInt(),
);

Map<String, dynamic> _$VehicleToJson(_Vehicle instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'registrationNumber': instance.registrationNumber,
  'serviceType': instance.serviceType,
  'operationType': instance.operationType,
};
