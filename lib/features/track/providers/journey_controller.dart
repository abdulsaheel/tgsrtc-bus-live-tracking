import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/app_config.dart';
import '../../../core/notifications/bus_tracking_task.dart';
import '../../../core/notifications/live_activity_service.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../core/prefs/app_prefs.dart';

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

  bool get isFollowing => vehicleId != null;

  JourneyState copyWith({
    String? nextStop,
    String? prevStop,
    double? progress,
    double? speedKph,
    String? statusStr,
    int? targetStopId,
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
      return JourneyState(
        vehicleId: vid,
        tripId: prefs.followTripId,
        title: prefs.followRouteTitle,
        targetStopId: prefs.followTargetStopId,
      );
    }
    return const JourneyState();
  }

  void _onTaskData(Object data) {
    if (data is! Map) return;
    state = state.copyWith(
      nextStop: data['nextStop'] as String?,
      prevStop: data['prevStop'] as String?,
      progress: (data['progress'] as num?)?.toDouble(),
      speedKph: (data['speed'] as num?)?.toDouble(),
      statusStr: data['status'] as String?,
    );
    // Mirror to the iOS Live Activity (no-op on Android).
    LiveActivityService.update(LiveActivityService.data(
      title: state.title ?? 'Live bus',
      nextStop: state.nextStop,
      speedKph: state.speedKph.round(),
      progress: state.progress,
      status: state.statusStr,
    ));
  }

  Future<void> startFollowing({
    required int vehicleId,
    required int? tripId,
    required String title,
    int? targetStopId,
  }) async {
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
    await FlutterForegroundTask.stopService();
    await LiveActivityService.end();
    await ref.read(appPrefsProvider).setFollowedJourney(vehicleId: null);
    state = const JourneyState();
  }

  Future<void> setTargetStop(int stopId) async {
    await ref.read(appPrefsProvider).setFollowTargetStop(stopId);
    state = state.copyWith(targetStopId: stopId);
  }
}
