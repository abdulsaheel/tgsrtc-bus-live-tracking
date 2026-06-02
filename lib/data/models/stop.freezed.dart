// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stop.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Stop {

 String get id; String get name; String? get geozoneType;
/// Create a copy of Stop
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StopCopyWith<Stop> get copyWith => _$StopCopyWithImpl<Stop>(this as Stop, _$identity);

  /// Serializes this Stop to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Stop&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.geozoneType, geozoneType) || other.geozoneType == geozoneType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,geozoneType);

@override
String toString() {
  return 'Stop(id: $id, name: $name, geozoneType: $geozoneType)';
}


}

/// @nodoc
abstract mixin class $StopCopyWith<$Res>  {
  factory $StopCopyWith(Stop value, $Res Function(Stop) _then) = _$StopCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? geozoneType
});




}
/// @nodoc
class _$StopCopyWithImpl<$Res>
    implements $StopCopyWith<$Res> {
  _$StopCopyWithImpl(this._self, this._then);

  final Stop _self;
  final $Res Function(Stop) _then;

/// Create a copy of Stop
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? geozoneType = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,geozoneType: freezed == geozoneType ? _self.geozoneType : geozoneType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Stop].
extension StopPatterns on Stop {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Stop value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Stop() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Stop value)  $default,){
final _that = this;
switch (_that) {
case _Stop():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Stop value)?  $default,){
final _that = this;
switch (_that) {
case _Stop() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? geozoneType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Stop() when $default != null:
return $default(_that.id,_that.name,_that.geozoneType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? geozoneType)  $default,) {final _that = this;
switch (_that) {
case _Stop():
return $default(_that.id,_that.name,_that.geozoneType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? geozoneType)?  $default,) {final _that = this;
switch (_that) {
case _Stop() when $default != null:
return $default(_that.id,_that.name,_that.geozoneType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Stop implements Stop {
  const _Stop({required this.id, required this.name, this.geozoneType});
  factory _Stop.fromJson(Map<String, dynamic> json) => _$StopFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? geozoneType;

/// Create a copy of Stop
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StopCopyWith<_Stop> get copyWith => __$StopCopyWithImpl<_Stop>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StopToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Stop&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.geozoneType, geozoneType) || other.geozoneType == geozoneType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,geozoneType);

@override
String toString() {
  return 'Stop(id: $id, name: $name, geozoneType: $geozoneType)';
}


}

/// @nodoc
abstract mixin class _$StopCopyWith<$Res> implements $StopCopyWith<$Res> {
  factory _$StopCopyWith(_Stop value, $Res Function(_Stop) _then) = __$StopCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? geozoneType
});




}
/// @nodoc
class __$StopCopyWithImpl<$Res>
    implements _$StopCopyWith<$Res> {
  __$StopCopyWithImpl(this._self, this._then);

  final _Stop _self;
  final $Res Function(_Stop) _then;

/// Create a copy of Stop
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? geozoneType = freezed,}) {
  return _then(_Stop(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,geozoneType: freezed == geozoneType ? _self.geozoneType : geozoneType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$NearbyStop {

 int get id; String get name; StopGeometry? get geometry; String? get address; double? get distance; String? get geozoneType; double? get buffer; Map<String, dynamic>? get metadata;
/// Create a copy of NearbyStop
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NearbyStopCopyWith<NearbyStop> get copyWith => _$NearbyStopCopyWithImpl<NearbyStop>(this as NearbyStop, _$identity);

  /// Serializes this NearbyStop to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NearbyStop&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.geometry, geometry) || other.geometry == geometry)&&(identical(other.address, address) || other.address == address)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.geozoneType, geozoneType) || other.geozoneType == geozoneType)&&(identical(other.buffer, buffer) || other.buffer == buffer)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,geometry,address,distance,geozoneType,buffer,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'NearbyStop(id: $id, name: $name, geometry: $geometry, address: $address, distance: $distance, geozoneType: $geozoneType, buffer: $buffer, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $NearbyStopCopyWith<$Res>  {
  factory $NearbyStopCopyWith(NearbyStop value, $Res Function(NearbyStop) _then) = _$NearbyStopCopyWithImpl;
@useResult
$Res call({
 int id, String name, StopGeometry? geometry, String? address, double? distance, String? geozoneType, double? buffer, Map<String, dynamic>? metadata
});


$StopGeometryCopyWith<$Res>? get geometry;

}
/// @nodoc
class _$NearbyStopCopyWithImpl<$Res>
    implements $NearbyStopCopyWith<$Res> {
  _$NearbyStopCopyWithImpl(this._self, this._then);

  final NearbyStop _self;
  final $Res Function(NearbyStop) _then;

/// Create a copy of NearbyStop
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? geometry = freezed,Object? address = freezed,Object? distance = freezed,Object? geozoneType = freezed,Object? buffer = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,geometry: freezed == geometry ? _self.geometry : geometry // ignore: cast_nullable_to_non_nullable
as StopGeometry?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,distance: freezed == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double?,geozoneType: freezed == geozoneType ? _self.geozoneType : geozoneType // ignore: cast_nullable_to_non_nullable
as String?,buffer: freezed == buffer ? _self.buffer : buffer // ignore: cast_nullable_to_non_nullable
as double?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}
/// Create a copy of NearbyStop
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StopGeometryCopyWith<$Res>? get geometry {
    if (_self.geometry == null) {
    return null;
  }

  return $StopGeometryCopyWith<$Res>(_self.geometry!, (value) {
    return _then(_self.copyWith(geometry: value));
  });
}
}


/// Adds pattern-matching-related methods to [NearbyStop].
extension NearbyStopPatterns on NearbyStop {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NearbyStop value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NearbyStop() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NearbyStop value)  $default,){
final _that = this;
switch (_that) {
case _NearbyStop():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NearbyStop value)?  $default,){
final _that = this;
switch (_that) {
case _NearbyStop() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  StopGeometry? geometry,  String? address,  double? distance,  String? geozoneType,  double? buffer,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NearbyStop() when $default != null:
return $default(_that.id,_that.name,_that.geometry,_that.address,_that.distance,_that.geozoneType,_that.buffer,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  StopGeometry? geometry,  String? address,  double? distance,  String? geozoneType,  double? buffer,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _NearbyStop():
return $default(_that.id,_that.name,_that.geometry,_that.address,_that.distance,_that.geozoneType,_that.buffer,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  StopGeometry? geometry,  String? address,  double? distance,  String? geozoneType,  double? buffer,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _NearbyStop() when $default != null:
return $default(_that.id,_that.name,_that.geometry,_that.address,_that.distance,_that.geozoneType,_that.buffer,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NearbyStop extends NearbyStop {
  const _NearbyStop({required this.id, required this.name, this.geometry, this.address, this.distance, this.geozoneType, this.buffer, final  Map<String, dynamic>? metadata}): _metadata = metadata,super._();
  factory _NearbyStop.fromJson(Map<String, dynamic> json) => _$NearbyStopFromJson(json);

@override final  int id;
@override final  String name;
@override final  StopGeometry? geometry;
@override final  String? address;
@override final  double? distance;
@override final  String? geozoneType;
@override final  double? buffer;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of NearbyStop
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NearbyStopCopyWith<_NearbyStop> get copyWith => __$NearbyStopCopyWithImpl<_NearbyStop>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NearbyStopToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NearbyStop&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.geometry, geometry) || other.geometry == geometry)&&(identical(other.address, address) || other.address == address)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.geozoneType, geozoneType) || other.geozoneType == geozoneType)&&(identical(other.buffer, buffer) || other.buffer == buffer)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,geometry,address,distance,geozoneType,buffer,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'NearbyStop(id: $id, name: $name, geometry: $geometry, address: $address, distance: $distance, geozoneType: $geozoneType, buffer: $buffer, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$NearbyStopCopyWith<$Res> implements $NearbyStopCopyWith<$Res> {
  factory _$NearbyStopCopyWith(_NearbyStop value, $Res Function(_NearbyStop) _then) = __$NearbyStopCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, StopGeometry? geometry, String? address, double? distance, String? geozoneType, double? buffer, Map<String, dynamic>? metadata
});


@override $StopGeometryCopyWith<$Res>? get geometry;

}
/// @nodoc
class __$NearbyStopCopyWithImpl<$Res>
    implements _$NearbyStopCopyWith<$Res> {
  __$NearbyStopCopyWithImpl(this._self, this._then);

  final _NearbyStop _self;
  final $Res Function(_NearbyStop) _then;

/// Create a copy of NearbyStop
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? geometry = freezed,Object? address = freezed,Object? distance = freezed,Object? geozoneType = freezed,Object? buffer = freezed,Object? metadata = freezed,}) {
  return _then(_NearbyStop(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,geometry: freezed == geometry ? _self.geometry : geometry // ignore: cast_nullable_to_non_nullable
as StopGeometry?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,distance: freezed == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double?,geozoneType: freezed == geozoneType ? _self.geozoneType : geozoneType // ignore: cast_nullable_to_non_nullable
as String?,buffer: freezed == buffer ? _self.buffer : buffer // ignore: cast_nullable_to_non_nullable
as double?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

/// Create a copy of NearbyStop
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StopGeometryCopyWith<$Res>? get geometry {
    if (_self.geometry == null) {
    return null;
  }

  return $StopGeometryCopyWith<$Res>(_self.geometry!, (value) {
    return _then(_self.copyWith(geometry: value));
  });
}
}


/// @nodoc
mixin _$StopGeometry {

 String? get type;// Tolerant: only keep a flat [lng, lat] pair; ignore nested geometries.
@JsonKey(fromJson: _coords) List<double> get coordinates;
/// Create a copy of StopGeometry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StopGeometryCopyWith<StopGeometry> get copyWith => _$StopGeometryCopyWithImpl<StopGeometry>(this as StopGeometry, _$identity);

  /// Serializes this StopGeometry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StopGeometry&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.coordinates, coordinates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(coordinates));

@override
String toString() {
  return 'StopGeometry(type: $type, coordinates: $coordinates)';
}


}

/// @nodoc
abstract mixin class $StopGeometryCopyWith<$Res>  {
  factory $StopGeometryCopyWith(StopGeometry value, $Res Function(StopGeometry) _then) = _$StopGeometryCopyWithImpl;
@useResult
$Res call({
 String? type,@JsonKey(fromJson: _coords) List<double> coordinates
});




}
/// @nodoc
class _$StopGeometryCopyWithImpl<$Res>
    implements $StopGeometryCopyWith<$Res> {
  _$StopGeometryCopyWithImpl(this._self, this._then);

  final StopGeometry _self;
  final $Res Function(StopGeometry) _then;

/// Create a copy of StopGeometry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? coordinates = null,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,coordinates: null == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}

}


/// Adds pattern-matching-related methods to [StopGeometry].
extension StopGeometryPatterns on StopGeometry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StopGeometry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StopGeometry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StopGeometry value)  $default,){
final _that = this;
switch (_that) {
case _StopGeometry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StopGeometry value)?  $default,){
final _that = this;
switch (_that) {
case _StopGeometry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? type, @JsonKey(fromJson: _coords)  List<double> coordinates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StopGeometry() when $default != null:
return $default(_that.type,_that.coordinates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? type, @JsonKey(fromJson: _coords)  List<double> coordinates)  $default,) {final _that = this;
switch (_that) {
case _StopGeometry():
return $default(_that.type,_that.coordinates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? type, @JsonKey(fromJson: _coords)  List<double> coordinates)?  $default,) {final _that = this;
switch (_that) {
case _StopGeometry() when $default != null:
return $default(_that.type,_that.coordinates);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StopGeometry implements StopGeometry {
  const _StopGeometry({this.type, @JsonKey(fromJson: _coords) final  List<double> coordinates = const <double>[]}): _coordinates = coordinates;
  factory _StopGeometry.fromJson(Map<String, dynamic> json) => _$StopGeometryFromJson(json);

@override final  String? type;
// Tolerant: only keep a flat [lng, lat] pair; ignore nested geometries.
 final  List<double> _coordinates;
// Tolerant: only keep a flat [lng, lat] pair; ignore nested geometries.
@override@JsonKey(fromJson: _coords) List<double> get coordinates {
  if (_coordinates is EqualUnmodifiableListView) return _coordinates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_coordinates);
}


/// Create a copy of StopGeometry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StopGeometryCopyWith<_StopGeometry> get copyWith => __$StopGeometryCopyWithImpl<_StopGeometry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StopGeometryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StopGeometry&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._coordinates, _coordinates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(_coordinates));

@override
String toString() {
  return 'StopGeometry(type: $type, coordinates: $coordinates)';
}


}

/// @nodoc
abstract mixin class _$StopGeometryCopyWith<$Res> implements $StopGeometryCopyWith<$Res> {
  factory _$StopGeometryCopyWith(_StopGeometry value, $Res Function(_StopGeometry) _then) = __$StopGeometryCopyWithImpl;
@override @useResult
$Res call({
 String? type,@JsonKey(fromJson: _coords) List<double> coordinates
});




}
/// @nodoc
class __$StopGeometryCopyWithImpl<$Res>
    implements _$StopGeometryCopyWith<$Res> {
  __$StopGeometryCopyWithImpl(this._self, this._then);

  final _StopGeometry _self;
  final $Res Function(_StopGeometry) _then;

/// Create a copy of StopGeometry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? coordinates = null,}) {
  return _then(_StopGeometry(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,coordinates: null == coordinates ? _self._coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}


}

// dart format on
