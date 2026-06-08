import 'package:flutter/material.dart';
import 'today_screen.dart';
import 'plan_screen.dart';
import 'checklist_screen.dart';
import 'progress_screen.dart';
import 'web_reminders_screen.dart';
import 'web_settings_screen.dart';

class WebHomeScreen extends StatefulWidget {
  const WebHomeScreen({super.key});

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 768;

    if (isWide) {
      return _buildDesktopLayout();
    }
    return _buildMobileLayout();
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      body: Row(
        children: [
          // Side navigation
          Container(
            width: 220,
            color: const Color(0xFF1A1A2E),
            child: Column(
              children: [
                const SizedBox(height: 24),
                // Logo/Brand
                Container(
                  padding: const EdgeInsets.all(16),
                  child: const Column(
                    children: [
                      Text('🔥', style: TextStyle(fontSize: 36)),
                      SizedBox(height: 6),
                      Text(
                        'FITNESS TRACKER',
                        style: TextStyle(color: Color(0xFFFF6B35), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '78kg → 65-68kg',
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFF2A2A3E), height: 1),
                const SizedBox(height: 8),
                // Nav items
                _navItem(0, Icons.today, 'Today'),
                _navItem(1, Icons.fitness_center, 'Weekly Plan'),
                _navItem(2, Icons.checklist, 'Checklist'),
                _navItem(3, Icons.trending_down, 'Progress'),
                _navItem(4, Icons.notifications, 'Reminders'),
                _navItem(5, Icons.settings, 'Settings'),
                const Spacer(),
                // Footer
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Target: Aug 29, 2025',
                    style: TextStyle(color: Colors.grey[600], fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1, color: Color(0xFF2A2A3E)),
          // Content
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: _getScreen(_currentIndex),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    // For narrow web (mobile browser)
    return Scaffold(
      body: _getScreen(_currentIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, -2)),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex > 4 ? 4 : _currentIndex,
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
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'More'),
          ],
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF6B35).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isSelected ? Border.all(color: const Color(0xFFFF6B35).withOpacity(0.3)) : null,
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? const Color(0xFFFF6B35) : Colors.grey, size: 20),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFFFF6B35) : Colors.grey[400],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 13,
              ),
            ),
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
        return const WebRemindersScreen();
      case 5:
        return const WebSettingsScreen();
      default:
        return const TodayScreenContent();
    }
  }
}
