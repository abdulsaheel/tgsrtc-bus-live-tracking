// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bus_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BusService {

 int get id; String get name; String? get serviceType; String? get routeNumber;
/// Create a copy of BusService
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusServiceCopyWith<BusService> get copyWith => _$BusServiceCopyWithImpl<BusService>(this as BusService, _$identity);

  /// Serializes this BusService to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusService&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.routeNumber, routeNumber) || other.routeNumber == routeNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,serviceType,routeNumber);

@override
String toString() {
  return 'BusService(id: $id, name: $name, serviceType: $serviceType, routeNumber: $routeNumber)';
}


}

/// @nodoc
abstract mixin class $BusServiceCopyWith<$Res>  {
  factory $BusServiceCopyWith(BusService value, $Res Function(BusService) _then) = _$BusServiceCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? serviceType, String? routeNumber
});




}
/// @nodoc
class _$BusServiceCopyWithImpl<$Res>
    implements $BusServiceCopyWith<$Res> {
  _$BusServiceCopyWithImpl(this._self, this._then);

  final BusService _self;
  final $Res Function(BusService) _then;

/// Create a copy of BusService
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? serviceType = freezed,Object? routeNumber = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,serviceType: freezed == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String?,routeNumber: freezed == routeNumber ? _self.routeNumber : routeNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BusService].
extension BusServicePatterns on BusService {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusService value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusService() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusService value)  $default,){
final _that = this;
switch (_that) {
case _BusService():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusService value)?  $default,){
final _that = this;
switch (_that) {
case _BusService() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? serviceType,  String? routeNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusService() when $default != null:
return $default(_that.id,_that.name,_that.serviceType,_that.routeNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? serviceType,  String? routeNumber)  $default,) {final _that = this;
switch (_that) {
case _BusService():
return $default(_that.id,_that.name,_that.serviceType,_that.routeNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? serviceType,  String? routeNumber)?  $default,) {final _that = this;
switch (_that) {
case _BusService() when $default != null:
return $default(_that.id,_that.name,_that.serviceType,_that.routeNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusService implements BusService {
  const _BusService({required this.id, required this.name, this.serviceType, this.routeNumber});
  factory _BusService.fromJson(Map<String, dynamic> json) => _$BusServiceFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? serviceType;
@override final  String? routeNumber;

/// Create a copy of BusService
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusServiceCopyWith<_BusService> get copyWith => __$BusServiceCopyWithImpl<_BusService>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusServiceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusService&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.routeNumber, routeNumber) || other.routeNumber == routeNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,serviceType,routeNumber);

@override
String toString() {
  return 'BusService(id: $id, name: $name, serviceType: $serviceType, routeNumber: $routeNumber)';
}


}

/// @nodoc
abstract mixin class _$BusServiceCopyWith<$Res> implements $BusServiceCopyWith<$Res> {
  factory _$BusServiceCopyWith(_BusService value, $Res Function(_BusService) _then) = __$BusServiceCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? serviceType, String? routeNumber
});




}
/// @nodoc
class __$BusServiceCopyWithImpl<$Res>
    implements _$BusServiceCopyWith<$Res> {
  __$BusServiceCopyWithImpl(this._self, this._then);

  final _BusService _self;
  final $Res Function(_BusService) _then;

/// Create a copy of BusService
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? serviceType = freezed,Object? routeNumber = freezed,}) {
  return _then(_BusService(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,serviceType: freezed == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String?,routeNumber: freezed == routeNumber ? _self.routeNumber : routeNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
