/*import 'package:ai_study_companion/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/api/api_client.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const Text(
              "Create\nAccount",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ).animate().fadeIn().slideX(begin: -0.2),
            const SizedBox(height: 40),

            _buildField("Full Name", Icons.person, _nameCtrl),
            const SizedBox(height: 20),
            _buildField("Email Address", Icons.email, _emailCtrl),
            const SizedBox(height: 20),
            _buildField("Password", Icons.lock, _passCtrl, isPass: true),

            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  // Link your ApiClient.post registration logic here!
                },
                child: const Text(
                  "SIGN UP",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                ),
                child: const Text(
                  "Already have an account? Login",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    String hint,
    IconData icon,
    TextEditingController ctrl, {
    bool isPass = false,
  }) {
    return TextField(
      controller: ctrl,
      obscureText: isPass,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: const TextStyle(color: Colors.white60),
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}  */

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/home_screen.dart';
import '../../core/theme/app_theme.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _isLoading = false;

  void _handleSignUp() async {
    if (_nameCtrl.text.isEmpty ||
        _emailCtrl.text.isEmpty ||
        _passCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate API Delay
    await Future.delayed(const Duration(seconds: 2));

    // PERSISTENCE LOGIC: Save that the user now has an account
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasAccount', true);

    if (!mounted) return;

    // Smooth transition to Home
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background "Studyora" Glows
          Positioned(
            top: -50,
            right: -50,
            child: _buildBackgroundCircle(AppTheme.skyBlue.withOpacity(0.1)),
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.auto_stories_rounded,
                    size: 60,
                    color: AppTheme.skyBlue,
                  ).animate().scale(duration: 600.ms),

                  const SizedBox(height: 20),

                  const Text(
                    "Join Studyora",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.skyBlue,
                      letterSpacing: 1.5,
                    ),
                  ).animate().fadeIn().slideY(begin: 0.2),

                  const Text(
                    "Create your student identity",
                    style: TextStyle(color: Colors.white70),
                  ).animate().fadeIn(delay: 200.ms),

                  const SizedBox(height: 40),

                  // Glassmorphic Input Container
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: _nameCtrl,
                          decoration: const InputDecoration(
                            labelText: "Full Name",
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _emailCtrl,
                          decoration: const InputDecoration(
                            labelText: "Email Address",
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _passCtrl,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "Create Password",
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),

                  const SizedBox(height: 40),

                  // Animated Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleSignUp,
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: AppTheme.deepNavy,
                            )
                          : const Text(
                              "CREATE ACCOUNT",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                    ),
                  ).animate().scale(delay: 600.ms),

                  const SizedBox(height: 20),

                  // Link to Login
                  TextButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                    child: const Text(
                      "Already have an account? Sign In",
                      style: TextStyle(color: Colors.white60),
                    ),
                  ).animate().fadeIn(delay: 800.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundCircle(Color color) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    ).animate().blur(begin: const Offset(30, 30), end: const Offset(60, 60));
  }
}
