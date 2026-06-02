// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Stop _$StopFromJson(Map<String, dynamic> json) => _Stop(
  id: json['id'] as String,
  name: json['name'] as String,
  geozoneType: json['geozoneType'] as String?,
);

Map<String, dynamic> _$StopToJson(_Stop instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'geozoneType': instance.geozoneType,
};

_NearbyStop _$NearbyStopFromJson(Map<String, dynamic> json) => _NearbyStop(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  geometry: json['geometry'] == null
      ? null
      : StopGeometry.fromJson(json['geometry'] as Map<String, dynamic>),
  address: json['address'] as String?,
  distance: (json['distance'] as num?)?.toDouble(),
  geozoneType: json['geozoneType'] as String?,
  buffer: (json['buffer'] as num?)?.toDouble(),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$NearbyStopToJson(_NearbyStop instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'geometry': instance.geometry,
      'address': instance.address,
      'distance': instance.distance,
      'geozoneType': instance.geozoneType,
      'buffer': instance.buffer,
      'metadata': instance.metadata,
    };

_StopGeometry _$StopGeometryFromJson(Map<String, dynamic> json) =>
    _StopGeometry(
      type: json['type'] as String?,
      coordinates: json['coordinates'] == null
          ? const <double>[]
          : _coords(json['coordinates']),
    );

Map<String, dynamic> _$StopGeometryToJson(_StopGeometry instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };
