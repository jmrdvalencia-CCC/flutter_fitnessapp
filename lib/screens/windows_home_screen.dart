import 'package:flutter/material.dart';
import 'today_screen.dart';
import 'plan_screen.dart';
import 'checklist_screen.dart';
import 'progress_screen.dart';
import 'windows_reminders_screen.dart';
import 'windows_settings_screen.dart';
import '../services/windows_notification_service.dart';

class WindowsHomeScreen extends StatefulWidget {
  const WindowsHomeScreen({super.key});

  @override
  State<WindowsHomeScreen> createState() => _WindowsHomeScreenState();
}

class _WindowsHomeScreenState extends State<WindowsHomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WindowsNotificationService.startBackgroundReminders();
  }

  @override
  void dispose() {
    WindowsNotificationService.stopBackgroundReminders();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _currentIndex,
            onDestinationSelected: (i) => setState(() => _currentIndex = i),
            backgroundColor: const Color(0xFF1A1A2E),
            selectedIconTheme: const IconThemeData(color: Color(0xFFFF6B35)),
            selectedLabelTextStyle: const TextStyle(color: Color(0xFFFF6B35), fontSize: 11),
            unselectedIconTheme: const IconThemeData(color: Colors.grey),
            unselectedLabelTextStyle: const TextStyle(color: Colors.grey, fontSize: 10),
            labelType: NavigationRailLabelType.all,
            leading: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Text('🔥', style: TextStyle(fontSize: 28)),
                  SizedBox(height: 4),
                  Text('FITNESS', style: TextStyle(color: Color(0xFFFF6B35), fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.today), label: Text('Today')),
              NavigationRailDestination(icon: Icon(Icons.fitness_center), label: Text('Plan')),
              NavigationRailDestination(icon: Icon(Icons.checklist), label: Text('Checklist')),
              NavigationRailDestination(icon: Icon(Icons.trending_down), label: Text('Progress')),
              NavigationRailDestination(icon: Icon(Icons.notifications), label: Text('Reminders')),
              NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1, color: Color(0xFF2A2A3E)),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: _getScreen(_currentIndex),
              ),
            ),
          ),
        ],
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
        return const WindowsRemindersScreen();
      case 5:
        return const WindowsSettingsContent();
      default:
        return const TodayScreenContent();
    }
  }
}
