import 'package:flutter/material.dart';
import '../../core/services/ai_service.dart';

class AIGroupsScreen extends StatefulWidget {
  const AIGroupsScreen({super.key});

  @override
  State<AIGroupsScreen> createState() => _AIGroupsScreenState();
}

class _AIGroupsScreenState extends State<AIGroupsScreen> {
  List<String> groups = [];

  @override
  void initState() {
    super.initState();
    loadGroups();
  }

  void loadGroups() async {
    groups = await AIService.suggestGroups("USER_ID");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Suggested Groups")),
      body: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (_, i) => ListTile(title: Text(groups[i])),
      ),
    );
  }
}
