import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationsDispatcher {
  FlutterLocalNotificationsPlugin? _plugin;

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized || kIsWeb) {
      return;
    }

    if (_plugin == null) {
      await _setupLocalNotifications();
    }

    await _requestPermissions();
    _initialized = true;
  }

  Future<void> _setupLocalNotifications() async {
    _plugin = FlutterLocalNotificationsPlugin();

    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@drawable/ic_stat_name'),
      iOS: DarwinInitializationSettings(),
    );

    await _plugin?.initialize(settings: initializationSettings);
  }

  Future<void> _requestPermissions() async {
    await _plugin
        ?.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    await _plugin
        ?.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }
}
