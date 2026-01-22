import 'package:flutter/material.dart';
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
}
