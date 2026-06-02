import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:live_activities/live_activities.dart';

/// iOS Live Activity (lock-screen card + Dynamic Island) for live bus tracking.
/// iOS 16.1+ only; every method is a no-op on Android/unsupported devices.
///
/// NOTE: while the app is foreground/briefly-background the activity updates
/// from [update]. Truly continuous background updates require ActivityKit push
/// (APNs) from a server — planned for the Cloudflare proxy. The card itself
/// still persists on the lock screen between updates.
class LiveActivityService {
  LiveActivityService._();

  static final _la = LiveActivities();
  static const _appGroupId = 'group.com.abdulsaheel.tsrtcbustracker';
  static const _activityId = 'gamyam_bus';

  static bool _supported = false;
  static bool _active = false;
  // The ActivityKit-generated id returned by createActivity. updateActivity /
  // endActivity look the activity up by THIS id, not our _activityId seed.
  static String? _runtimeId;

  static Future<void> init() async {
    if (!Platform.isIOS) return;
    await _la.init(appGroupId: _appGroupId, urlScheme: 'tgsrtc');
    _supported = await _la.areActivitiesSupported();
    final enabled = await _la.areActivitiesEnabled();
    debugPrint('[LiveActivity] supported=$_supported enabled=$enabled');
  }

  /// Fires when the user taps the Live Activity card / Dynamic Island (via the
  /// `tgsrtc://` URL scheme). Empty on non-iOS.
  static Stream<dynamic> taps() =>
      Platform.isIOS ? _la.urlSchemeStream() : const Stream.empty();

  static Future<void> start(Map<String, dynamic> data) async {
    if (!Platform.isIOS) return;
    if (!_supported) {
      debugPrint('[LiveActivity] start skipped: not supported');
      return;
    }
    if (_active) return;
    try {
      // iOSEnableRemoteUpdates:false → no APNs push token requested. With it
      // true (the plugin default) ActivityKit demands the Push Notifications
      // entitlement and otherwise throws "ActivityInput error 0". We update the
      // activity locally from the app, so push isn't needed.
      _runtimeId = await _la.createActivity(
        _activityId,
        data,
        iOSEnableRemoteUpdates: false,
      );
      _active = _runtimeId != null;
      debugPrint('[LiveActivity] createActivity ok id=$_runtimeId');
    } catch (e, st) {
      debugPrint('[LiveActivity] createActivity FAILED: $e\n$st');
    }
  }

  static Future<void> update(Map<String, dynamic> data) async {
    if (!Platform.isIOS || !_supported || !_active || _runtimeId == null) return;
    try {
      await _la.updateActivity(_runtimeId!, data);
    } catch (e) {
      debugPrint('[LiveActivity] update failed: $e');
    }
  }

  static Future<void> end() async {
    if (!Platform.isIOS || _runtimeId == null) return;
    try {
      await _la.endActivity(_runtimeId!);
    } catch (_) {}
    _active = false;
    _runtimeId = null;
  }

  /// Builds the data map (String/num values only — read by the Swift widget
  /// via sharedDefault) from the current journey snapshot.
  static Map<String, dynamic> data({
    required String title,
    String? nextStop,
    String? prevStop,
    int speedKph = 0,
    double progress = 0,
    int? stopsLeft,
    String? status,
  }) =>
      {
        'title': title,
        'nextStop': nextStop ?? '',
        'prevStop': prevStop ?? '',
        'speed': speedKph,
        'progress': (progress.clamp(0.0, 1.0) * 100).round(),
        'stopsLeft': stopsLeft ?? -1,
        'status': status ?? '',
      };
}
