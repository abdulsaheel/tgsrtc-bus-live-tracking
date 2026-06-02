import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/api/tgsrtc_api.dart';
import '../../data/models/live_data.dart';
import '../../data/models/trip_detail.dart';
import 'notification_service.dart';

/// Entry point for the foreground-service isolate. Registered as the service
/// callback. Runs independently of the UI isolate (no providers/dotenv there),
/// so it authenticates and polls on its own using config mirrored in prefs.
@pragma('vm:entry-point')
void busTrackingCallback() {
  FlutterForegroundTask.setTaskHandler(BusTrackingTaskHandler());
}

class BusTrackingTaskHandler extends TaskHandler {
  TgsrtcApi? _api;
  int? _vehicleId;
  int? _tripId;
  String _title = 'Live tracking';
  List<TripPoint> _points = const [];
  bool _proximityFired = false;
  DateTime? _tokenAt;
  static const _proximityMeters = 1000.0;

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    WidgetsFlutterBinding.ensureInitialized();
    await NotificationService.init();
    final prefs = await SharedPreferences.getInstance();

    _vehicleId = prefs.getInt('follow_vehicle_id');
    _tripId = prefs.getInt('follow_trip_id');
    _title = prefs.getString('follow_route_title') ?? 'Live tracking';

    await _ensureApi(prefs);

    // Load the stop sequence once (needed for next-stop + progress).
    if (_api != null && _tripId != null && _tripId! > 0) {
      try {
        final trip = await _api!.tripDetail(_tripId!, withPolyline: false);
        _points = trip.points;
      } catch (_) {/* keep empty; we still show position */}
    }
  }

  Future<void> _ensureApi(SharedPreferences prefs) async {
    final dataBase = prefs.getString('cfg_data_base');
    final authBase = prefs.getString('cfg_auth_base');
    final id = prefs.getString('cfg_client_id');
    final secret = prefs.getString('cfg_client_secret');
    if (dataBase == null || authBase == null || id == null || secret == null) {
      return;
    }
    // Refresh token roughly hourly.
    final fresh = _tokenAt != null &&
        DateTime.now().difference(_tokenAt!).inMinutes < 50 &&
        _api != null;
    if (fresh) return;

    final tokenDio = Dio();
    final res = await tokenDio.post<Map<String, dynamic>>(
      '$authBase/api/security/oauth/token',
      data: {
        'grant_type': 'client_credentials',
        'client_id': id,
        'client_secret': secret,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    final token = res.data?['access_token'] as String?;
    if (token == null) return;
    _tokenAt = DateTime.now();
    final dio = Dio(BaseOptions(
      baseUrl: dataBase,
      headers: {'Authorization': 'Bearer $token'},
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 25),
    ));
    _api = TgsrtcApi(dio);
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    _poll();
  }

  Future<void> _poll() async {
    final api = _api;
    final vid = _vehicleId;
    if (api == null || vid == null) return;

    final prefs = await SharedPreferences.getInstance();
    final targetStopId = prefs.getInt('follow_target_stop_id');

    LiveData data;
    try {
      data = await api.liveVehicle(vid);
    } catch (_) {
      try {
        await _ensureApi(prefs); // maybe token expired
      } catch (_) {}
      return;
    }

    final bus = LatLng(data.latitude, data.longitude);
    final (nextName, prevName, progress, nextId) = _computeProgress(bus, data);

    // Proximity alarm.
    if (targetStopId != null && !_proximityFired) {
      final target = _points.where((p) => p.id == targetStopId).firstOrNull;
      if (target?.latitude != null) {
        final d = const Distance()(
            bus, LatLng(target!.latitude!, target.longitude!));
        if (d <= _proximityMeters) {
          _proximityFired = true;
          await NotificationService.showAlarm(
            title: 'Bus approaching your stop',
            body: '$_title: within 1 km of ${target.name}.',
          );
        }
      }
    }

    // The foreground-service notification (required by Android) is kept
    // minimal; the rich notification with a NATIVE progress bar is shown via
    // flutter_local_notifications below.
    await FlutterForegroundTask.updateService(
      notificationTitle: 'Gamyam',
      notificationText: 'Live tracking active',
    );

    final stopsLeft = _stopsToTarget(targetStopId, nextId);
    final String body;
    if (_proximityFired) {
      body = 'Arriving at your stop now';
    } else if (nextName == null) {
      body = 'Tracking • ${data.speedKph.round()} km/h';
    } else {
      final tail = stopsLeft != null
          ? '$stopsLeft stop${stopsLeft == 1 ? '' : 's'} to your stop'
          : '${data.speedKph.round()} km/h';
      body = 'Next: $nextName · $tail';
    }
    await NotificationService.showProgress(
      title: '🚌 $_title',
      body: body,
      progress: (progress * 100).round(),
    );

    // Push a snapshot to the UI isolate for the in-app live activity.
    FlutterForegroundTask.sendDataToMain({
      'lat': data.latitude,
      'lng': data.longitude,
      'speed': data.speedKph,
      'status': data.statusStr,
      'nextStop': nextName,
      'prevStop': prevName,
      'progress': progress,
      'nextId': nextId,
    });
  }

  /// Number of stops from the bus's next stop to the user's target stop.
  int? _stopsToTarget(int? targetStopId, int? nextId) {
    if (targetStopId == null || nextId == null || _points.isEmpty) return null;
    final from = _points.indexWhere((p) => p.id == nextId);
    final to = _points.indexWhere((p) => p.id == targetStopId);
    if (from == -1 || to == -1 || to < from) return null;
    return to - from + 1;
  }

  /// Returns (nextStopName, prevStopName, progress0to1, nextStopId).
  (String?, String?, double, int?) _computeProgress(LatLng bus, LiveData data) {
    if (_points.isEmpty) return (null, null, 0, null);

    int idx = -1;
    if (data.nextPointId != null && data.nextPointId! > 0) {
      idx = _points.indexWhere((p) => p.id == data.nextPointId);
    }
    if (idx == -1) {
      // Nearest stop fallback.
      double best = double.infinity;
      for (var i = 0; i < _points.length; i++) {
        final p = _points[i];
        if (p.latitude == null) continue;
        final d = const Distance()(bus, LatLng(p.latitude!, p.longitude!));
        if (d < best) {
          best = d;
          idx = i;
        }
      }
    }
    if (idx == -1) return (null, null, 0, null);

    final next = _points[idx];
    final prev = idx > 0 ? _points[idx - 1] : null;
    double progress = 0;
    if (prev?.latitude != null && next.latitude != null) {
      const dist = Distance();
      final total =
          dist(LatLng(prev!.latitude!, prev.longitude!), LatLng(next.latitude!, next.longitude!));
      final remaining = dist(bus, LatLng(next.latitude!, next.longitude!));
      if (total > 0) progress = (1 - remaining / total).clamp(0.0, 1.0);
    }
    return (next.name, prev?.name, progress, next.id);
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    await NotificationService.cancelProgress();
  }

  @override
  void onNotificationButtonPressed(String id) {
    if (id == 'stop') {
      FlutterForegroundTask.stopService();
    }
  }

  @override
  void onNotificationPressed() {
    FlutterForegroundTask.launchApp('/track');
  }
}
