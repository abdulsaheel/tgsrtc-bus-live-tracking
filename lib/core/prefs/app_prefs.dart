import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Overridden in main() with the loaded instance.
final sharedPrefsProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('sharedPrefsProvider must be overridden'),
);

/// Thin typed wrapper over SharedPreferences for app settings.
class AppPrefs {
  AppPrefs(this._prefs);
  final SharedPreferences _prefs;

  static const _kCityId = 'selected_city_id';
  static const _kCityName = 'selected_city_name';
  static const _kAutoDetect = 'auto_detect_city';
  static const _kFollowVehicleId = 'follow_vehicle_id';
  static const _kFollowTripId = 'follow_trip_id';
  static const _kFollowRouteTitle = 'follow_route_title';
  static const _kFollowTargetStopId = 'follow_target_stop_id';
  // Networking config mirrored here so the background isolate (which has no
  // dotenv / providers) can authenticate against the API on its own.
  static const _kCfgAuthBase = 'cfg_auth_base';
  static const _kCfgDataBase = 'cfg_data_base';
  static const _kCfgClientId = 'cfg_client_id';
  static const _kCfgClientSecret = 'cfg_client_secret';
  static const _kCfgUseProxy = 'cfg_use_proxy';

  String? get cityId => _prefs.getString(_kCityId);
  String? get cityName => _prefs.getString(_kCityName);
  bool get autoDetect => _prefs.getBool(_kAutoDetect) ?? true;

  int? get followVehicleId => _prefs.getInt(_kFollowVehicleId);
  int? get followTripId => _prefs.getInt(_kFollowTripId);
  String? get followRouteTitle => _prefs.getString(_kFollowRouteTitle);
  int? get followTargetStopId => _prefs.getInt(_kFollowTargetStopId);

  String? get cfgAuthBase => _prefs.getString(_kCfgAuthBase);
  String? get cfgDataBase => _prefs.getString(_kCfgDataBase);
  String? get cfgClientId => _prefs.getString(_kCfgClientId);
  String? get cfgClientSecret => _prefs.getString(_kCfgClientSecret);
  bool get cfgUseProxy => _prefs.getBool(_kCfgUseProxy) ?? false;

  /// Mirror networking config for the background isolate.
  Future<void> setTrackingConfig({
    required String authBase,
    required String dataBase,
    required String clientId,
    required String clientSecret,
    required bool useProxy,
  }) async {
    await _prefs.setString(_kCfgAuthBase, authBase);
    await _prefs.setString(_kCfgDataBase, dataBase);
    await _prefs.setString(_kCfgClientId, clientId);
    await _prefs.setString(_kCfgClientSecret, clientSecret);
    await _prefs.setBool(_kCfgUseProxy, useProxy);
  }

  Future<void> setFollowTargetStop(int? stopId) async {
    if (stopId == null) {
      await _prefs.remove(_kFollowTargetStopId);
    } else {
      await _prefs.setInt(_kFollowTargetStopId, stopId);
    }
  }

  Future<void> setCity(String id, String name) async {
    await _prefs.setString(_kCityId, id);
    await _prefs.setString(_kCityName, name);
  }

  Future<void> setAutoDetect(bool v) => _prefs.setBool(_kAutoDetect, v);

  Future<void> setFollowedJourney({
    int? vehicleId,
    int? tripId,
    String? routeTitle,
    int? targetStopId,
  }) async {
    if (vehicleId == null) {
      await _prefs.remove(_kFollowVehicleId);
      await _prefs.remove(_kFollowTripId);
      await _prefs.remove(_kFollowRouteTitle);
      await _prefs.remove(_kFollowTargetStopId);
    } else {
      await _prefs.setInt(_kFollowVehicleId, vehicleId);
      if (tripId != null) await _prefs.setInt(_kFollowTripId, tripId);
      if (routeTitle != null) {
        await _prefs.setString(_kFollowRouteTitle, routeTitle);
      }
      if (targetStopId != null) {
        await _prefs.setInt(_kFollowTargetStopId, targetStopId);
      }
    }
  }
}

final appPrefsProvider = Provider<AppPrefs>(
  (ref) => AppPrefs(ref.watch(sharedPrefsProvider)),
);
