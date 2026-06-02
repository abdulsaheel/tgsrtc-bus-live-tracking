import 'dart:io';

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

  static Future<void> init() async {
    if (!Platform.isIOS) return;
    await _la.init(appGroupId: _appGroupId);
    _supported = await _la.areActivitiesSupported();
  }

  static Future<void> start(Map<String, dynamic> data) async {
    if (!Platform.isIOS || !_supported || _active) return;
    try {
      await _la.createActivity(_activityId, data);
      _active = true;
    } catch (_) {/* activity disabled by user, etc. */}
  }

  static Future<void> update(Map<String, dynamic> data) async {
    if (!Platform.isIOS || !_supported || !_active) return;
    try {
      await _la.updateActivity(_activityId, data);
    } catch (_) {}
  }

  static Future<void> end() async {
    if (!Platform.isIOS || !_active) return;
    try {
      await _la.endActivity(_activityId);
    } catch (_) {}
    _active = false;
  }

  /// Builds the data map (String/num values only — read by the Swift widget
  /// via sharedDefault) from the current journey snapshot.
  static Map<String, dynamic> data({
    required String title,
    String? nextStop,
    int speedKph = 0,
    double progress = 0,
    int? stopsLeft,
    String? status,
  }) =>
      {
        'title': title,
        'nextStop': nextStop ?? '',
        'speed': speedKph,
        'progress': (progress.clamp(0.0, 1.0) * 100).round(),
        'stopsLeft': stopsLeft ?? -1,
        'status': status ?? '',
      };
}
