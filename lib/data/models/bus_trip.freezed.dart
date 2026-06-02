// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bus_trip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripEndpoint {

 int? get id; String? get name; int? get eta; int? get etd; int? get entryTime; int? get plannedTime; int? get plannedExitTime;
/// Create a copy of TripEndpoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripEndpointCopyWith<TripEndpoint> get copyWith => _$TripEndpointCopyWithImpl<TripEndpoint>(this as TripEndpoint, _$identity);

  /// Serializes this TripEndpoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripEndpoint&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.eta, eta) || other.eta == eta)&&(identical(other.etd, etd) || other.etd == etd)&&(identical(other.entryTime, entryTime) || other.entryTime == entryTime)&&(identical(other.plannedTime, plannedTime) || other.plannedTime == plannedTime)&&(identical(other.plannedExitTime, plannedExitTime) || other.plannedExitTime == plannedExitTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,eta,etd,entryTime,plannedTime,plannedExitTime);

@override
String toString() {
  return 'TripEndpoint(id: $id, name: $name, eta: $eta, etd: $etd, entryTime: $entryTime, plannedTime: $plannedTime, plannedExitTime: $plannedExitTime)';
}


}

/// @nodoc
abstract mixin class $TripEndpointCopyWith<$Res>  {
  factory $TripEndpointCopyWith(TripEndpoint value, $Res Function(TripEndpoint) _then) = _$TripEndpointCopyWithImpl;
@useResult
$Res call({
 int? id, String? name, int? eta, int? etd, int? entryTime, int? plannedTime, int? plannedExitTime
});




}
/// @nodoc
class _$TripEndpointCopyWithImpl<$Res>
    implements $TripEndpointCopyWith<$Res> {
  _$TripEndpointCopyWithImpl(this._self, this._then);

  final TripEndpoint _self;
  final $Res Function(TripEndpoint) _then;

/// Create a copy of TripEndpoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,Object? eta = freezed,Object? etd = freezed,Object? entryTime = freezed,Object? plannedTime = freezed,Object? plannedExitTime = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,eta: freezed == eta ? _self.eta : eta // ignore: cast_nullable_to_non_nullable
as int?,etd: freezed == etd ? _self.etd : etd // ignore: cast_nullable_to_non_nullable
as int?,entryTime: freezed == entryTime ? _self.entryTime : entryTime // ignore: cast_nullable_to_non_nullable
as int?,plannedTime: freezed == plannedTime ? _self.plannedTime : plannedTime // ignore: cast_nullable_to_non_nullable
as int?,plannedExitTime: freezed == plannedExitTime ? _self.plannedExitTime : plannedExitTime // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripEndpoint].
extension TripEndpointPatterns on TripEndpoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripEndpoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripEndpoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripEndpoint value)  $default,){
final _that = this;
switch (_that) {
case _TripEndpoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripEndpoint value)?  $default,){
final _that = this;
switch (_that) {
case _TripEndpoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? name,  int? eta,  int? etd,  int? entryTime,  int? plannedTime,  int? plannedExitTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripEndpoint() when $default != null:
return $default(_that.id,_that.name,_that.eta,_that.etd,_that.entryTime,_that.plannedTime,_that.plannedExitTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? name,  int? eta,  int? etd,  int? entryTime,  int? plannedTime,  int? plannedExitTime)  $default,) {final _that = this;
switch (_that) {
case _TripEndpoint():
return $default(_that.id,_that.name,_that.eta,_that.etd,_that.entryTime,_that.plannedTime,_that.plannedExitTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? name,  int? eta,  int? etd,  int? entryTime,  int? plannedTime,  int? plannedExitTime)?  $default,) {final _that = this;
switch (_that) {
case _TripEndpoint() when $default != null:
return $default(_that.id,_that.name,_that.eta,_that.etd,_that.entryTime,_that.plannedTime,_that.plannedExitTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripEndpoint extends TripEndpoint {
  const _TripEndpoint({this.id, this.name, this.eta, this.etd, this.entryTime, this.plannedTime, this.plannedExitTime}): super._();
  factory _TripEndpoint.fromJson(Map<String, dynamic> json) => _$TripEndpointFromJson(json);

@override final  int? id;
@override final  String? name;
@override final  int? eta;
@override final  int? etd;
@override final  int? entryTime;
@override final  int? plannedTime;
@override final  int? plannedExitTime;

/// Create a copy of TripEndpoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripEndpointCopyWith<_TripEndpoint> get copyWith => __$TripEndpointCopyWithImpl<_TripEndpoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripEndpointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripEndpoint&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.eta, eta) || other.eta == eta)&&(identical(other.etd, etd) || other.etd == etd)&&(identical(other.entryTime, entryTime) || other.entryTime == entryTime)&&(identical(other.plannedTime, plannedTime) || other.plannedTime == plannedTime)&&(identical(other.plannedExitTime, plannedExitTime) || other.plannedExitTime == plannedExitTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,eta,etd,entryTime,plannedTime,plannedExitTime);

@override
String toString() {
  return 'TripEndpoint(id: $id, name: $name, eta: $eta, etd: $etd, entryTime: $entryTime, plannedTime: $plannedTime, plannedExitTime: $plannedExitTime)';
}


}

/// @nodoc
abstract mixin class _$TripEndpointCopyWith<$Res> implements $TripEndpointCopyWith<$Res> {
  factory _$TripEndpointCopyWith(_TripEndpoint value, $Res Function(_TripEndpoint) _then) = __$TripEndpointCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? name, int? eta, int? etd, int? entryTime, int? plannedTime, int? plannedExitTime
});




}
/// @nodoc
class __$TripEndpointCopyWithImpl<$Res>
    implements _$TripEndpointCopyWith<$Res> {
  __$TripEndpointCopyWithImpl(this._self, this._then);

  final _TripEndpoint _self;
  final $Res Function(_TripEndpoint) _then;

/// Create a copy of TripEndpoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,Object? eta = freezed,Object? etd = freezed,Object? entryTime = freezed,Object? plannedTime = freezed,Object? plannedExitTime = freezed,}) {
  return _then(_TripEndpoint(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,eta: freezed == eta ? _self.eta : eta // ignore: cast_nullable_to_non_nullable
as int?,etd: freezed == etd ? _self.etd : etd // ignore: cast_nullable_to_non_nullable
as int?,entryTime: freezed == entryTime ? _self.entryTime : entryTime // ignore: cast_nullable_to_non_nullable
as int?,plannedTime: freezed == plannedTime ? _self.plannedTime : plannedTime // ignore: cast_nullable_to_non_nullable
as int?,plannedExitTime: freezed == plannedExitTime ? _self.plannedExitTime : plannedExitTime // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$BusTrip {

 int get id; int? get vehicleId; String? get vehicleNumber; int? get serviceId; String? get serviceName; String? get serviceType;@JsonKey(name: 'depot') String? get depotName; int? get duration;// Server sends int (v3) or String (v2) — coerce to int.
@JsonKey(fromJson: _intOrNull) int? get totalStops; int? get status; TripEndpoint? get from; TripEndpoint? get to;
/// Create a copy of BusTrip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusTripCopyWith<BusTrip> get copyWith => _$BusTripCopyWithImpl<BusTrip>(this as BusTrip, _$identity);

  /// Serializes this BusTrip to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusTrip&&(identical(other.id, id) || other.id == id)&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.vehicleNumber, vehicleNumber) || other.vehicleNumber == vehicleNumber)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.depotName, depotName) || other.depotName == depotName)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.totalStops, totalStops) || other.totalStops == totalStops)&&(identical(other.status, status) || other.status == status)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,vehicleId,vehicleNumber,serviceId,serviceName,serviceType,depotName,duration,totalStops,status,from,to);

@override
String toString() {
  return 'BusTrip(id: $id, vehicleId: $vehicleId, vehicleNumber: $vehicleNumber, serviceId: $serviceId, serviceName: $serviceName, serviceType: $serviceType, depotName: $depotName, duration: $duration, totalStops: $totalStops, status: $status, from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class $BusTripCopyWith<$Res>  {
  factory $BusTripCopyWith(BusTrip value, $Res Function(BusTrip) _then) = _$BusTripCopyWithImpl;
@useResult
$Res call({
 int id, int? vehicleId, String? vehicleNumber, int? serviceId, String? serviceName, String? serviceType,@JsonKey(name: 'depot') String? depotName, int? duration,@JsonKey(fromJson: _intOrNull) int? totalStops, int? status, TripEndpoint? from, TripEndpoint? to
});


$TripEndpointCopyWith<$Res>? get from;$TripEndpointCopyWith<$Res>? get to;

}
/// @nodoc
class _$BusTripCopyWithImpl<$Res>
    implements $BusTripCopyWith<$Res> {
  _$BusTripCopyWithImpl(this._self, this._then);

  final BusTrip _self;
  final $Res Function(BusTrip) _then;

/// Create a copy of BusTrip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? vehicleId = freezed,Object? vehicleNumber = freezed,Object? serviceId = freezed,Object? serviceName = freezed,Object? serviceType = freezed,Object? depotName = freezed,Object? duration = freezed,Object? totalStops = freezed,Object? status = freezed,Object? from = freezed,Object? to = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,vehicleId: freezed == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as int?,vehicleNumber: freezed == vehicleNumber ? _self.vehicleNumber : vehicleNumber // ignore: cast_nullable_to_non_nullable
as String?,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,serviceName: freezed == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String?,serviceType: freezed == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String?,depotName: freezed == depotName ? _self.depotName : depotName // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,totalStops: freezed == totalStops ? _self.totalStops : totalStops // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as TripEndpoint?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as TripEndpoint?,
  ));
}
/// Create a copy of BusTrip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripEndpointCopyWith<$Res>? get from {
    if (_self.from == null) {
    return null;
  }

  return $TripEndpointCopyWith<$Res>(_self.from!, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of BusTrip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripEndpointCopyWith<$Res>? get to {
    if (_self.to == null) {
    return null;
  }

  return $TripEndpointCopyWith<$Res>(_self.to!, (value) {
    return _then(_self.copyWith(to: value));
  });
}
}


/// Adds pattern-matching-related methods to [BusTrip].
extension BusTripPatterns on BusTrip {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusTrip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusTrip() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusTrip value)  $default,){
final _that = this;
switch (_that) {
case _BusTrip():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusTrip value)?  $default,){
final _that = this;
switch (_that) {
case _BusTrip() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? vehicleId,  String? vehicleNumber,  int? serviceId,  String? serviceName,  String? serviceType, @JsonKey(name: 'depot')  String? depotName,  int? duration, @JsonKey(fromJson: _intOrNull)  int? totalStops,  int? status,  TripEndpoint? from,  TripEndpoint? to)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusTrip() when $default != null:
return $default(_that.id,_that.vehicleId,_that.vehicleNumber,_that.serviceId,_that.serviceName,_that.serviceType,_that.depotName,_that.duration,_that.totalStops,_that.status,_that.from,_that.to);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? vehicleId,  String? vehicleNumber,  int? serviceId,  String? serviceName,  String? serviceType, @JsonKey(name: 'depot')  String? depotName,  int? duration, @JsonKey(fromJson: _intOrNull)  int? totalStops,  int? status,  TripEndpoint? from,  TripEndpoint? to)  $default,) {final _that = this;
switch (_that) {
case _BusTrip():
return $default(_that.id,_that.vehicleId,_that.vehicleNumber,_that.serviceId,_that.serviceName,_that.serviceType,_that.depotName,_that.duration,_that.totalStops,_that.status,_that.from,_that.to);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? vehicleId,  String? vehicleNumber,  int? serviceId,  String? serviceName,  String? serviceType, @JsonKey(name: 'depot')  String? depotName,  int? duration, @JsonKey(fromJson: _intOrNull)  int? totalStops,  int? status,  TripEndpoint? from,  TripEndpoint? to)?  $default,) {final _that = this;
switch (_that) {
case _BusTrip() when $default != null:
return $default(_that.id,_that.vehicleId,_that.vehicleNumber,_that.serviceId,_that.serviceName,_that.serviceType,_that.depotName,_that.duration,_that.totalStops,_that.status,_that.from,_that.to);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusTrip extends BusTrip {
  const _BusTrip({required this.id, this.vehicleId, this.vehicleNumber, this.serviceId, this.serviceName, this.serviceType, @JsonKey(name: 'depot') this.depotName, this.duration, @JsonKey(fromJson: _intOrNull) this.totalStops, this.status, this.from, this.to}): super._();
  factory _BusTrip.fromJson(Map<String, dynamic> json) => _$BusTripFromJson(json);

@override final  int id;
@override final  int? vehicleId;
@override final  String? vehicleNumber;
@override final  int? serviceId;
@override final  String? serviceName;
@override final  String? serviceType;
@override@JsonKey(name: 'depot') final  String? depotName;
@override final  int? duration;
// Server sends int (v3) or String (v2) — coerce to int.
@override@JsonKey(fromJson: _intOrNull) final  int? totalStops;
@override final  int? status;
@override final  TripEndpoint? from;
@override final  TripEndpoint? to;

/// Create a copy of BusTrip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusTripCopyWith<_BusTrip> get copyWith => __$BusTripCopyWithImpl<_BusTrip>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusTripToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusTrip&&(identical(other.id, id) || other.id == id)&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.vehicleNumber, vehicleNumber) || other.vehicleNumber == vehicleNumber)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.depotName, depotName) || other.depotName == depotName)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.totalStops, totalStops) || other.totalStops == totalStops)&&(identical(other.status, status) || other.status == status)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,vehicleId,vehicleNumber,serviceId,serviceName,serviceType,depotName,duration,totalStops,status,from,to);

@override
String toString() {
  return 'BusTrip(id: $id, vehicleId: $vehicleId, vehicleNumber: $vehicleNumber, serviceId: $serviceId, serviceName: $serviceName, serviceType: $serviceType, depotName: $depotName, duration: $duration, totalStops: $totalStops, status: $status, from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class _$BusTripCopyWith<$Res> implements $BusTripCopyWith<$Res> {
  factory _$BusTripCopyWith(_BusTrip value, $Res Function(_BusTrip) _then) = __$BusTripCopyWithImpl;
@override @useResult
$Res call({
 int id, int? vehicleId, String? vehicleNumber, int? serviceId, String? serviceName, String? serviceType,@JsonKey(name: 'depot') String? depotName, int? duration,@JsonKey(fromJson: _intOrNull) int? totalStops, int? status, TripEndpoint? from, TripEndpoint? to
});


@override $TripEndpointCopyWith<$Res>? get from;@override $TripEndpointCopyWith<$Res>? get to;

}
/// @nodoc
class __$BusTripCopyWithImpl<$Res>
    implements _$BusTripCopyWith<$Res> {
  __$BusTripCopyWithImpl(this._self, this._then);

  final _BusTrip _self;
  final $Res Function(_BusTrip) _then;

/// Create a copy of BusTrip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? vehicleId = freezed,Object? vehicleNumber = freezed,Object? serviceId = freezed,Object? serviceName = freezed,Object? serviceType = freezed,Object? depotName = freezed,Object? duration = freezed,Object? totalStops = freezed,Object? status = freezed,Object? from = freezed,Object? to = freezed,}) {
  return _then(_BusTrip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,vehicleId: freezed == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as int?,vehicleNumber: freezed == vehicleNumber ? _self.vehicleNumber : vehicleNumber // ignore: cast_nullable_to_non_nullable
as String?,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,serviceName: freezed == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String?,serviceType: freezed == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String?,depotName: freezed == depotName ? _self.depotName : depotName // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,totalStops: freezed == totalStops ? _self.totalStops : totalStops // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as TripEndpoint?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as TripEndpoint?,
  ));
}

/// Create a copy of BusTrip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripEndpointCopyWith<$Res>? get from {
    if (_self.from == null) {
    return null;
  }

  return $TripEndpointCopyWith<$Res>(_self.from!, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of BusTrip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripEndpointCopyWith<$Res>? get to {
    if (_self.to == null) {
    return null;
  }

  return $TripEndpointCopyWith<$Res>(_self.to!, (value) {
    return _then(_self.copyWith(to: value));
  });
}
}


/// @nodoc
mixin _$BusSearchResponse {

 List<BusTrip> get trips;
/// Create a copy of BusSearchResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusSearchResponseCopyWith<BusSearchResponse> get copyWith => _$BusSearchResponseCopyWithImpl<BusSearchResponse>(this as BusSearchResponse, _$identity);

  /// Serializes this BusSearchResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusSearchResponse&&const DeepCollectionEquality().equals(other.trips, trips));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(trips));

@override
String toString() {
  return 'BusSearchResponse(trips: $trips)';
}


}

/// @nodoc
abstract mixin class $BusSearchResponseCopyWith<$Res>  {
  factory $BusSearchResponseCopyWith(BusSearchResponse value, $Res Function(BusSearchResponse) _then) = _$BusSearchResponseCopyWithImpl;
@useResult
$Res call({
 List<BusTrip> trips
});




}
/// @nodoc
class _$BusSearchResponseCopyWithImpl<$Res>
    implements $BusSearchResponseCopyWith<$Res> {
  _$BusSearchResponseCopyWithImpl(this._self, this._then);

  final BusSearchResponse _self;
  final $Res Function(BusSearchResponse) _then;

/// Create a copy of BusSearchResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? trips = null,}) {
  return _then(_self.copyWith(
trips: null == trips ? _self.trips : trips // ignore: cast_nullable_to_non_nullable
as List<BusTrip>,
  ));
}

}


/// Adds pattern-matching-related methods to [BusSearchResponse].
extension BusSearchResponsePatterns on BusSearchResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusSearchResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusSearchResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusSearchResponse value)  $default,){
final _that = this;
switch (_that) {
case _BusSearchResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusSearchResponse value)?  $default,){
final _that = this;
switch (_that) {
case _BusSearchResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<BusTrip> trips)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusSearchResponse() when $default != null:
return $default(_that.trips);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<BusTrip> trips)  $default,) {final _that = this;
switch (_that) {
case _BusSearchResponse():
return $default(_that.trips);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<BusTrip> trips)?  $default,) {final _that = this;
switch (_that) {
case _BusSearchResponse() when $default != null:
return $default(_that.trips);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusSearchResponse implements BusSearchResponse {
  const _BusSearchResponse({final  List<BusTrip> trips = const <BusTrip>[]}): _trips = trips;
  factory _BusSearchResponse.fromJson(Map<String, dynamic> json) => _$BusSearchResponseFromJson(json);

 final  List<BusTrip> _trips;
@override@JsonKey() List<BusTrip> get trips {
  if (_trips is EqualUnmodifiableListView) return _trips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trips);
}


/// Create a copy of BusSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusSearchResponseCopyWith<_BusSearchResponse> get copyWith => __$BusSearchResponseCopyWithImpl<_BusSearchResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusSearchResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusSearchResponse&&const DeepCollectionEquality().equals(other._trips, _trips));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_trips));

@override
String toString() {
  return 'BusSearchResponse(trips: $trips)';
}


}

/// @nodoc
abstract mixin class _$BusSearchResponseCopyWith<$Res> implements $BusSearchResponseCopyWith<$Res> {
  factory _$BusSearchResponseCopyWith(_BusSearchResponse value, $Res Function(_BusSearchResponse) _then) = __$BusSearchResponseCopyWithImpl;
@override @useResult
$Res call({
 List<BusTrip> trips
});




}
/// @nodoc
class __$BusSearchResponseCopyWithImpl<$Res>
    implements _$BusSearchResponseCopyWith<$Res> {
  __$BusSearchResponseCopyWithImpl(this._self, this._then);

  final _BusSearchResponse _self;
  final $Res Function(_BusSearchResponse) _then;

/// Create a copy of BusSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? trips = null,}) {
  return _then(_BusSearchResponse(
trips: null == trips ? _self._trips : trips // ignore: cast_nullable_to_non_nullable
as List<BusTrip>,
  ));
}


}

// dart format on
