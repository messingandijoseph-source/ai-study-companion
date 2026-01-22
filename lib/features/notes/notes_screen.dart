import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Notes")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (_, i) => ListTile(
          title: Text("Note ${i + 1}"),
          subtitle: const Text("Tap to open"),
        ).animate().fadeIn(delay: (i * 100).ms).slideX(begin: 0.2),
      ),
    );
  }
}
