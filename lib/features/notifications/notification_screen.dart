/*import 'package:flutter/material.dart';
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
} */

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui'; // Required for the glass blur effect
import 'package:flutter_animate/flutter_animate.dart'; // For high-end transitions
import '../../core/theme/app_theme.dart';

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

  // --- LOGIC REMAINS EXACTLY THE SAME ---
  Future<void> fetchNotifications() async {
    try {
      final response = await http.get(
        Uri.parse("http://YOUR_VPS_IP:3000/api/notifications"),
        headers: {"Authorization": "Bearer YOUR_JWT_TOKEN"},
      );

      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            notifications = jsonDecode(response.body);
            loading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (loading) {
      return Center(
        child: CircularProgressIndicator(
          color: AppTheme.skyBlue,
        ).animate().scale(duration: 600.ms),
      );
    }

    if (notifications.isEmpty) {
      return _buildEmptyState(isDark);
    }

    return RefreshIndicator(
      onRefresh: fetchNotifications,
      color: AppTheme.skyBlue,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: notifications.length,
        itemBuilder: (_, i) {
          final n = notifications[i];
          return _buildNotificationCard(n, isDark, i);
        },
      ),
    );
  }

  // --- HIGH UI COMPONENTS ---

  Widget _buildNotificationCard(Map n, bool isDark, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? AppTheme.pureWhite.withOpacity(0.05)
                  : AppTheme.skyBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppTheme.skyBlue.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.skyBlue.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_active_outlined,
                  color: AppTheme.skyBlue,
                  size: 24,
                ),
              ),
              title: Text(
                n['title'] ?? 'Study Update',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  n['body'] ?? '',
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
              ),
              trailing: n['is_read'] == false
                  ? const Icon(Icons.circle, size: 12, color: AppTheme.skyBlue)
                        .animate(onPlay: (controller) => controller.repeat())
                        .shimmer(duration: 2.seconds)
                  : null,
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.2, end: 0);
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.auto_awesome,
            size: 80,
            color: AppTheme.skyBlue.withOpacity(0.5),
          ),
          const SizedBox(height: 20),
          Text(
            "All caught up!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDark ? AppTheme.pureWhite : AppTheme.deepNavy,
            ),
          ),
          const SizedBox(height: 8),
          const Text("No new study alerts for now."),
        ],
      ).animate().fade().scale(),
    );
  }
}
