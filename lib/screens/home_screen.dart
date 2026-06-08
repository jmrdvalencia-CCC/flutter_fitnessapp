import 'package:flutter/material.dart';
import 'today_screen.dart';
import 'progress_screen.dart';
import 'checklist_screen.dart';
import 'plan_screen.dart';
import 'web_reminders_screen.dart';
import 'web_settings_screen.dart';

/// Mobile home screen (iOS/Android) — uses bottom navigation
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _getScreen(_currentIndex)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF1A1A2E),
          selectedItemColor: const Color(0xFFFF6B35),
          unselectedItemColor: Colors.grey,
          selectedFontSize: 11,
          unselectedFontSize: 10,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.today), label: 'Today'),
            BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Plan'),
            BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'Check'),
            BottomNavigationBarItem(icon: Icon(Icons.trending_down), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const TodayScreenContent();
      case 1:
        return const PlanScreenContent();
      case 2:
        return const ChecklistScreenContent();
      case 3:
        return const ProgressScreenContent();
      case 4:
        return const WebSettingsScreen();
      default:
        return const TodayScreenContent();
    }
  }
}
