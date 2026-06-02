import 'package:dio/dio.dart';

import '../../core/network/api_exception.dart';
import '../models/bus_service.dart';
import '../models/bus_trip.dart';
import '../models/city.dart';
import '../models/live_data.dart';
import '../models/planned_trip.dart';
import '../models/stop.dart';
import '../models/trip_detail.dart';
import '../models/vehicle.dart';

/// Typed wrapper over the TGSRTC (Mappls InTouch) data API.
/// Paths are relative to [AppConfig.dataBaseUrl] (`.../tsrtc/api`), so switching
/// to the proxy needs no change here.
class TgsrtcApi {
  TgsrtcApi(this._dio);

  final Dio _dio;

  Future<List<T>> _list<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? query,
  }) async {
    try {
      final res = await _dio.get<List<dynamic>>(path, queryParameters: query);
      return (res.data ?? [])
          .cast<Map<String, dynamic>>()
          .map(fromJson)
          .toList();
    } on DioException catch (e) {
      throw ApiException.from(e);
    }
  }

  Future<T> _one<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? query,
  }) async {
    try {
      final res = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: query,
      );
      return fromJson(res.data!);
    } on DioException catch (e) {
      throw ApiException.from(e);
    }
  }

  // --- Reference data ---
  Future<List<City>> cities() => _list('/v3.0/city', City.fromJson);

  Future<List<BusService>> services() =>
      _list('/v2.0/services', BusService.fromJson);

  Future<List<BusService>> distinctServices() =>
      _list('/v3.0/distinctservices', BusService.fromJson);

  /// All routes/services for a city + category. Verified: returns city-scoped
  /// services (with routeNumber populated) when cityId+operationType+isAirport
  /// are supplied.
  Future<List<BusService>> cityRoutes({
    required String cityId,
    int operationType = 2,
    bool isAirport = false,
  }) =>
      _list('/v3.0/distinctservices', BusService.fromJson, query: {
        'cityId': cityId,
        'operationType': operationType,
        'isAirport': isAirport,
      });

  Future<List<Vehicle>> vehicles() =>
      _list('/v2.0/vehicles', Vehicle.fromJson);

  // --- Stops ---
  Future<List<Stop>> stops({
    required String cityId,
    int operationType = 2,
    bool isAirport = false,
  }) =>
      _list('/v3.0/stops', Stop.fromJson, query: {
        'operationType': operationType,
        'cityId': cityId,
        'isAirport': isAirport,
      });

  Future<List<NearbyStop>> nearbyStops({
    required double latitude,
    required double longitude,
    int maxDistance = 2000,
    int limit = 20,
  }) =>
      _list('/v2.0/stops/nearby', NearbyStop.fromJson, query: {
        'latitude': latitude,
        'longitude': longitude,
        'maxDistance': maxDistance,
        'limit': limit,
      });

  // --- Search ---
  /// Direct buses between two stops. [fromId]/[toId] are STAGE-STOP IDs (from
  /// [stops]); the API returns nothing if names are passed instead. Geozone
  /// types come from each selected stop (usually "stage"). Verified live.
  Future<BusSearchResponse> searchBetween({
    required String fromId,
    required String toId,
    required String cityId,
    String fromGeozoneType = 'stage',
    String toGeozoneType = 'stage',
    int operationType = 2,
    bool isAirport = false,
    String? serviceType,
  }) =>
      _one('/v3.0/trips/betweenTwoLocations', BusSearchResponse.fromJson,
          query: {
            'from': fromId,
            'to': toId,
            'cityId': cityId,
            'formGeozoneType': fromGeozoneType,
            'toGeozoneType': toGeozoneType,
            'operationType': operationType,
            'isAirport': isAirport,
            'serviceType': ?serviceType,
          });

  /// All SCHEDULED services between two stops (full timetable coverage).
  /// Use this for the trip planner — betweenTwoLocations only returns buses
  /// running right now. [fromId]/[toId] are stage-stop IDs.
  Future<List<PlannedTrip>> plannedBetween({
    required String fromId,
    required String toId,
    required String cityId,
    String fromGeozoneType = 'stage',
    String toGeozoneType = 'stage',
    int operationType = 2,
    bool isAirport = false,
  }) =>
      _list('/v3.0/trips/planned', PlannedTrip.fromJson, query: {
        'from': fromId,
        'to': toId,
        'cityId': cityId,
        'formGeozoneType': fromGeozoneType,
        'toGeozoneType': toGeozoneType,
        'operationType': operationType,
        'isAirport': isAirport,
      });

  Future<List<BusTrip>> searchByRoute({
    required String routeNumber,
    String? cityId,
    int operationType = 2,
    bool isAirport = false,
  }) =>
      _list('/v3.0/trips/routeNumber', BusTrip.fromJson, query: {
        'routeNumber': routeNumber,
        'cityId': ?cityId,
        'operationType': operationType,
        'isAirport': isAirport,
      });

  // --- Trip detail ---
  /// Full trip with stops + (optionally) the road polyline. isPolylinePoints
  /// must be true to get the 600+ polyline points for map drawing.
  Future<TripDetail> tripDetail(int tripId, {bool withPolyline = true}) =>
      _one('/v3.0/trips/details/$tripId', TripDetail.fromJson,
          query: {'isPolylinePoints': withPolyline});

  // --- Live position ⭐ ---
  Future<LiveData> liveVehicle(int vehicleId) =>
      _one('/v2.0/vehicles/$vehicleId', LiveData.fromJson);
}
