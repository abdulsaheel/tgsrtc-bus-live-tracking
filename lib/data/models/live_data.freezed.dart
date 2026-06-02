// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LiveData {

 int get id; String get name; String? get vehicleNumber; int? get tripId; double get latitude; double get longitude; double get heading;@JsonKey(name: 'speedKph') double get speedKph; String? get address; int? get status; int? get ignition; String? get statusStr; int? get gpsTime; int? get gprsTime; int? get currentPointId; int? get nextPointId; int? get previousPointId; double? get distanceFromPrevious;
/// Create a copy of LiveData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveDataCopyWith<LiveData> get copyWith => _$LiveDataCopyWithImpl<LiveData>(this as LiveData, _$identity);

  /// Serializes this LiveData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.vehicleNumber, vehicleNumber) || other.vehicleNumber == vehicleNumber)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.heading, heading) || other.heading == heading)&&(identical(other.speedKph, speedKph) || other.speedKph == speedKph)&&(identical(other.address, address) || other.address == address)&&(identical(other.status, status) || other.status == status)&&(identical(other.ignition, ignition) || other.ignition == ignition)&&(identical(other.statusStr, statusStr) || other.statusStr == statusStr)&&(identical(other.gpsTime, gpsTime) || other.gpsTime == gpsTime)&&(identical(other.gprsTime, gprsTime) || other.gprsTime == gprsTime)&&(identical(other.currentPointId, currentPointId) || other.currentPointId == currentPointId)&&(identical(other.nextPointId, nextPointId) || other.nextPointId == nextPointId)&&(identical(other.previousPointId, previousPointId) || other.previousPointId == previousPointId)&&(identical(other.distanceFromPrevious, distanceFromPrevious) || other.distanceFromPrevious == distanceFromPrevious));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,vehicleNumber,tripId,latitude,longitude,heading,speedKph,address,status,ignition,statusStr,gpsTime,gprsTime,currentPointId,nextPointId,previousPointId,distanceFromPrevious);

@override
String toString() {
  return 'LiveData(id: $id, name: $name, vehicleNumber: $vehicleNumber, tripId: $tripId, latitude: $latitude, longitude: $longitude, heading: $heading, speedKph: $speedKph, address: $address, status: $status, ignition: $ignition, statusStr: $statusStr, gpsTime: $gpsTime, gprsTime: $gprsTime, currentPointId: $currentPointId, nextPointId: $nextPointId, previousPointId: $previousPointId, distanceFromPrevious: $distanceFromPrevious)';
}


}

