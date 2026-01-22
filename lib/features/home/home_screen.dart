import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

import '../ai/ai_study_screen.dart';
import '../notes/notes_screen.dart';
import '../groups/study_groups_screen.dart';
import '../focus/focus_mode_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  final List<String> _titles = [
    "AI Studyora",
    "My Study Notes",
    "Study Groups",
    "Focus Mode",
    "User Profile",
  ];

  /// ❗ REMOVE const — VERY IMPORTANT
  final List<Widget> screens = [
    const AIStudyScreen(),
    const NotesScreen(),
    const StudyGroupsScreen(),
    const FocusModeScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pureWhite,
      appBar: AppBar(
        backgroundColor: AppTheme.deepNavy,
        elevation: 0,
        centerTitle: true,
        title: Text(
          _titles[index],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.white,
          ),
        ),
      ),

      /// ✅ THIS IS WHAT WAS FAILING
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: KeyedSubtree(key: ValueKey(index), child: screens[index]),
      ),

      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (i) => setState(() => index = i),
      selectedItemColor: AppTheme.skyBlue,
      unselectedItemColor: Colors.grey,
      backgroundColor: AppTheme.deepNavy,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.psychology), label: "AI"),
        BottomNavigationBarItem(icon: Icon(Icons.description), label: "Notes"),
        BottomNavigationBarItem(icon: Icon(Icons.diversity_3), label: "Groups"),
        BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Focus"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    ).animate().slideY(begin: 1, end: 0);
  }
}
