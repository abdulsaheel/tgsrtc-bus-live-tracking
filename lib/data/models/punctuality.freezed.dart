// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'punctuality.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PunctualityResponse {

 int? get serviceId; String? get serviceName; String? get serviceType; List<PunctualityPoint> get points;
/// Create a copy of PunctualityResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PunctualityResponseCopyWith<PunctualityResponse> get copyWith => _$PunctualityResponseCopyWithImpl<PunctualityResponse>(this as PunctualityResponse, _$identity);

  /// Serializes this PunctualityResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PunctualityResponse&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&const DeepCollectionEquality().equals(other.points, points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serviceId,serviceName,serviceType,const DeepCollectionEquality().hash(points));

@override
String toString() {
  return 'PunctualityResponse(serviceId: $serviceId, serviceName: $serviceName, serviceType: $serviceType, points: $points)';
}


}

/// @nodoc
abstract mixin class $PunctualityResponseCopyWith<$Res>  {
  factory $PunctualityResponseCopyWith(PunctualityResponse value, $Res Function(PunctualityResponse) _then) = _$PunctualityResponseCopyWithImpl;
@useResult
$Res call({
 int? serviceId, String? serviceName, String? serviceType, List<PunctualityPoint> points
});




}
/// @nodoc
class _$PunctualityResponseCopyWithImpl<$Res>
    implements $PunctualityResponseCopyWith<$Res> {
  _$PunctualityResponseCopyWithImpl(this._self, this._then);

  final PunctualityResponse _self;
  final $Res Function(PunctualityResponse) _then;

/// Create a copy of PunctualityResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serviceId = freezed,Object? serviceName = freezed,Object? serviceType = freezed,Object? points = null,}) {
  return _then(_self.copyWith(
serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,serviceName: freezed == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String?,serviceType: freezed == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<PunctualityPoint>,
  ));
}

}


/// Adds pattern-matching-related methods to [PunctualityResponse].
extension PunctualityResponsePatterns on PunctualityResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PunctualityResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PunctualityResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PunctualityResponse value)  $default,){
final _that = this;
switch (_that) {
case _PunctualityResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PunctualityResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PunctualityResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? serviceId,  String? serviceName,  String? serviceType,  List<PunctualityPoint> points)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PunctualityResponse() when $default != null:
return $default(_that.serviceId,_that.serviceName,_that.serviceType,_that.points);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? serviceId,  String? serviceName,  String? serviceType,  List<PunctualityPoint> points)  $default,) {final _that = this;
switch (_that) {
case _PunctualityResponse():
return $default(_that.serviceId,_that.serviceName,_that.serviceType,_that.points);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? serviceId,  String? serviceName,  String? serviceType,  List<PunctualityPoint> points)?  $default,) {final _that = this;
switch (_that) {
case _PunctualityResponse() when $default != null:
return $default(_that.serviceId,_that.serviceName,_that.serviceType,_that.points);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PunctualityResponse implements PunctualityResponse {
  const _PunctualityResponse({this.serviceId, this.serviceName, this.serviceType, final  List<PunctualityPoint> points = const <PunctualityPoint>[]}): _points = points;
  factory _PunctualityResponse.fromJson(Map<String, dynamic> json) => _$PunctualityResponseFromJson(json);

@override final  int? serviceId;
@override final  String? serviceName;
@override final  String? serviceType;
 final  List<PunctualityPoint> _points;
@override@JsonKey() List<PunctualityPoint> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}


/// Create a copy of PunctualityResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PunctualityResponseCopyWith<_PunctualityResponse> get copyWith => __$PunctualityResponseCopyWithImpl<_PunctualityResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PunctualityResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PunctualityResponse&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&const DeepCollectionEquality().equals(other._points, _points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serviceId,serviceName,serviceType,const DeepCollectionEquality().hash(_points));

@override
String toString() {
  return 'PunctualityResponse(serviceId: $serviceId, serviceName: $serviceName, serviceType: $serviceType, points: $points)';
}


}

/// @nodoc
abstract mixin class _$PunctualityResponseCopyWith<$Res> implements $PunctualityResponseCopyWith<$Res> {
  factory _$PunctualityResponseCopyWith(_PunctualityResponse value, $Res Function(_PunctualityResponse) _then) = __$PunctualityResponseCopyWithImpl;
@override @useResult
$Res call({
 int? serviceId, String? serviceName, String? serviceType, List<PunctualityPoint> points
});




}
/// @nodoc
class __$PunctualityResponseCopyWithImpl<$Res>
    implements _$PunctualityResponseCopyWith<$Res> {
  __$PunctualityResponseCopyWithImpl(this._self, this._then);

  final _PunctualityResponse _self;
  final $Res Function(_PunctualityResponse) _then;

/// Create a copy of PunctualityResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serviceId = freezed,Object? serviceName = freezed,Object? serviceType = freezed,Object? points = null,}) {
  return _then(_PunctualityResponse(
serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,serviceName: freezed == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String?,serviceType: freezed == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<PunctualityPoint>,
  ));
}


}


