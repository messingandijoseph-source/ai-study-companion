import 'package:usage_stats/usage_stats.dart';

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
