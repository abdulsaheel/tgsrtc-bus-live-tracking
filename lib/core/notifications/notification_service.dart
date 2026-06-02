import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// One-off + progress notifications (the proximity "arriving at your stop" ping).
/// The persistent live-tracking notification is owned by the foreground service
/// (flutter_foreground_task), not this.
class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _inited = false;

  static Future<void> init() async {
    if (_inited) return;
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );
    _inited = true;
  }

  static Future<void> showAlarm({
    required String title,
    required String body,
  }) async {
    await init();
    const android = AndroidNotificationDetails(
      'proximity_alarm',
      'Proximity alarms',
      channelDescription: 'Alerts when your bus is near your stop',
      importance: Importance.max,
      priority: Priority.high,
      category: AndroidNotificationCategory.alarm,
    );
    const ios = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    await _plugin.show(
      7001,
      title,
      body,
      const NotificationDetails(android: android, iOS: ios),
    );
  }

  /// Rich live-tracking notification with a NATIVE progress bar. Updated each
  /// poll from the foreground-service isolate. ongoing + onlyAlertOnce so it
  /// stays put and doesn't buzz on every update.
  static Future<void> showProgress({
    required String title,
    required String body,
    required int progress, // 0..100
  }) async {
    await init();
    final android = AndroidNotificationDetails(
      'journey_progress',
      'Live trip progress',
      channelDescription: 'Your followed bus and its progress',
      importance: Importance.low,
      priority: Priority.low,
      ongoing: true,
      onlyAlertOnce: true,
      showProgress: true,
      maxProgress: 100,
      progress: progress.clamp(0, 100),
      category: AndroidNotificationCategory.transport,
      styleInformation: BigTextStyleInformation(body),
      color: const Color(0xFF2563EB),
      colorized: false,
    );
    final ios = const DarwinNotificationDetails(presentSound: false);
    await _plugin.show(
      7100,
      title,
      body,
      NotificationDetails(android: android, iOS: ios),
    );
  }

  static Future<void> cancelProgress() => _plugin.cancel(7100);

  static Future<bool> requestPermission() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      return await android.requestNotificationsPermission() ?? false;
    }
    return true;
  }
}
