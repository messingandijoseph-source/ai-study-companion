import 'package:flutter/material.dart';
import '../../core/api/api_client.dart';

class AIStudyScreen extends StatefulWidget {
  const AIStudyScreen({super.key});

  @override
  State<AIStudyScreen> createState() => _AIStudyScreenState();
}

class _AIStudyScreenState extends State<AIStudyScreen> {
  final ctrl = TextEditingController();
  String response = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Study Assistant")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: ctrl,
              decoration: const InputDecoration(hintText: "Ask anything…"),
            ),
            ElevatedButton(
              child: const Text("Ask AI"),
              onPressed: () async {
                final res = await ApiClient.post("/ai/ask", {
                  "question": ctrl.text,
                });
                setState(() => response = res.body);
              },
            ),
            const SizedBox(height: 20),
            Text(response),
          ],
        ),
      ),
    );
  }
}
