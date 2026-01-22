import 'package:flutter/material.dart';

class FocusModeScreen extends StatelessWidget {
  const FocusModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Focus Mode")),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "Focus Mode uses system-level permissions to reduce notifications from distracting apps.\n\n"
          "NOTE: Full blocking requires OS permissions and is implemented via platform channels.",
        ),
      ),
    );
  }
}
