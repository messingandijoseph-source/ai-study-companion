import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List notifications = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    final response = await http.get(
      Uri.parse("http://YOUR_VPS_IP:3000/api/notifications"),
      headers: {"Authorization": "Bearer YOUR_JWT_TOKEN"},
    );

    if (response.statusCode == 200) {
      setState(() {
        notifications = jsonDecode(response.body);
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (_, i) {
        final n = notifications[i];
        return ListTile(
          title: Text(n['title']),
          subtitle: Text(n['body']),
          trailing: n['is_read'] ? null : const Icon(Icons.circle, size: 10),
        );
      },
    );
  }
}
