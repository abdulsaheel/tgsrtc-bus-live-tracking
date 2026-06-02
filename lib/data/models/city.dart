import 'package:freezed_annotation/freezed_annotation.dart';

part 'city.freezed.dart';
part 'city.g.dart';

/// GET /v3.0/city → [{id, name}]
@freezed
abstract class City with _$City {
  const factory City({
    required String id,
    required String name,
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}
