// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PolylinePoint {

 double get lat; double get lng;
/// Create a copy of PolylinePoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PolylinePointCopyWith<PolylinePoint> get copyWith => _$PolylinePointCopyWithImpl<PolylinePoint>(this as PolylinePoint, _$identity);

  /// Serializes this PolylinePoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PolylinePoint&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lat,lng);

@override
String toString() {
  return 'PolylinePoint(lat: $lat, lng: $lng)';
}


}

/// @nodoc
abstract mixin class $PolylinePointCopyWith<$Res>  {
  factory $PolylinePointCopyWith(PolylinePoint value, $Res Function(PolylinePoint) _then) = _$PolylinePointCopyWithImpl;
@useResult
$Res call({
 double lat, double lng
});




}
/// @nodoc
class _$PolylinePointCopyWithImpl<$Res>
    implements $PolylinePointCopyWith<$Res> {
  _$PolylinePointCopyWithImpl(this._self, this._then);

  final PolylinePoint _self;
  final $Res Function(PolylinePoint) _then;

/// Create a copy of PolylinePoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lat = null,Object? lng = null,}) {
  return _then(_self.copyWith(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PolylinePoint].
extension PolylinePointPatterns on PolylinePoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PolylinePoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PolylinePoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PolylinePoint value)  $default,){
final _that = this;
switch (_that) {
case _PolylinePoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PolylinePoint value)?  $default,){
final _that = this;
switch (_that) {
case _PolylinePoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double lat,  double lng)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PolylinePoint() when $default != null:
return $default(_that.lat,_that.lng);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double lat,  double lng)  $default,) {final _that = this;
switch (_that) {
case _PolylinePoint():
return $default(_that.lat,_that.lng);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double lat,  double lng)?  $default,) {final _that = this;
switch (_that) {
case _PolylinePoint() when $default != null:
return $default(_that.lat,_that.lng);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PolylinePoint implements PolylinePoint {
  const _PolylinePoint({required this.lat, required this.lng});
  factory _PolylinePoint.fromJson(Map<String, dynamic> json) => _$PolylinePointFromJson(json);

@override final  double lat;
@override final  double lng;

/// Create a copy of PolylinePoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PolylinePointCopyWith<_PolylinePoint> get copyWith => __$PolylinePointCopyWithImpl<_PolylinePoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PolylinePointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PolylinePoint&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lat,lng);

@override
String toString() {
  return 'PolylinePoint(lat: $lat, lng: $lng)';
}


}

/// @nodoc
abstract mixin class _$PolylinePointCopyWith<$Res> implements $PolylinePointCopyWith<$Res> {
  factory _$PolylinePointCopyWith(_PolylinePoint value, $Res Function(_PolylinePoint) _then) = __$PolylinePointCopyWithImpl;
@override @useResult
$Res call({
 double lat, double lng
});




}
/// @nodoc
class __$PolylinePointCopyWithImpl<$Res>
    implements _$PolylinePointCopyWith<$Res> {
  __$PolylinePointCopyWithImpl(this._self, this._then);

  final _PolylinePoint _self;
  final $Res Function(_PolylinePoint) _then;

/// Create a copy of PolylinePoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lat = null,Object? lng = null,}) {
  return _then(_PolylinePoint(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$PointGeometry {

 String? get type;// Tolerant: only keep a flat [lng, lat] pair; ignore nested geometries.
@JsonKey(fromJson: _coords) List<double> get coordinates; String? get address;
/// Create a copy of PointGeometry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PointGeometryCopyWith<PointGeometry> get copyWith => _$PointGeometryCopyWithImpl<PointGeometry>(this as PointGeometry, _$identity);

  /// Serializes this PointGeometry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PointGeometry&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.coordinates, coordinates)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(coordinates),address);

@override
String toString() {
  return 'PointGeometry(type: $type, coordinates: $coordinates, address: $address)';
}


}

/// @nodoc
abstract mixin class $PointGeometryCopyWith<$Res>  {
  factory $PointGeometryCopyWith(PointGeometry value, $Res Function(PointGeometry) _then) = _$PointGeometryCopyWithImpl;
@useResult
$Res call({
 String? type,@JsonKey(fromJson: _coords) List<double> coordinates, String? address
});




}
/// @nodoc
class _$PointGeometryCopyWithImpl<$Res>
    implements $PointGeometryCopyWith<$Res> {
  _$PointGeometryCopyWithImpl(this._self, this._then);

  final PointGeometry _self;
  final $Res Function(PointGeometry) _then;

/// Create a copy of PointGeometry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? coordinates = null,Object? address = freezed,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,coordinates: null == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as List<double>,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PointGeometry].
extension PointGeometryPatterns on PointGeometry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PointGeometry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PointGeometry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PointGeometry value)  $default,){
final _that = this;
switch (_that) {
case _PointGeometry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PointGeometry value)?  $default,){
final _that = this;
switch (_that) {
case _PointGeometry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? type, @JsonKey(fromJson: _coords)  List<double> coordinates,  String? address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PointGeometry() when $default != null:
return $default(_that.type,_that.coordinates,_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? type, @JsonKey(fromJson: _coords)  List<double> coordinates,  String? address)  $default,) {final _that = this;
switch (_that) {
case _PointGeometry():
return $default(_that.type,_that.coordinates,_that.address);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? type, @JsonKey(fromJson: _coords)  List<double> coordinates,  String? address)?  $default,) {final _that = this;
switch (_that) {
case _PointGeometry() when $default != null:
return $default(_that.type,_that.coordinates,_that.address);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PointGeometry implements PointGeometry {
  const _PointGeometry({this.type, @JsonKey(fromJson: _coords) final  List<double> coordinates = const <double>[], this.address}): _coordinates = coordinates;
  factory _PointGeometry.fromJson(Map<String, dynamic> json) => _$PointGeometryFromJson(json);

@override final  String? type;
// Tolerant: only keep a flat [lng, lat] pair; ignore nested geometries.
 final  List<double> _coordinates;
// Tolerant: only keep a flat [lng, lat] pair; ignore nested geometries.
@override@JsonKey(fromJson: _coords) List<double> get coordinates {
  if (_coordinates is EqualUnmodifiableListView) return _coordinates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_coordinates);
}

@override final  String? address;

/// Create a copy of PointGeometry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PointGeometryCopyWith<_PointGeometry> get copyWith => __$PointGeometryCopyWithImpl<_PointGeometry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PointGeometryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PointGeometry&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._coordinates, _coordinates)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(_coordinates),address);

@override
String toString() {
  return 'PointGeometry(type: $type, coordinates: $coordinates, address: $address)';
}


}

/// @nodoc
abstract mixin class _$PointGeometryCopyWith<$Res> implements $PointGeometryCopyWith<$Res> {
  factory _$PointGeometryCopyWith(_PointGeometry value, $Res Function(_PointGeometry) _then) = __$PointGeometryCopyWithImpl;
@override @useResult
$Res call({
 String? type,@JsonKey(fromJson: _coords) List<double> coordinates, String? address
});




}
/// @nodoc
class __$PointGeometryCopyWithImpl<$Res>
    implements _$PointGeometryCopyWith<$Res> {
  __$PointGeometryCopyWithImpl(this._self, this._then);

  final _PointGeometry _self;
  final $Res Function(_PointGeometry) _then;

/// Create a copy of PointGeometry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? coordinates = null,Object? address = freezed,}) {
  return _then(_PointGeometry(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,coordinates: null == coordinates ? _self._coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as List<double>,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TripPoint {

 int get id; String get name; int get sequence; int? get eta; int? get etd; int? get plannedTime; int? get plannedExitTime; int? get entryTime; int? get exitTime;@JsonKey(name: 'myRoute') bool get onRoute; PointGeometry? get geometry;
/// Create a copy of TripPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripPointCopyWith<TripPoint> get copyWith => _$TripPointCopyWithImpl<TripPoint>(this as TripPoint, _$identity);

  /// Serializes this TripPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripPoint&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sequence, sequence) || other.sequence == sequence)&&(identical(other.eta, eta) || other.eta == eta)&&(identical(other.etd, etd) || other.etd == etd)&&(identical(other.plannedTime, plannedTime) || other.plannedTime == plannedTime)&&(identical(other.plannedExitTime, plannedExitTime) || other.plannedExitTime == plannedExitTime)&&(identical(other.entryTime, entryTime) || other.entryTime == entryTime)&&(identical(other.exitTime, exitTime) || other.exitTime == exitTime)&&(identical(other.onRoute, onRoute) || other.onRoute == onRoute)&&(identical(other.geometry, geometry) || other.geometry == geometry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,sequence,eta,etd,plannedTime,plannedExitTime,entryTime,exitTime,onRoute,geometry);

@override
String toString() {
  return 'TripPoint(id: $id, name: $name, sequence: $sequence, eta: $eta, etd: $etd, plannedTime: $plannedTime, plannedExitTime: $plannedExitTime, entryTime: $entryTime, exitTime: $exitTime, onRoute: $onRoute, geometry: $geometry)';
}


}

/// @nodoc
abstract mixin class $TripPointCopyWith<$Res>  {
  factory $TripPointCopyWith(TripPoint value, $Res Function(TripPoint) _then) = _$TripPointCopyWithImpl;
@useResult
$Res call({
 int id, String name, int sequence, int? eta, int? etd, int? plannedTime, int? plannedExitTime, int? entryTime, int? exitTime,@JsonKey(name: 'myRoute') bool onRoute, PointGeometry? geometry
});


$PointGeometryCopyWith<$Res>? get geometry;

}
/// @nodoc
class _$TripPointCopyWithImpl<$Res>
    implements $TripPointCopyWith<$Res> {
  _$TripPointCopyWithImpl(this._self, this._then);

  final TripPoint _self;
  final $Res Function(TripPoint) _then;

/// Create a copy of TripPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? sequence = null,Object? eta = freezed,Object? etd = freezed,Object? plannedTime = freezed,Object? plannedExitTime = freezed,Object? entryTime = freezed,Object? exitTime = freezed,Object? onRoute = null,Object? geometry = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sequence: null == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as int,eta: freezed == eta ? _self.eta : eta // ignore: cast_nullable_to_non_nullable
as int?,etd: freezed == etd ? _self.etd : etd // ignore: cast_nullable_to_non_nullable
as int?,plannedTime: freezed == plannedTime ? _self.plannedTime : plannedTime // ignore: cast_nullable_to_non_nullable
as int?,plannedExitTime: freezed == plannedExitTime ? _self.plannedExitTime : plannedExitTime // ignore: cast_nullable_to_non_nullable
as int?,entryTime: freezed == entryTime ? _self.entryTime : entryTime // ignore: cast_nullable_to_non_nullable
as int?,exitTime: freezed == exitTime ? _self.exitTime : exitTime // ignore: cast_nullable_to_non_nullable
as int?,onRoute: null == onRoute ? _self.onRoute : onRoute // ignore: cast_nullable_to_non_nullable
as bool,geometry: freezed == geometry ? _self.geometry : geometry // ignore: cast_nullable_to_non_nullable
as PointGeometry?,
  ));
}
/// Create a copy of TripPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PointGeometryCopyWith<$Res>? get geometry {
    if (_self.geometry == null) {
    return null;
  }

  return $PointGeometryCopyWith<$Res>(_self.geometry!, (value) {
    return _then(_self.copyWith(geometry: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripPoint].
extension TripPointPatterns on TripPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripPoint value)  $default,){
final _that = this;
switch (_that) {
case _TripPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripPoint value)?  $default,){
final _that = this;
switch (_that) {
case _TripPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  int sequence,  int? eta,  int? etd,  int? plannedTime,  int? plannedExitTime,  int? entryTime,  int? exitTime, @JsonKey(name: 'myRoute')  bool onRoute,  PointGeometry? geometry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripPoint() when $default != null:
return $default(_that.id,_that.name,_that.sequence,_that.eta,_that.etd,_that.plannedTime,_that.plannedExitTime,_that.entryTime,_that.exitTime,_that.onRoute,_that.geometry);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  int sequence,  int? eta,  int? etd,  int? plannedTime,  int? plannedExitTime,  int? entryTime,  int? exitTime, @JsonKey(name: 'myRoute')  bool onRoute,  PointGeometry? geometry)  $default,) {final _that = this;
switch (_that) {
case _TripPoint():
return $default(_that.id,_that.name,_that.sequence,_that.eta,_that.etd,_that.plannedTime,_that.plannedExitTime,_that.entryTime,_that.exitTime,_that.onRoute,_that.geometry);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  int sequence,  int? eta,  int? etd,  int? plannedTime,  int? plannedExitTime,  int? entryTime,  int? exitTime, @JsonKey(name: 'myRoute')  bool onRoute,  PointGeometry? geometry)?  $default,) {final _that = this;
switch (_that) {
case _TripPoint() when $default != null:
return $default(_that.id,_that.name,_that.sequence,_that.eta,_that.etd,_that.plannedTime,_that.plannedExitTime,_that.entryTime,_that.exitTime,_that.onRoute,_that.geometry);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripPoint extends TripPoint {
  const _TripPoint({required this.id, required this.name, this.sequence = 0, this.eta, this.etd, this.plannedTime, this.plannedExitTime, this.entryTime, this.exitTime, @JsonKey(name: 'myRoute') this.onRoute = false, this.geometry}): super._();
  factory _TripPoint.fromJson(Map<String, dynamic> json) => _$TripPointFromJson(json);

@override final  int id;
@override final  String name;
@override@JsonKey() final  int sequence;
@override final  int? eta;
@override final  int? etd;
@override final  int? plannedTime;
@override final  int? plannedExitTime;
@override final  int? entryTime;
@override final  int? exitTime;
@override@JsonKey(name: 'myRoute') final  bool onRoute;
@override final  PointGeometry? geometry;

/// Create a copy of TripPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripPointCopyWith<_TripPoint> get copyWith => __$TripPointCopyWithImpl<_TripPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripPoint&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sequence, sequence) || other.sequence == sequence)&&(identical(other.eta, eta) || other.eta == eta)&&(identical(other.etd, etd) || other.etd == etd)&&(identical(other.plannedTime, plannedTime) || other.plannedTime == plannedTime)&&(identical(other.plannedExitTime, plannedExitTime) || other.plannedExitTime == plannedExitTime)&&(identical(other.entryTime, entryTime) || other.entryTime == entryTime)&&(identical(other.exitTime, exitTime) || other.exitTime == exitTime)&&(identical(other.onRoute, onRoute) || other.onRoute == onRoute)&&(identical(other.geometry, geometry) || other.geometry == geometry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,sequence,eta,etd,plannedTime,plannedExitTime,entryTime,exitTime,onRoute,geometry);

@override
String toString() {
  return 'TripPoint(id: $id, name: $name, sequence: $sequence, eta: $eta, etd: $etd, plannedTime: $plannedTime, plannedExitTime: $plannedExitTime, entryTime: $entryTime, exitTime: $exitTime, onRoute: $onRoute, geometry: $geometry)';
}


}

/// @nodoc
abstract mixin class _$TripPointCopyWith<$Res> implements $TripPointCopyWith<$Res> {
  factory _$TripPointCopyWith(_TripPoint value, $Res Function(_TripPoint) _then) = __$TripPointCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int sequence, int? eta, int? etd, int? plannedTime, int? plannedExitTime, int? entryTime, int? exitTime,@JsonKey(name: 'myRoute') bool onRoute, PointGeometry? geometry
});


@override $PointGeometryCopyWith<$Res>? get geometry;

}
/// @nodoc
class __$TripPointCopyWithImpl<$Res>
    implements _$TripPointCopyWith<$Res> {
  __$TripPointCopyWithImpl(this._self, this._then);

  final _TripPoint _self;
  final $Res Function(_TripPoint) _then;

/// Create a copy of TripPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? sequence = null,Object? eta = freezed,Object? etd = freezed,Object? plannedTime = freezed,Object? plannedExitTime = freezed,Object? entryTime = freezed,Object? exitTime = freezed,Object? onRoute = null,Object? geometry = freezed,}) {
  return _then(_TripPoint(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sequence: null == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as int,eta: freezed == eta ? _self.eta : eta // ignore: cast_nullable_to_non_nullable
as int?,etd: freezed == etd ? _self.etd : etd // ignore: cast_nullable_to_non_nullable
as int?,plannedTime: freezed == plannedTime ? _self.plannedTime : plannedTime // ignore: cast_nullable_to_non_nullable
as int?,plannedExitTime: freezed == plannedExitTime ? _self.plannedExitTime : plannedExitTime // ignore: cast_nullable_to_non_nullable
as int?,entryTime: freezed == entryTime ? _self.entryTime : entryTime // ignore: cast_nullable_to_non_nullable
as int?,exitTime: freezed == exitTime ? _self.exitTime : exitTime // ignore: cast_nullable_to_non_nullable
as int?,onRoute: null == onRoute ? _self.onRoute : onRoute // ignore: cast_nullable_to_non_nullable
as bool,geometry: freezed == geometry ? _self.geometry : geometry // ignore: cast_nullable_to_non_nullable
as PointGeometry?,
  ));
}

/// Create a copy of TripPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PointGeometryCopyWith<$Res>? get geometry {
    if (_self.geometry == null) {
    return null;
  }

  return $PointGeometryCopyWith<$Res>(_self.geometry!, (value) {
    return _then(_self.copyWith(geometry: value));
  });
}
}


/// @nodoc
mixin _$TripDetail {

 int get id; int? get vehicleId; String? get vehicleNumber; int? get serviceId; String? get serviceName; String? get serviceType; String? get depotName; String? get driverName; String? get driverMobile; String? get helpline; int? get duration; int? get plannedStartTime; int? get plannedEndTime; int? get status; String? get statusStr; List<TripPoint> get points; List<PolylinePoint> get polylinePoints;
/// Create a copy of TripDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripDetailCopyWith<TripDetail> get copyWith => _$TripDetailCopyWithImpl<TripDetail>(this as TripDetail, _$identity);

  /// Serializes this TripDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.vehicleNumber, vehicleNumber) || other.vehicleNumber == vehicleNumber)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.depotName, depotName) || other.depotName == depotName)&&(identical(other.driverName, driverName) || other.driverName == driverName)&&(identical(other.driverMobile, driverMobile) || other.driverMobile == driverMobile)&&(identical(other.helpline, helpline) || other.helpline == helpline)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.plannedStartTime, plannedStartTime) || other.plannedStartTime == plannedStartTime)&&(identical(other.plannedEndTime, plannedEndTime) || other.plannedEndTime == plannedEndTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusStr, statusStr) || other.statusStr == statusStr)&&const DeepCollectionEquality().equals(other.points, points)&&const DeepCollectionEquality().equals(other.polylinePoints, polylinePoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,vehicleId,vehicleNumber,serviceId,serviceName,serviceType,depotName,driverName,driverMobile,helpline,duration,plannedStartTime,plannedEndTime,status,statusStr,const DeepCollectionEquality().hash(points),const DeepCollectionEquality().hash(polylinePoints));

@override
String toString() {
  return 'TripDetail(id: $id, vehicleId: $vehicleId, vehicleNumber: $vehicleNumber, serviceId: $serviceId, serviceName: $serviceName, serviceType: $serviceType, depotName: $depotName, driverName: $driverName, driverMobile: $driverMobile, helpline: $helpline, duration: $duration, plannedStartTime: $plannedStartTime, plannedEndTime: $plannedEndTime, status: $status, statusStr: $statusStr, points: $points, polylinePoints: $polylinePoints)';
}


}

/// @nodoc
abstract mixin class $TripDetailCopyWith<$Res>  {
  factory $TripDetailCopyWith(TripDetail value, $Res Function(TripDetail) _then) = _$TripDetailCopyWithImpl;
@useResult
$Res call({
 int id, int? vehicleId, String? vehicleNumber, int? serviceId, String? serviceName, String? serviceType, String? depotName, String? driverName, String? driverMobile, String? helpline, int? duration, int? plannedStartTime, int? plannedEndTime, int? status, String? statusStr, List<TripPoint> points, List<PolylinePoint> polylinePoints
});




}
/// @nodoc
class _$TripDetailCopyWithImpl<$Res>
    implements $TripDetailCopyWith<$Res> {
  _$TripDetailCopyWithImpl(this._self, this._then);

  final TripDetail _self;
  final $Res Function(TripDetail) _then;

/// Create a copy of TripDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? vehicleId = freezed,Object? vehicleNumber = freezed,Object? serviceId = freezed,Object? serviceName = freezed,Object? serviceType = freezed,Object? depotName = freezed,Object? driverName = freezed,Object? driverMobile = freezed,Object? helpline = freezed,Object? duration = freezed,Object? plannedStartTime = freezed,Object? plannedEndTime = freezed,Object? status = freezed,Object? statusStr = freezed,Object? points = null,Object? polylinePoints = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,vehicleId: freezed == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as int?,vehicleNumber: freezed == vehicleNumber ? _self.vehicleNumber : vehicleNumber // ignore: cast_nullable_to_non_nullable
as String?,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,serviceName: freezed == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String?,serviceType: freezed == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String?,depotName: freezed == depotName ? _self.depotName : depotName // ignore: cast_nullable_to_non_nullable
as String?,driverName: freezed == driverName ? _self.driverName : driverName // ignore: cast_nullable_to_non_nullable
as String?,driverMobile: freezed == driverMobile ? _self.driverMobile : driverMobile // ignore: cast_nullable_to_non_nullable
as String?,helpline: freezed == helpline ? _self.helpline : helpline // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,plannedStartTime: freezed == plannedStartTime ? _self.plannedStartTime : plannedStartTime // ignore: cast_nullable_to_non_nullable
as int?,plannedEndTime: freezed == plannedEndTime ? _self.plannedEndTime : plannedEndTime // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,statusStr: freezed == statusStr ? _self.statusStr : statusStr // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<TripPoint>,polylinePoints: null == polylinePoints ? _self.polylinePoints : polylinePoints // ignore: cast_nullable_to_non_nullable
as List<PolylinePoint>,
  ));
}

}


/// Adds pattern-matching-related methods to [TripDetail].
extension TripDetailPatterns on TripDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripDetail value)  $default,){
final _that = this;
switch (_that) {
case _TripDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripDetail value)?  $default,){
final _that = this;
switch (_that) {
case _TripDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? vehicleId,  String? vehicleNumber,  int? serviceId,  String? serviceName,  String? serviceType,  String? depotName,  String? driverName,  String? driverMobile,  String? helpline,  int? duration,  int? plannedStartTime,  int? plannedEndTime,  int? status,  String? statusStr,  List<TripPoint> points,  List<PolylinePoint> polylinePoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripDetail() when $default != null:
return $default(_that.id,_that.vehicleId,_that.vehicleNumber,_that.serviceId,_that.serviceName,_that.serviceType,_that.depotName,_that.driverName,_that.driverMobile,_that.helpline,_that.duration,_that.plannedStartTime,_that.plannedEndTime,_that.status,_that.statusStr,_that.points,_that.polylinePoints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? vehicleId,  String? vehicleNumber,  int? serviceId,  String? serviceName,  String? serviceType,  String? depotName,  String? driverName,  String? driverMobile,  String? helpline,  int? duration,  int? plannedStartTime,  int? plannedEndTime,  int? status,  String? statusStr,  List<TripPoint> points,  List<PolylinePoint> polylinePoints)  $default,) {final _that = this;
switch (_that) {
case _TripDetail():
return $default(_that.id,_that.vehicleId,_that.vehicleNumber,_that.serviceId,_that.serviceName,_that.serviceType,_that.depotName,_that.driverName,_that.driverMobile,_that.helpline,_that.duration,_that.plannedStartTime,_that.plannedEndTime,_that.status,_that.statusStr,_that.points,_that.polylinePoints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? vehicleId,  String? vehicleNumber,  int? serviceId,  String? serviceName,  String? serviceType,  String? depotName,  String? driverName,  String? driverMobile,  String? helpline,  int? duration,  int? plannedStartTime,  int? plannedEndTime,  int? status,  String? statusStr,  List<TripPoint> points,  List<PolylinePoint> polylinePoints)?  $default,) {final _that = this;
switch (_that) {
case _TripDetail() when $default != null:
return $default(_that.id,_that.vehicleId,_that.vehicleNumber,_that.serviceId,_that.serviceName,_that.serviceType,_that.depotName,_that.driverName,_that.driverMobile,_that.helpline,_that.duration,_that.plannedStartTime,_that.plannedEndTime,_that.status,_that.statusStr,_that.points,_that.polylinePoints);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripDetail implements TripDetail {
  const _TripDetail({required this.id, this.vehicleId, this.vehicleNumber, this.serviceId, this.serviceName, this.serviceType, this.depotName, this.driverName, this.driverMobile, this.helpline, this.duration, this.plannedStartTime, this.plannedEndTime, this.status, this.statusStr, final  List<TripPoint> points = const <TripPoint>[], final  List<PolylinePoint> polylinePoints = const <PolylinePoint>[]}): _points = points,_polylinePoints = polylinePoints;
  factory _TripDetail.fromJson(Map<String, dynamic> json) => _$TripDetailFromJson(json);

@override final  int id;
@override final  int? vehicleId;
@override final  String? vehicleNumber;
@override final  int? serviceId;
@override final  String? serviceName;
@override final  String? serviceType;
@override final  String? depotName;
@override final  String? driverName;
@override final  String? driverMobile;
@override final  String? helpline;
@override final  int? duration;
@override final  int? plannedStartTime;
@override final  int? plannedEndTime;
@override final  int? status;
@override final  String? statusStr;
 final  List<TripPoint> _points;
@override@JsonKey() List<TripPoint> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

 final  List<PolylinePoint> _polylinePoints;
@override@JsonKey() List<PolylinePoint> get polylinePoints {
  if (_polylinePoints is EqualUnmodifiableListView) return _polylinePoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_polylinePoints);
}


/// Create a copy of TripDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripDetailCopyWith<_TripDetail> get copyWith => __$TripDetailCopyWithImpl<_TripDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.vehicleNumber, vehicleNumber) || other.vehicleNumber == vehicleNumber)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.depotName, depotName) || other.depotName == depotName)&&(identical(other.driverName, driverName) || other.driverName == driverName)&&(identical(other.driverMobile, driverMobile) || other.driverMobile == driverMobile)&&(identical(other.helpline, helpline) || other.helpline == helpline)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.plannedStartTime, plannedStartTime) || other.plannedStartTime == plannedStartTime)&&(identical(other.plannedEndTime, plannedEndTime) || other.plannedEndTime == plannedEndTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusStr, statusStr) || other.statusStr == statusStr)&&const DeepCollectionEquality().equals(other._points, _points)&&const DeepCollectionEquality().equals(other._polylinePoints, _polylinePoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,vehicleId,vehicleNumber,serviceId,serviceName,serviceType,depotName,driverName,driverMobile,helpline,duration,plannedStartTime,plannedEndTime,status,statusStr,const DeepCollectionEquality().hash(_points),const DeepCollectionEquality().hash(_polylinePoints));

@override
String toString() {
  return 'TripDetail(id: $id, vehicleId: $vehicleId, vehicleNumber: $vehicleNumber, serviceId: $serviceId, serviceName: $serviceName, serviceType: $serviceType, depotName: $depotName, driverName: $driverName, driverMobile: $driverMobile, helpline: $helpline, duration: $duration, plannedStartTime: $plannedStartTime, plannedEndTime: $plannedEndTime, status: $status, statusStr: $statusStr, points: $points, polylinePoints: $polylinePoints)';
}


}

/// @nodoc
abstract mixin class _$TripDetailCopyWith<$Res> implements $TripDetailCopyWith<$Res> {
  factory _$TripDetailCopyWith(_TripDetail value, $Res Function(_TripDetail) _then) = __$TripDetailCopyWithImpl;
@override @useResult
$Res call({
 int id, int? vehicleId, String? vehicleNumber, int? serviceId, String? serviceName, String? serviceType, String? depotName, String? driverName, String? driverMobile, String? helpline, int? duration, int? plannedStartTime, int? plannedEndTime, int? status, String? statusStr, List<TripPoint> points, List<PolylinePoint> polylinePoints
});




}
/// @nodoc
class __$TripDetailCopyWithImpl<$Res>
    implements _$TripDetailCopyWith<$Res> {
  __$TripDetailCopyWithImpl(this._self, this._then);

  final _TripDetail _self;
  final $Res Function(_TripDetail) _then;

/// Create a copy of TripDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? vehicleId = freezed,Object? vehicleNumber = freezed,Object? serviceId = freezed,Object? serviceName = freezed,Object? serviceType = freezed,Object? depotName = freezed,Object? driverName = freezed,Object? driverMobile = freezed,Object? helpline = freezed,Object? duration = freezed,Object? plannedStartTime = freezed,Object? plannedEndTime = freezed,Object? status = freezed,Object? statusStr = freezed,Object? points = null,Object? polylinePoints = null,}) {
  return _then(_TripDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,vehicleId: freezed == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as int?,vehicleNumber: freezed == vehicleNumber ? _self.vehicleNumber : vehicleNumber // ignore: cast_nullable_to_non_nullable
as String?,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,serviceName: freezed == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String?,serviceType: freezed == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String?,depotName: freezed == depotName ? _self.depotName : depotName // ignore: cast_nullable_to_non_nullable
as String?,driverName: freezed == driverName ? _self.driverName : driverName // ignore: cast_nullable_to_non_nullable
as String?,driverMobile: freezed == driverMobile ? _self.driverMobile : driverMobile // ignore: cast_nullable_to_non_nullable
as String?,helpline: freezed == helpline ? _self.helpline : helpline // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,plannedStartTime: freezed == plannedStartTime ? _self.plannedStartTime : plannedStartTime // ignore: cast_nullable_to_non_nullable
as int?,plannedEndTime: freezed == plannedEndTime ? _self.plannedEndTime : plannedEndTime // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,statusStr: freezed == statusStr ? _self.statusStr : statusStr // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<TripPoint>,polylinePoints: null == polylinePoints ? _self._polylinePoints : polylinePoints // ignore: cast_nullable_to_non_nullable
as List<PolylinePoint>,
  ));
}


}

// dart format on
