import 'package:flutter/material.dart';
import '../../core/services/ai_service.dart';

class AISummaryScreen extends StatefulWidget {
  const AISummaryScreen({super.key});

  @override
  State<AISummaryScreen> createState() => _AISummaryScreenState();
}

class _AISummaryScreenState extends State<AISummaryScreen> {
  String result = "";
  bool loading = false;

  void summarize() async {
    setState(() => loading = true);
    result = await AIService.summarizeNotes("My long study notes here...");
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Summary")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: summarize,
              child: const Text("Summarize Notes"),
            ),
            const SizedBox(height: 20),
            loading ? const CircularProgressIndicator() : Text(result),
          ],
        ),
      ),
    );
  }
}
