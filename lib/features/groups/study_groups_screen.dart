import 'package:flutter/material.dart';

class StudyGroupsScreen extends StatelessWidget {
  const StudyGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Study Groups")),
      body: Column(
        children: [
          ListTile(
            title: const Text("Create Group"),
            trailing: const Icon(Icons.add),
          ),
          ListTile(
            title: const Text("AI Suggested Groups"),
            subtitle: const Text("Based on your subjects & level"),
          ),
        ],
      ),
    );
  }
}
