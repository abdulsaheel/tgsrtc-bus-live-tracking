import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/notifications/live_activity_service.dart';
import 'core/prefs/app_prefs.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  // Foreground service (Uber-style live tracking) setup.
  FlutterForegroundTask.initCommunicationPort();
  FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'journey_tracking',
      channelName: 'Live bus tracking',
      channelDescription: 'Shows your followed bus and its progress',
      onlyAlertOnce: true,
    ),
    iosNotificationOptions: const IOSNotificationOptions(),
    foregroundTaskOptions: ForegroundTaskOptions(
      eventAction: ForegroundTaskEventAction.repeat(8000),
      autoRunOnBoot: false,
      allowWakeLock: true,
      allowWifiLock: true,
    ),
  );

  await LiveActivityService.init(); // iOS Live Activities (no-op on Android)

  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [sharedPrefsProvider.overrideWithValue(prefs)],
      child: const GamyamApp(),
    ),
  );
}

class GamyamApp extends StatelessWidget {
  const GamyamApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap so the foreground task can drive UI updates reliably.
    return WithForegroundTask(
      child: MaterialApp.router(
        title: 'Gamyam',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        routerConfig: appRouter,
      ),
    );
  }
}
