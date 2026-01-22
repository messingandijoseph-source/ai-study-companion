/*import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/api/api_client.dart';
import '../home/home_screen.dart';
import 'package:ai_study_companion/core/theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameCtrl =
      TextEditingController(); // Using Name for login as requested
  final _passCtrl = TextEditingController();
  bool _isLoading = false;

  void _handleLogin() async {
    setState(() => _isLoading = true);
    // Mimicking API Call - Replace with your ApiClient.post logic
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Icon(
              Icons.lock_person_rounded,
              size: 70,
              color: AppTheme.skyBlue,
            ).animate().fadeIn(),
            const SizedBox(height: 20),
            const Text(
              "Login to Studyora",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),

            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: "Name",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Icons.lock),
              ),
            ),

            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text("ACCESS ACCOUNT"),
              ),
            ).animate().scale(delay: 200.ms),
          ],
        ),
      ),
    );
  }
}  */

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/api/api_client.dart';
import '../../core/services/focus_mode.dart'; // Import Service
import '../home/home_screen.dart';
import '../../core/theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _focusService = FocusModeService(); // Initialize Service
  bool _isLoading = false;

  void _handleLogin() async {
    if (_nameCtrl.text.isEmpty || _passCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Check for Focus Mode Permission before entering the app
    bool hasFocusPerm = await _focusService.hasPermission();
    if (!hasFocusPerm) {
      setState(() => _isLoading = false);
      _showPermissionDialog();
      return;
    }

    await Future.delayed(const Duration(seconds: 1)); // Mimicking API Call

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceNavy,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "Focus Protection",
          style: TextStyle(color: AppTheme.skyBlue),
        ),
        content: const Text(
          "To provide a distraction-free study environment, Studyora needs access to manage notifications while you are active in the app.",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "NOT NOW",
              style: TextStyle(color: Colors.white38),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _focusService
                  .requestPermission(); // Takes user to Android Settings
            },
            child: const Text("ENABLE"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Icon(
              Icons.lock_person_rounded,
              size: 70,
              color: AppTheme.skyBlue,
            ).animate().fadeIn().scale(),
            const SizedBox(height: 20),
            const Text(
              "Login to Studyora",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: AppTheme.deepNavy,
              ),
            ),
            const SizedBox(height: 50),
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: "Name",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                child: _isLoading
                    ? const CircularProgressIndicator(color: AppTheme.deepNavy)
                    : const Text("ACCESS ACCOUNT"),
              ),
            ).animate().scale(delay: 200.ms),
          ],
        ),
      ).animate().fadeIn(),
    );
  }
}
