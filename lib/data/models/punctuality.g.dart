// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'punctuality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PunctualityResponse _$PunctualityResponseFromJson(Map<String, dynamic> json) =>
    _PunctualityResponse(
      serviceId: (json['serviceId'] as num?)?.toInt(),
      serviceName: json['serviceName'] as String?,
      serviceType: json['serviceType'] as String?,
      points:
          (json['points'] as List<dynamic>?)
              ?.map((e) => PunctualityPoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PunctualityPoint>[],
    );

Map<String, dynamic> _$PunctualityResponseToJson(
  _PunctualityResponse instance,
) => <String, dynamic>{
  'serviceId': instance.serviceId,
  'serviceName': instance.serviceName,
  'serviceType': instance.serviceType,
  'points': instance.points,
};

_PunctualityPoint _$PunctualityPointFromJson(Map<String, dynamic> json) =>
    _PunctualityPoint(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      entryTime: (json['entryTime'] as num?)?.toInt(),
      exitTime: (json['exitTime'] as num?)?.toInt(),
      eta: (json['eta'] as num?)?.toInt(),
      etd: (json['etd'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PunctualityPointToJson(_PunctualityPoint instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'entryTime': instance.entryTime,
      'exitTime': instance.exitTime,
      'eta': instance.eta,
      'etd': instance.etd,
    };