/// @nodoc
abstract mixin class $LiveDataCopyWith<$Res>  {
  factory $LiveDataCopyWith(LiveData value, $Res Function(LiveData) _then) = _$LiveDataCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? vehicleNumber, int? tripId, double latitude, double longitude, double heading,@JsonKey(name: 'speedKph') double speedKph, String? address, int? status, int? ignition, String? statusStr, int? gpsTime, int? gprsTime, int? currentPointId, int? nextPointId, int? previousPointId, double? distanceFromPrevious
});




}
/// @nodoc
class _$LiveDataCopyWithImpl<$Res>
    implements $LiveDataCopyWith<$Res> {
  _$LiveDataCopyWithImpl(this._self, this._then);

  final LiveData _self;
  final $Res Function(LiveData) _then;

/// Create a copy of LiveData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? vehicleNumber = freezed,Object? tripId = freezed,Object? latitude = null,Object? longitude = null,Object? heading = null,Object? speedKph = null,Object? address = freezed,Object? status = freezed,Object? ignition = freezed,Object? statusStr = freezed,Object? gpsTime = freezed,Object? gprsTime = freezed,Object? currentPointId = freezed,Object? nextPointId = freezed,Object? previousPointId = freezed,Object? distanceFromPrevious = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,vehicleNumber: freezed == vehicleNumber ? _self.vehicleNumber : vehicleNumber // ignore: cast_nullable_to_non_nullable
as String?,tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as int?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,heading: null == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as double,speedKph: null == speedKph ? _self.speedKph : speedKph // ignore: cast_nullable_to_non_nullable
as double,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,ignition: freezed == ignition ? _self.ignition : ignition // ignore: cast_nullable_to_non_nullable
as int?,statusStr: freezed == statusStr ? _self.statusStr : statusStr // ignore: cast_nullable_to_non_nullable
as String?,gpsTime: freezed == gpsTime ? _self.gpsTime : gpsTime // ignore: cast_nullable_to_non_nullable
as int?,gprsTime: freezed == gprsTime ? _self.gprsTime : gprsTime // ignore: cast_nullable_to_non_nullable
as int?,currentPointId: freezed == currentPointId ? _self.currentPointId : currentPointId // ignore: cast_nullable_to_non_nullable
as int?,nextPointId: freezed == nextPointId ? _self.nextPointId : nextPointId // ignore: cast_nullable_to_non_nullable
as int?,previousPointId: freezed == previousPointId ? _self.previousPointId : previousPointId // ignore: cast_nullable_to_non_nullable
as int?,distanceFromPrevious: freezed == distanceFromPrevious ? _self.distanceFromPrevious : distanceFromPrevious // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveData].
extension LiveDataPatterns on LiveData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveData value)  $default,){
final _that = this;
switch (_that) {
case _LiveData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveData value)?  $default,){
final _that = this;
switch (_that) {
case _LiveData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? vehicleNumber,  int? tripId,  double latitude,  double longitude,  double heading, @JsonKey(name: 'speedKph')  double speedKph,  String? address,  int? status,  int? ignition,  String? statusStr,  int? gpsTime,  int? gprsTime,  int? currentPointId,  int? nextPointId,  int? previousPointId,  double? distanceFromPrevious)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveData() when $default != null:
return $default(_that.id,_that.name,_that.vehicleNumber,_that.tripId,_that.latitude,_that.longitude,_that.heading,_that.speedKph,_that.address,_that.status,_that.ignition,_that.statusStr,_that.gpsTime,_that.gprsTime,_that.currentPointId,_that.nextPointId,_that.previousPointId,_that.distanceFromPrevious);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? vehicleNumber,  int? tripId,  double latitude,  double longitude,  double heading, @JsonKey(name: 'speedKph')  double speedKph,  String? address,  int? status,  int? ignition,  String? statusStr,  int? gpsTime,  int? gprsTime,  int? currentPointId,  int? nextPointId,  int? previousPointId,  double? distanceFromPrevious)  $default,) {final _that = this;
switch (_that) {
case _LiveData():
return $default(_that.id,_that.name,_that.vehicleNumber,_that.tripId,_that.latitude,_that.longitude,_that.heading,_that.speedKph,_that.address,_that.status,_that.ignition,_that.statusStr,_that.gpsTime,_that.gprsTime,_that.currentPointId,_that.nextPointId,_that.previousPointId,_that.distanceFromPrevious);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? vehicleNumber,  int? tripId,  double latitude,  double longitude,  double heading, @JsonKey(name: 'speedKph')  double speedKph,  String? address,  int? status,  int? ignition,  String? statusStr,  int? gpsTime,  int? gprsTime,  int? currentPointId,  int? nextPointId,  int? previousPointId,  double? distanceFromPrevious)?  $default,) {final _that = this;
switch (_that) {
case _LiveData() when $default != null:
return $default(_that.id,_that.name,_that.vehicleNumber,_that.tripId,_that.latitude,_that.longitude,_that.heading,_that.speedKph,_that.address,_that.status,_that.ignition,_that.statusStr,_that.gpsTime,_that.gprsTime,_that.currentPointId,_that.nextPointId,_that.previousPointId,_that.distanceFromPrevious);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveData extends LiveData {
  const _LiveData({required this.id, required this.name, this.vehicleNumber, this.tripId, required this.latitude, required this.longitude, this.heading = 0, @JsonKey(name: 'speedKph') this.speedKph = 0, this.address, this.status, this.ignition, this.statusStr, this.gpsTime, this.gprsTime, this.currentPointId, this.nextPointId, this.previousPointId, this.distanceFromPrevious}): super._();
  factory _LiveData.fromJson(Map<String, dynamic> json) => _$LiveDataFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? vehicleNumber;
@override final  int? tripId;
@override final  double latitude;
@override final  double longitude;
@override@JsonKey() final  double heading;
@override@JsonKey(name: 'speedKph') final  double speedKph;
@override final  String? address;
@override final  int? status;
@override final  int? ignition;
@override final  String? statusStr;
@override final  int? gpsTime;
@override final  int? gprsTime;
@override final  int? currentPointId;
@override final  int? nextPointId;
@override final  int? previousPointId;
@override final  double? distanceFromPrevious;

/// Create a copy of LiveData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveDataCopyWith<_LiveData> get copyWith => __$LiveDataCopyWithImpl<_LiveData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.vehicleNumber, vehicleNumber) || other.vehicleNumber == vehicleNumber)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.heading, heading) || other.heading == heading)&&(identical(other.speedKph, speedKph) || other.speedKph == speedKph)&&(identical(other.address, address) || other.address == address)&&(identical(other.status, status) || other.status == status)&&(identical(other.ignition, ignition) || other.ignition == ignition)&&(identical(other.statusStr, statusStr) || other.statusStr == statusStr)&&(identical(other.gpsTime, gpsTime) || other.gpsTime == gpsTime)&&(identical(other.gprsTime, gprsTime) || other.gprsTime == gprsTime)&&(identical(other.currentPointId, currentPointId) || other.currentPointId == currentPointId)&&(identical(other.nextPointId, nextPointId) || other.nextPointId == nextPointId)&&(identical(other.previousPointId, previousPointId) || other.previousPointId == previousPointId)&&(identical(other.distanceFromPrevious, distanceFromPrevious) || other.distanceFromPrevious == distanceFromPrevious));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,vehicleNumber,tripId,latitude,longitude,heading,speedKph,address,status,ignition,statusStr,gpsTime,gprsTime,currentPointId,nextPointId,previousPointId,distanceFromPrevious);

@override
String toString() {
  return 'LiveData(id: $id, name: $name, vehicleNumber: $vehicleNumber, tripId: $tripId, latitude: $latitude, longitude: $longitude, heading: $heading, speedKph: $speedKph, address: $address, status: $status, ignition: $ignition, statusStr: $statusStr, gpsTime: $gpsTime, gprsTime: $gprsTime, currentPointId: $currentPointId, nextPointId: $nextPointId, previousPointId: $previousPointId, distanceFromPrevious: $distanceFromPrevious)';
}


}

/// @nodoc
abstract mixin class _$LiveDataCopyWith<$Res> implements $LiveDataCopyWith<$Res> {
  factory _$LiveDataCopyWith(_LiveData value, $Res Function(_LiveData) _then) = __$LiveDataCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? vehicleNumber, int? tripId, double latitude, double longitude, double heading,@JsonKey(name: 'speedKph') double speedKph, String? address, int? status, int? ignition, String? statusStr, int? gpsTime, int? gprsTime, int? currentPointId, int? nextPointId, int? previousPointId, double? distanceFromPrevious
});




}
/// @nodoc
class __$LiveDataCopyWithImpl<$Res>
    implements _$LiveDataCopyWith<$Res> {
  __$LiveDataCopyWithImpl(this._self, this._then);

  final _LiveData _self;
  final $Res Function(_LiveData) _then;

/// Create a copy of LiveData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? vehicleNumber = freezed,Object? tripId = freezed,Object? latitude = null,Object? longitude = null,Object? heading = null,Object? speedKph = null,Object? address = freezed,Object? status = freezed,Object? ignition = freezed,Object? statusStr = freezed,Object? gpsTime = freezed,Object? gprsTime = freezed,Object? currentPointId = freezed,Object? nextPointId = freezed,Object? previousPointId = freezed,Object? distanceFromPrevious = freezed,}) {
  return _then(_LiveData(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,vehicleNumber: freezed == vehicleNumber ? _self.vehicleNumber : vehicleNumber // ignore: cast_nullable_to_non_nullable
as String?,tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as int?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,heading: null == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as double,speedKph: null == speedKph ? _self.speedKph : speedKph // ignore: cast_nullable_to_non_nullable
as double,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,ignition: freezed == ignition ? _self.ignition : ignition // ignore: cast_nullable_to_non_nullable
as int?,statusStr: freezed == statusStr ? _self.statusStr : statusStr // ignore: cast_nullable_to_non_nullable
as String?,gpsTime: freezed == gpsTime ? _self.gpsTime : gpsTime // ignore: cast_nullable_to_non_nullable
as int?,gprsTime: freezed == gprsTime ? _self.gprsTime : gprsTime // ignore: cast_nullable_to_non_nullable
as int?,currentPointId: freezed == currentPointId ? _self.currentPointId : currentPointId // ignore: cast_nullable_to_non_nullable
as int?,nextPointId: freezed == nextPointId ? _self.nextPointId : nextPointId // ignore: cast_nullable_to_non_nullable
as int?,previousPointId: freezed == previousPointId ? _self.previousPointId : previousPointId // ignore: cast_nullable_to_non_nullable
as int?,distanceFromPrevious: freezed == distanceFromPrevious ? _self.distanceFromPrevious : distanceFromPrevious // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
