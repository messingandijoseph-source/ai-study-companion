import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/theme/app_theme.dart';
import 'features/splash/splash_screen.dart';
import 'package:ai_study_companion/core/services/notifcation_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase (Push notifications)
  await Firebase.initializeApp();

  // Local + Push notification setup
  await NotificationService.init();

  runApp(const StudyApp());
}

class StudyApp extends StatelessWidget {
  const StudyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Studyora',
      theme: AppTheme.lightTheme, // white / navy / sky blue
      home: const SplashScreen(),
    );
  }
}
