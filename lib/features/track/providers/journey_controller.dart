import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/app_config.dart';
import '../../../core/notifications/bus_tracking_task.dart';
import '../../../core/notifications/live_activity_service.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../core/prefs/app_prefs.dart';
import '../../../data/models/live_data.dart';

/// State of an active "follow this bus" session (drives the in-app live
/// activity overlay). Live values are fed from the foreground-service isolate.
class JourneyState {
  const JourneyState({
    this.vehicleId,
    this.tripId,
    this.title,
    this.targetStopId,
    this.nextStop,
    this.prevStop,
    this.progress = 0,
    this.speedKph = 0,
    this.statusStr,
    this.stopsLeft,
    this.lat,
    this.lng,
    this.heading = 0,
    this.live,
  });

  final int? vehicleId;
  final int? tripId;
  final String? title;
  final int? targetStopId;
  final String? nextStop;
  final String? prevStop;
  final double progress;
  final double speedKph;
  final String? statusStr;
  final int? stopsLeft;
  final double? lat;
  final double? lng;
  final double heading;
  final LiveData? live;

  bool get isFollowing => vehicleId != null;
  bool get hasFix => lat != null && lng != null;

  JourneyState copyWith({
    String? nextStop,
    String? prevStop,
    double? progress,
    double? speedKph,
    String? statusStr,
    int? targetStopId,
    int? stopsLeft,
    double? lat,
    double? lng,
    double? heading,
    LiveData? live,
  }) =>
      JourneyState(
        vehicleId: vehicleId,
        tripId: tripId,
        title: title,
        targetStopId: targetStopId ?? this.targetStopId,
        nextStop: nextStop ?? this.nextStop,
        prevStop: prevStop ?? this.prevStop,
        progress: progress ?? this.progress,
        speedKph: speedKph ?? this.speedKph,
        statusStr: statusStr ?? this.statusStr,
        stopsLeft: stopsLeft ?? this.stopsLeft,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        heading: heading ?? this.heading,
        live: live ?? this.live,
      );
}

final journeyControllerProvider =
    NotifierProvider<JourneyController, JourneyState>(JourneyController.new);

class JourneyController extends Notifier<JourneyState> {
  @override
  JourneyState build() {
    FlutterForegroundTask.addTaskDataCallback(_onTaskData);
    ref.onDispose(
        () => FlutterForegroundTask.removeTaskDataCallback(_onTaskData));

    // Resume a session persisted across app restarts.
    final prefs = ref.read(appPrefsProvider);
    final vid = prefs.followVehicleId;
    if (vid != null) {
      // The session was restored from prefs, but a crash/kill may have stopped
      // the foreground service that feeds live data — revive it so the pill /
      // Live Activity resume updating instead of being stuck on "Halted".
      _reviveServiceIfStopped();
      return JourneyState(
        vehicleId: vid,
        tripId: prefs.followTripId,
        title: prefs.followRouteTitle,
        targetStopId: prefs.followTargetStopId,
      );
    }
    return const JourneyState();
  }

  /// If the follow state is live but no foreground service is running (app was
  /// killed/crashed), restart the service using the config already mirrored in
  /// prefs. If we can't (no config), clear the stale session.
  Future<void> _reviveServiceIfStopped() async {
    if (await FlutterForegroundTask.isRunningService) return; // still feeding
    final prefs = ref.read(appPrefsProvider);
    if (prefs.cfgDataBase == null) {
      // No config to resume with — drop the stale session so the UI isn't stuck.
      await prefs.setFollowedJourney(vehicleId: null);
      state = const JourneyState();
      return;
    }
    await NotificationService.requestPermission();
    await FlutterForegroundTask.startService(
      serviceId: 700,
      notificationTitle: prefs.followRouteTitle ?? 'Live tracking',
      notificationText: 'Resuming live tracking…',
      notificationButtons: [
        const NotificationButton(id: 'stop', text: 'Stop'),
      ],
      callback: busTrackingCallback,
    );
  }

  void _onTaskData(Object data) {
    if (data is! Map) return;
    state = state.copyWith(
      nextStop: data['nextStop'] as String?,
      prevStop: data['prevStop'] as String?,
      progress: (data['progress'] as num?)?.toDouble(),
      speedKph: (data['speed'] as num?)?.toDouble(),
      statusStr: data['status'] as String?,
      stopsLeft: (data['stopsLeft'] as num?)?.toInt(),
      lat: (data['lat'] as num?)?.toDouble(),
      lng: (data['lng'] as num?)?.toDouble(),
      heading: (data['heading'] as num?)?.toDouble(),
      live: data['live'] is Map
          ? LiveData.fromJson(Map<String, dynamic>.from(data['live'] as Map))
          : null,
    );
    // Mirror to the iOS Live Activity (no-op on Android).
    LiveActivityService.update(LiveActivityService.data(
      title: state.title ?? 'Live bus',
      nextStop: state.nextStop,
      prevStop: state.prevStop,
      speedKph: state.speedKph.round(),
      progress: state.progress,
      stopsLeft: state.stopsLeft,
      status: state.statusStr,
    ));
  }

  Future<void> startFollowing({
    required int vehicleId,
    required int? tripId,
    required String title,
    int? targetStopId,
  }) async {
    // Only one bus can be tracked at a time. Tear down any existing session
    // cleanly before starting the new one — otherwise the old foreground
    // service / Live Activity keeps running and the two glitch over each other.
    if (state.isFollowing && state.vehicleId != vehicleId) {
      await _teardown();
    }

    await NotificationService.requestPermission();
    if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
      await FlutterForegroundTask.requestIgnoreBatteryOptimization();
    }

    final prefs = ref.read(appPrefsProvider);
    // Mirror config so the background isolate can authenticate.
    await prefs.setTrackingConfig(
      authBase: AppConfig.authBaseUrl,
      dataBase: AppConfig.dataBaseUrl,
      clientId: AppConfig.clientId,
      clientSecret: AppConfig.clientSecret,
      useProxy: AppConfig.useProxy,
    );
    await prefs.setFollowedJourney(
      vehicleId: vehicleId,
      tripId: tripId,
      routeTitle: title,
      targetStopId: targetStopId,
    );

    state = JourneyState(
      vehicleId: vehicleId,
      tripId: tripId,
      title: title,
      targetStopId: targetStopId,
    );

    await FlutterForegroundTask.startService(
      serviceId: 700,
      notificationTitle: title,
      notificationText: 'Starting live tracking…',
      notificationButtons: [
        const NotificationButton(id: 'stop', text: 'Stop'),
      ],
      callback: busTrackingCallback,
    );

    // iOS Live Activity (no-op on Android).
    await LiveActivityService.start(
      LiveActivityService.data(title: title),
    );
  }

  Future<void> stopFollowing() async {
    await _teardown();
    state = const JourneyState();
  }

  /// Stop the running service + Live Activity and clear persisted follow state,
  /// WITHOUT resetting [state] — callers decide what the next state is.
  Future<void> _teardown() async {
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.stopService();
    }
    await LiveActivityService.end();
    await ref.read(appPrefsProvider).setFollowedJourney(vehicleId: null);
  }

  Future<void> setTargetStop(int stopId) async {
    await ref.read(appPrefsProvider).setFollowTargetStop(stopId);
    state = state.copyWith(targetStopId: stopId);
  }
}
