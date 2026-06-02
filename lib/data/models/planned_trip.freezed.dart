// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planned_trip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlannedTrip {

 int? get serviceId; String? get serviceName; String? get serviceType;@JsonKey(fromJson: _intOrNull) int? get totalStops; int? get duration;@JsonKey(name: 'depot') String? get depot; TripEndpoint? get from; TripEndpoint? get to;
/// Create a copy of PlannedTrip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlannedTripCopyWith<PlannedTrip> get copyWith => _$PlannedTripCopyWithImpl<PlannedTrip>(this as PlannedTrip, _$identity);

  /// Serializes this PlannedTrip to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlannedTrip&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.totalStops, totalStops) || other.totalStops == totalStops)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.depot, depot) || other.depot == depot)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serviceId,serviceName,serviceType,totalStops,duration,depot,from,to);

@override
String toString() {
  return 'PlannedTrip(serviceId: $serviceId, serviceName: $serviceName, serviceType: $serviceType, totalStops: $totalStops, duration: $duration, depot: $depot, from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class $PlannedTripCopyWith<$Res>  {
  factory $PlannedTripCopyWith(PlannedTrip value, $Res Function(PlannedTrip) _then) = _$PlannedTripCopyWithImpl;
@useResult
$Res call({
 int? serviceId, String? serviceName, String? serviceType,@JsonKey(fromJson: _intOrNull) int? totalStops, int? duration,@JsonKey(name: 'depot') String? depot, TripEndpoint? from, TripEndpoint? to
});


$TripEndpointCopyWith<$Res>? get from;$TripEndpointCopyWith<$Res>? get to;

}
/// @nodoc
class _$PlannedTripCopyWithImpl<$Res>
    implements $PlannedTripCopyWith<$Res> {
  _$PlannedTripCopyWithImpl(this._self, this._then);

  final PlannedTrip _self;
  final $Res Function(PlannedTrip) _then;

/// Create a copy of PlannedTrip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serviceId = freezed,Object? serviceName = freezed,Object? serviceType = freezed,Object? totalStops = freezed,Object? duration = freezed,Object? depot = freezed,Object? from = freezed,Object? to = freezed,}) {
  return _then(_self.copyWith(
serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,serviceName: freezed == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String?,serviceType: freezed == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String?,totalStops: freezed == totalStops ? _self.totalStops : totalStops // ignore: cast_nullable_to_non_nullable
as int?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,depot: freezed == depot ? _self.depot : depot // ignore: cast_nullable_to_non_nullable
as String?,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as TripEndpoint?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as TripEndpoint?,
  ));
}
/// Create a copy of PlannedTrip
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
}/// Create a copy of PlannedTrip
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


/// Adds pattern-matching-related methods to [PlannedTrip].
extension PlannedTripPatterns on PlannedTrip {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlannedTrip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlannedTrip() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlannedTrip value)  $default,){
final _that = this;
switch (_that) {
case _PlannedTrip():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlannedTrip value)?  $default,){
final _that = this;
switch (_that) {
case _PlannedTrip() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? serviceId,  String? serviceName,  String? serviceType, @JsonKey(fromJson: _intOrNull)  int? totalStops,  int? duration, @JsonKey(name: 'depot')  String? depot,  TripEndpoint? from,  TripEndpoint? to)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlannedTrip() when $default != null:
return $default(_that.serviceId,_that.serviceName,_that.serviceType,_that.totalStops,_that.duration,_that.depot,_that.from,_that.to);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? serviceId,  String? serviceName,  String? serviceType, @JsonKey(fromJson: _intOrNull)  int? totalStops,  int? duration, @JsonKey(name: 'depot')  String? depot,  TripEndpoint? from,  TripEndpoint? to)  $default,) {final _that = this;
switch (_that) {
case _PlannedTrip():
return $default(_that.serviceId,_that.serviceName,_that.serviceType,_that.totalStops,_that.duration,_that.depot,_that.from,_that.to);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? serviceId,  String? serviceName,  String? serviceType, @JsonKey(fromJson: _intOrNull)  int? totalStops,  int? duration, @JsonKey(name: 'depot')  String? depot,  TripEndpoint? from,  TripEndpoint? to)?  $default,) {final _that = this;
switch (_that) {
case _PlannedTrip() when $default != null:
return $default(_that.serviceId,_that.serviceName,_that.serviceType,_that.totalStops,_that.duration,_that.depot,_that.from,_that.to);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlannedTrip extends PlannedTrip {
  const _PlannedTrip({this.serviceId, this.serviceName, this.serviceType, @JsonKey(fromJson: _intOrNull) this.totalStops, this.duration, @JsonKey(name: 'depot') this.depot, this.from, this.to}): super._();
  factory _PlannedTrip.fromJson(Map<String, dynamic> json) => _$PlannedTripFromJson(json);

@override final  int? serviceId;
@override final  String? serviceName;
@override final  String? serviceType;
@override@JsonKey(fromJson: _intOrNull) final  int? totalStops;
@override final  int? duration;
@override@JsonKey(name: 'depot') final  String? depot;
@override final  TripEndpoint? from;
@override final  TripEndpoint? to;

/// Create a copy of PlannedTrip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlannedTripCopyWith<_PlannedTrip> get copyWith => __$PlannedTripCopyWithImpl<_PlannedTrip>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlannedTripToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlannedTrip&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.totalStops, totalStops) || other.totalStops == totalStops)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.depot, depot) || other.depot == depot)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serviceId,serviceName,serviceType,totalStops,duration,depot,from,to);

@override
String toString() {
  return 'PlannedTrip(serviceId: $serviceId, serviceName: $serviceName, serviceType: $serviceType, totalStops: $totalStops, duration: $duration, depot: $depot, from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class _$PlannedTripCopyWith<$Res> implements $PlannedTripCopyWith<$Res> {
  factory _$PlannedTripCopyWith(_PlannedTrip value, $Res Function(_PlannedTrip) _then) = __$PlannedTripCopyWithImpl;
@override @useResult
$Res call({
 int? serviceId, String? serviceName, String? serviceType,@JsonKey(fromJson: _intOrNull) int? totalStops, int? duration,@JsonKey(name: 'depot') String? depot, TripEndpoint? from, TripEndpoint? to
});


@override $TripEndpointCopyWith<$Res>? get from;@override $TripEndpointCopyWith<$Res>? get to;

}
/// @nodoc
class __$PlannedTripCopyWithImpl<$Res>
    implements _$PlannedTripCopyWith<$Res> {
  __$PlannedTripCopyWithImpl(this._self, this._then);

  final _PlannedTrip _self;
  final $Res Function(_PlannedTrip) _then;

/// Create a copy of PlannedTrip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serviceId = freezed,Object? serviceName = freezed,Object? serviceType = freezed,Object? totalStops = freezed,Object? duration = freezed,Object? depot = freezed,Object? from = freezed,Object? to = freezed,}) {
  return _then(_PlannedTrip(
serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,serviceName: freezed == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String?,serviceType: freezed == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String?,totalStops: freezed == totalStops ? _self.totalStops : totalStops // ignore: cast_nullable_to_non_nullable
as int?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,depot: freezed == depot ? _self.depot : depot // ignore: cast_nullable_to_non_nullable
as String?,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as TripEndpoint?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as TripEndpoint?,
  ));
}

/// Create a copy of PlannedTrip
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
}/// Create a copy of PlannedTrip
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

// dart format on