/// @nodoc
mixin _$PunctualityPoint {

 int get id; String? get name; int? get entryTime; int? get exitTime; int? get eta; int? get etd;
/// Create a copy of PunctualityPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PunctualityPointCopyWith<PunctualityPoint> get copyWith => _$PunctualityPointCopyWithImpl<PunctualityPoint>(this as PunctualityPoint, _$identity);

  /// Serializes this PunctualityPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PunctualityPoint&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.entryTime, entryTime) || other.entryTime == entryTime)&&(identical(other.exitTime, exitTime) || other.exitTime == exitTime)&&(identical(other.eta, eta) || other.eta == eta)&&(identical(other.etd, etd) || other.etd == etd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,entryTime,exitTime,eta,etd);

@override
String toString() {
  return 'PunctualityPoint(id: $id, name: $name, entryTime: $entryTime, exitTime: $exitTime, eta: $eta, etd: $etd)';
}


}

/// @nodoc
abstract mixin class $PunctualityPointCopyWith<$Res>  {
  factory $PunctualityPointCopyWith(PunctualityPoint value, $Res Function(PunctualityPoint) _then) = _$PunctualityPointCopyWithImpl;
@useResult
$Res call({
 int id, String? name, int? entryTime, int? exitTime, int? eta, int? etd
});




}
/// @nodoc
class _$PunctualityPointCopyWithImpl<$Res>
    implements $PunctualityPointCopyWith<$Res> {
  _$PunctualityPointCopyWithImpl(this._self, this._then);

  final PunctualityPoint _self;
  final $Res Function(PunctualityPoint) _then;

/// Create a copy of PunctualityPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? entryTime = freezed,Object? exitTime = freezed,Object? eta = freezed,Object? etd = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,entryTime: freezed == entryTime ? _self.entryTime : entryTime // ignore: cast_nullable_to_non_nullable
as int?,exitTime: freezed == exitTime ? _self.exitTime : exitTime // ignore: cast_nullable_to_non_nullable
as int?,eta: freezed == eta ? _self.eta : eta // ignore: cast_nullable_to_non_nullable
as int?,etd: freezed == etd ? _self.etd : etd // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [PunctualityPoint].
extension PunctualityPointPatterns on PunctualityPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PunctualityPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PunctualityPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PunctualityPoint value)  $default,){
final _that = this;
switch (_that) {
case _PunctualityPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PunctualityPoint value)?  $default,){
final _that = this;
switch (_that) {
case _PunctualityPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? name,  int? entryTime,  int? exitTime,  int? eta,  int? etd)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PunctualityPoint() when $default != null:
return $default(_that.id,_that.name,_that.entryTime,_that.exitTime,_that.eta,_that.etd);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? name,  int? entryTime,  int? exitTime,  int? eta,  int? etd)  $default,) {final _that = this;
switch (_that) {
case _PunctualityPoint():
return $default(_that.id,_that.name,_that.entryTime,_that.exitTime,_that.eta,_that.etd);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? name,  int? entryTime,  int? exitTime,  int? eta,  int? etd)?  $default,) {final _that = this;
switch (_that) {
case _PunctualityPoint() when $default != null:
return $default(_that.id,_that.name,_that.entryTime,_that.exitTime,_that.eta,_that.etd);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PunctualityPoint implements PunctualityPoint {
  const _PunctualityPoint({required this.id, this.name, this.entryTime, this.exitTime, this.eta, this.etd});
  factory _PunctualityPoint.fromJson(Map<String, dynamic> json) => _$PunctualityPointFromJson(json);

@override final  int id;
@override final  String? name;
@override final  int? entryTime;
@override final  int? exitTime;
@override final  int? eta;
@override final  int? etd;

/// Create a copy of PunctualityPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PunctualityPointCopyWith<_PunctualityPoint> get copyWith => __$PunctualityPointCopyWithImpl<_PunctualityPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PunctualityPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PunctualityPoint&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.entryTime, entryTime) || other.entryTime == entryTime)&&(identical(other.exitTime, exitTime) || other.exitTime == exitTime)&&(identical(other.eta, eta) || other.eta == eta)&&(identical(other.etd, etd) || other.etd == etd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,entryTime,exitTime,eta,etd);

@override
String toString() {
  return 'PunctualityPoint(id: $id, name: $name, entryTime: $entryTime, exitTime: $exitTime, eta: $eta, etd: $etd)';
}


}

/// @nodoc
abstract mixin class _$PunctualityPointCopyWith<$Res> implements $PunctualityPointCopyWith<$Res> {
  factory _$PunctualityPointCopyWith(_PunctualityPoint value, $Res Function(_PunctualityPoint) _then) = __$PunctualityPointCopyWithImpl;
@override @useResult
$Res call({
 int id, String? name, int? entryTime, int? exitTime, int? eta, int? etd
});




}
/// @nodoc
class __$PunctualityPointCopyWithImpl<$Res>
    implements _$PunctualityPointCopyWith<$Res> {
  __$PunctualityPointCopyWithImpl(this._self, this._then);

  final _PunctualityPoint _self;
  final $Res Function(_PunctualityPoint) _then;

/// Create a copy of PunctualityPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? entryTime = freezed,Object? exitTime = freezed,Object? eta = freezed,Object? etd = freezed,}) {
  return _then(_PunctualityPoint(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,entryTime: freezed == entryTime ? _self.entryTime : entryTime // ignore: cast_nullable_to_non_nullable
as int?,exitTime: freezed == exitTime ? _self.exitTime : exitTime // ignore: cast_nullable_to_non_nullable
as int?,eta: freezed == eta ? _self.eta : eta // ignore: cast_nullable_to_non_nullable
as int?,etd: freezed == etd ? _self.etd : etd // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
