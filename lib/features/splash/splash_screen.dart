import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import this
import '../auth/login_screen.dart';
import '../auth/register_screen.dart';
import '../../core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    // 1. Minimum duration for the branding experience
    final stopwatch = Stopwatch()..start();

    try {
      // 2. Check local storage for user history
      final prefs = await SharedPreferences.getInstance();
      final bool hasAccount = prefs.getBool('hasAccount') ?? false;

      // 3. Ensure the splash stays for at least 3.5 seconds for the animation
      int remainingTime = 3500 - stopwatch.elapsedMilliseconds;
      if (remainingTime > 0) {
        await Future.delayed(Duration(milliseconds: remainingTime));
      }

      if (!mounted) return;

      // 4. Intelligent Routing
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: 800.ms,
          pageBuilder: (context, animation, secondaryAnimation) =>
              hasAccount ? const LoginScreen() : const RegisterScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.05),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
        ),
      );
    } catch (e) {
      // Fallback in case of error
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RegisterScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.deepNavy, Color(0xFF112240)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // High-Level UI: Ambient Light Effects (Reducing darkness)
          _buildLightOrb(
            top: -100,
            left: -50,
            color: AppTheme.skyBlue.withOpacity(0.15),
          ),
          _buildLightOrb(
            bottom: -50,
            right: -50,
            color: Colors.white.withOpacity(0.05),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Glassmorphic Icon Container
                Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.05),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.skyBlue.withOpacity(0.2),
                            blurRadius: 50,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.auto_stories_rounded,
                        size: 85,
                        color: Colors.white,
                      ),
                    )
                    .animate()
                    .scale(duration: 900.ms, curve: Curves.bounceInOut)
                    .shimmer(
                      delay: 1200.ms,
                      duration: 2.seconds,
                      color: AppTheme.skyBlue.withOpacity(0.4),
                    ),

                const SizedBox(height: 35),

                // Branding Text
                const Text(
                  "STUDYORA",
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 12,
                    color: Colors.white,
                  ),
                ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),

                const SizedBox(height: 8),

                const Text(
                  "INTELLIGENT STUDY ECOSYSTEM",
                  style: TextStyle(
                    color: AppTheme.skyBlue,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 3,
                  ),
                ).animate().fadeIn(delay: 800.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper to build the decorative background orbs
  Widget _buildLightOrb({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required Color color,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child:
          Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .blur(
                begin: const Offset(50, 50),
                end: const Offset(90, 90),
                duration: 5.seconds,
              )
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.2, 1.2),
                duration: 5.seconds,
              ),
    );
  }
}
