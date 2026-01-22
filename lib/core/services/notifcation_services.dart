import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // Adjustment 1: Explicitly request permission for Android 13+
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings = InitializationSettings(android: androidSettings);

    await _notifications.initialize(settings);
  }

  static Future<void> showInstant({
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'study_alerts',
      'Study Alerts',
      importance: Importance.high,
      priority: Priority.high,
    );

    await _notifications.show(
      DateTime.now().hashCode, // Unique ID
      title,
      body,
      const NotificationDetails(android: androidDetails),
    );
  }

  static Future<void> schedule({
    required String title,
    required String body,
    required DateTime time,
  }) async {
    // Ensure the time is converted correctly to TZDateTime
    final scheduledDate = tz.TZDateTime.from(time, tz.local);

    await _notifications.zonedSchedule(
      time.hashCode, // Unique ID
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'study_alerts',
          'Study Alerts',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      // In latest versions, we only need the schedule mode for Android
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
