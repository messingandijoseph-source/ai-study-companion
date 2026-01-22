/*import 'package:usage_stats/usage_stats.dart';

class FocusModeService {
  static const distractingApps = [
    "com.instagram.android",
    "com.zhiliaoapp.musically", // TikTok
    "com.google.android.youtube",
  ];

  Future<int> getDistractionMinutes() async {
    final end = DateTime.now();
    final start = end.subtract(const Duration(minutes: 60));

    final stats = await UsageStats.queryUsageStats(
      start.millisecondsSinceEpoch as DateTime,
      end.millisecondsSinceEpoch as DateTime,
    );

    num totalMs = 0;

    for (final stat in stats) {
      if (distractingApps.contains(stat.packageName)) {
        totalMs += int.tryParse(stat.totalTimeInForeground ?? '0') ?? 0;
      }
    }

    return (totalMs / 60000).round(); // minutes
  }
}
*/

//singleton pattern is used here and so only one instance runs across the whole app
import 'package:notification_listener_service/notification_listener_service.dart';

class FocusModeService {
  // Singleton Pattern
  static final FocusModeService _instance = FocusModeService._internal();
  factory FocusModeService() => _instance;
  FocusModeService._internal();

  static const distractingApps = [
    "com.instagram.android",
    "com.zhiliaoapp.musically",
    "com.google.android.youtube",
  ];

  bool _isShieldActive = false;

  // Check if permission is granted (should be called on Splash or Login)
  Future<bool> hasPermission() async {
    return await NotificationListenerService.isPermissionGranted();
  }

  void startShield() {
    _isShieldActive = true;
    NotificationListenerService.notificationsStream.listen((event) {
      if (_isShieldActive && distractingApps.contains(event.packageName)) {
        // This instantly removes the notification from the tray
        NotificationListenerService.notificationsStream;
        print("Shield Active: Blocked ${event.packageName}");
      }
    });
  }

  void stopShield() {
    _isShieldActive = false;
    print("Shield Deactivated: User left Studyora");
  }

  Future<dynamic> getDistractionMinutes() async {}

  Future<void> requestPermission() async {}
}
