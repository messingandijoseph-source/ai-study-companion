/*import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pureWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _profileHeader(),
              const SizedBox(height: 30),
              _infoCard(),
              const SizedBox(height: 30),
              _menuSection(context),
              const SizedBox(height: 40),
              _logoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  /// ======================
  /// PROFILE HEADER
  /// ======================
  Widget _profileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 55,
          backgroundColor: AppTheme.skyBlue.withOpacity(0.15),
          child: const Icon(Icons.person, size: 60, color: AppTheme.deepNavy),
        ).animate().scale(),

        const SizedBox(height: 15),

        const Text(
          "Student User",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppTheme.deepNavy,
          ),
        ),

        const SizedBox(height: 5),

        const Text(
          "student@email.com",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }

  /// ======================
  /// USER INFO CARD
  /// ======================
  Widget _infoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.deepNavy,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppTheme.skyBlue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: const [
          _InfoRow(label: "Study Level", value: "Undergraduate"),
          Divider(color: Colors.white24),
          _InfoRow(label: "Active Groups", value: "2"),
          Divider(color: Colors.white24),
          _InfoRow(label: "Focus Sessions", value: "14"),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }

  /// ======================
  /// MENU OPTIONS
  /// ======================
  Widget _menuSection(BuildContext context) {
    return Column(
      children: [
        _menuTile(
          icon: Icons.notifications,
          title: "Notifications",
          onTap: () {
            // Later → Notifications screen
          },
        ),
        _menuTile(icon: Icons.lock, title: "Privacy & Security", onTap: () {}),
        _menuTile(icon: Icons.settings, title: "App Settings", onTap: () {}),
        _menuTile(
          icon: Icons.help_outline,
          title: "Help & Support",
          onTap: () {},
        ),
      ],
    );
  }

  Widget _menuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppTheme.skyBlue),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppTheme.deepNavy,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    ).animate().fadeIn(delay: 200.ms);
  }

  /// ======================
  /// LOGOUT BUTTON
  /// ======================
  Widget _logoutButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: () {
        // TODO: clear token + navigate to login
        Navigator.popUntil(context, (route) => route.isFirst);
      },
      child: const Text(
        "Logout",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ).animate().shake();
  }
}

/// ======================
/// INFO ROW WIDGET
/// ======================
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}   */

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();

  File? _profileImage;
  bool _loading = true;

  String email = "";
  String fullName = "";
  int studySessions = 0;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  /// ============================
  /// FETCH PROFILE FROM BACKEND
  /// ============================
  Future<void> _fetchProfile() async {
    try {
      final response = await http.get(
        Uri.parse("http://YOUR_VPS_IP:3000/api/users/me"),
        headers: {"Authorization": "Bearer YOUR_JWT_TOKEN"},
      );

      if (response.statusCode == 200) {
        // Replace with real parsing later
        setState(() {
          email = "student@email.com";
          fullName = "Student Name";
          studySessions = 12;
          _loading = false;
        });
      }
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  /// ============================
  /// PICK IMAGE
  /// ============================
  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() => _profileImage = File(image.path));
      await _uploadImage(File(image.path));
    }
  }

  /// ============================
  /// UPLOAD IMAGE TO BACKEND
  /// ============================
  Future<void> _uploadImage(File image) async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("http://YOUR_VPS_IP:3000/api/users/avatar"),
    );

    request.headers["Authorization"] = "Bearer YOUR_JWT_TOKEN";

    request.files.add(await http.MultipartFile.fromPath("avatar", image.path));

    await request.send();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _profileHeader(),
              const SizedBox(height: 30),
              _infoTile("Email", email),
              _infoTile("Study Sessions", studySessions.toString()),
              const Spacer(),
              _logoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// ============================
  /// PROFILE HEADER
  /// ============================
  Widget _profileHeader() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _showImageOptions(),
          child: CircleAvatar(
            radius: 55,
            backgroundColor: Colors.blue.shade100,
            backgroundImage: _profileImage != null
                ? FileImage(_profileImage!)
                : null,
            child: _profileImage == null
                ? const Icon(Icons.camera_alt, size: 30)
                : null,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          fullName,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0B1C2D), // navy
          ),
        ),
      ],
    );
  }

  /// ============================
  /// INFO TILE
  /// ============================
  Widget _infoTile(String label, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      subtitle: Text(value),
    );
  }

  /// ============================
  /// LOGOUT
  /// ============================
  Widget _logoutButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        minimumSize: const Size.fromHeight(50),
      ),
      onPressed: () {
        // Clear token & navigate to login
        Navigator.pushReplacementNamed(context, "/login");
      },
      child: const Text("Logout"),
    );
  }

  /// ============================
  /// IMAGE SOURCE CHOOSER
  /// ============================
  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
