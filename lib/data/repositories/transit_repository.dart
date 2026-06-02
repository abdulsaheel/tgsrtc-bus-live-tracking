import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/dio_client.dart';
import '../api/tgsrtc_api.dart';
import '../models/bus_service.dart';
import '../models/city.dart';
import '../models/live_data.dart';
import '../models/stop.dart';

/// Singleton Dio + API.
final tgsrtcApiProvider = Provider<TgsrtcApi>((ref) => TgsrtcApi(buildDataDio()));

final transitRepositoryProvider = Provider<TransitRepository>(
  (ref) => TransitRepository(ref.watch(tgsrtcApiProvider)),
);

/// App-facing data access. Adds light in-memory caching for the big static
/// lists (cities, services) which rarely change within a session — and which
/// the proxy will eventually cache server-side too.
class TransitRepository {
  TransitRepository(this._api);

  final TgsrtcApi _api;

  List<City>? _citiesCache;
  final Map<String, List<Stop>> _stopsCache = {};

  Future<List<City>> cities() async =>
      _citiesCache ??= await _api.cities();

  Future<List<Stop>> stops(String cityId) async =>
      _stopsCache[cityId] ??= await _api.stops(cityId: cityId);

  Future<List<BusService>> services() => _api.distinctServices();

  Future<LiveData> liveVehicle(int vehicleId) => _api.liveVehicle(vehicleId);

  TgsrtcApi get api => _api;
}
