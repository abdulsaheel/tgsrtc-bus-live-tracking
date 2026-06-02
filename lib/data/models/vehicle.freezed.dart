// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Vehicle {

 int get id; String get name; String? get registrationNumber; String? get serviceType; int? get operationType;
/// Create a copy of Vehicle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehicleCopyWith<Vehicle> get copyWith => _$VehicleCopyWithImpl<Vehicle>(this as Vehicle, _$identity);

  /// Serializes this Vehicle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Vehicle&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.operationType, operationType) || other.operationType == operationType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,registrationNumber,serviceType,operationType);

@override
String toString() {
  return 'Vehicle(id: $id, name: $name, registrationNumber: $registrationNumber, serviceType: $serviceType, operationType: $operationType)';
}


}

/// @nodoc
abstract mixin class $VehicleCopyWith<$Res>  {
  factory $VehicleCopyWith(Vehicle value, $Res Function(Vehicle) _then) = _$VehicleCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? registrationNumber, String? serviceType, int? operationType
});




}
/// @nodoc
class _$VehicleCopyWithImpl<$Res>
    implements $VehicleCopyWith<$Res> {
  _$VehicleCopyWithImpl(this._self, this._then);

  final Vehicle _self;
  final $Res Function(Vehicle) _then;

/// Create a copy of Vehicle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? registrationNumber = freezed,Object? serviceType = freezed,Object? operationType = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,registrationNumber: freezed == registrationNumber ? _self.registrationNumber : registrationNumber // ignore: cast_nullable_to_non_nullable
as String?,serviceType: freezed == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String?,operationType: freezed == operationType ? _self.operationType : operationType // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Vehicle].
extension VehiclePatterns on Vehicle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Vehicle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Vehicle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Vehicle value)  $default,){
final _that = this;
switch (_that) {
case _Vehicle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Vehicle value)?  $default,){
final _that = this;
switch (_that) {
case _Vehicle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? registrationNumber,  String? serviceType,  int? operationType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Vehicle() when $default != null:
return $default(_that.id,_that.name,_that.registrationNumber,_that.serviceType,_that.operationType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? registrationNumber,  String? serviceType,  int? operationType)  $default,) {final _that = this;
switch (_that) {
case _Vehicle():
return $default(_that.id,_that.name,_that.registrationNumber,_that.serviceType,_that.operationType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? registrationNumber,  String? serviceType,  int? operationType)?  $default,) {final _that = this;
switch (_that) {
case _Vehicle() when $default != null:
return $default(_that.id,_that.name,_that.registrationNumber,_that.serviceType,_that.operationType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Vehicle implements Vehicle {
  const _Vehicle({required this.id, required this.name, this.registrationNumber, this.serviceType, this.operationType});
  factory _Vehicle.fromJson(Map<String, dynamic> json) => _$VehicleFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? registrationNumber;
@override final  String? serviceType;
@override final  int? operationType;

/// Create a copy of Vehicle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehicleCopyWith<_Vehicle> get copyWith => __$VehicleCopyWithImpl<_Vehicle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VehicleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Vehicle&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.operationType, operationType) || other.operationType == operationType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,registrationNumber,serviceType,operationType);

@override
String toString() {
  return 'Vehicle(id: $id, name: $name, registrationNumber: $registrationNumber, serviceType: $serviceType, operationType: $operationType)';
}


}

/// @nodoc
abstract mixin class _$VehicleCopyWith<$Res> implements $VehicleCopyWith<$Res> {
  factory _$VehicleCopyWith(_Vehicle value, $Res Function(_Vehicle) _then) = __$VehicleCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? registrationNumber, String? serviceType, int? operationType
});




}
/// @nodoc
class __$VehicleCopyWithImpl<$Res>
    implements _$VehicleCopyWith<$Res> {
  __$VehicleCopyWithImpl(this._self, this._then);

  final _Vehicle _self;
  final $Res Function(_Vehicle) _then;

/// Create a copy of Vehicle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? registrationNumber = freezed,Object? serviceType = freezed,Object? operationType = freezed,}) {
  return _then(_Vehicle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,registrationNumber: freezed == registrationNumber ? _self.registrationNumber : registrationNumber // ignore: cast_nullable_to_non_nullable
as String?,serviceType: freezed == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String?,operationType: freezed == operationType ? _self.operationType : operationType // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
