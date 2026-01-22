import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; // Add this import

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // 1. Firebase Messaging Permission Request
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(alert: true, badge: true, sound: true);

    // 2. Retrieve and Print FCM Token for verification
    String? token = await messaging.getToken();
    print("FCM TOKEN: $token");

    // Adjustment 1: Explicitly request permission for Android 13+ (Local)
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
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
