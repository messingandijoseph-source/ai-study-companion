/*import 'package:flutter/material.dart';
import 'package:ai_study_companion/core/services/focus_mode.dart';
import 'package:usage_stats/usage_stats.dart';

class FocusModeScreen extends StatefulWidget {
  const FocusModeScreen({super.key});

  @override
  State<FocusModeScreen> createState() => _FocusModeScreenState();
}

class _FocusModeScreenState extends State<FocusModeScreen> {
  final service = FocusModeService();
  int distractionMinutes = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUsage();
  }

  Future<void> loadUsage() async {
    final minutes = await service.getDistractionMinutes();
    setState(() {
      distractionMinutes = minutes;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Focus Mode",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          Text(
            "Distraction time (last hour): $distractionMinutes minutes",
            style: const TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 20),

          if (distractionMinutes > 15)
            const Text(
              "⚠️ You are losing focus. Your performance may drop.",
              style: TextStyle(color: Colors.red),
            ),

          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: () {
              // redirect to system settings
              UsageStats.grantUsagePermission();
            },
            child: const Text("Enable Focus Protection"),
          ),
        ],
      ),
    );
  }
}  */

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/focus_mode.dart';
import 'package:usage_stats/usage_stats.dart';

class FocusModeScreen extends StatefulWidget {
  const FocusModeScreen({super.key});

  @override
  State<FocusModeScreen> createState() => _FocusModeScreenState();
}

class _FocusModeScreenState extends State<FocusModeScreen> {
  final service = FocusModeService();
  int distractionMinutes = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUsage();
  }

  Future<void> loadUsage() async {
    final minutes = await service.getDistractionMinutes();
    setState(() {
      distractionMinutes = minutes;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Focus score logic (0-60 mins, where 0 is perfect focus)
    double focusLevel = (1 - (distractionMinutes / 60)).clamp(0.0, 1.0);
    Color focusColor = distractionMinutes > 15
        ? Colors.redAccent
        : AppTheme.skyBlue;

    if (loading) return const Center(child: CircularProgressIndicator());

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Deep Work Session",
              style: Theme.of(
                context,
              ).textTheme.displayLarge?.copyWith(fontSize: 28),
            ).animate().fadeIn().slideY(begin: -0.2),

            const SizedBox(height: 40),

            // Circular Focus Indicator
            CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 15.0,
              percent: focusLevel,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${(focusLevel * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: focusColor,
                    ),
                  ),
                  const Text(
                    "Focus Score",
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.white10,
              progressColor: focusColor,
              animation: true,
              animationDuration: 1000,
            ).animate().shimmer(
              duration: 3.seconds,
              color: focusColor.withOpacity(0.3),
            ),

            const SizedBox(height: 50),

            _buildStatCard(
              "Distraction Time",
              "$distractionMinutes min",
              distractionMinutes > 15
                  ? Icons.warning_rounded
                  : Icons.check_circle_outline,
              focusColor,
            ),

            const SizedBox(height: 40),

            ElevatedButton.icon(
              icon: const Icon(Icons.security),
              label: const Text("SHIELD NOTIFICATIONS"),
              onPressed: () => UsageStats.grantUsagePermission(),
            ).animate().scale(delay: 500.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceNavy.withOpacity(0.5),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.white70)),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
