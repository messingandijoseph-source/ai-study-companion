import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
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
      0,
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
    await _notifications.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.from(time, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails('study_alerts', 'Study Alerts'),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      UILocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}

mixin UILocalNotificationDateInterpretation {
  static get absoluteTime => TimeOfDay.now();
}
