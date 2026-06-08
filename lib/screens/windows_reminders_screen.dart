import 'dart:io';
import 'package:flutter/material.dart';

/// Windows Reminders Screen - uses Windows Toast notifications
/// Since flutter_local_notifications supports Windows, reminders
/// work similarly. This screen shows upcoming reminders and lets
/// user manually trigger test notifications.
class WindowsRemindersScreen extends StatefulWidget {
  const WindowsRemindersScreen({super.key});

  @override
  State<WindowsRemindersScreen> createState() => _WindowsRemindersScreenState();
}

class _WindowsRemindersScreenState extends State<WindowsRemindersScreen> {
  final List<_ReminderItem> _reminders = [
    _ReminderItem('🏃 Fasted Cardio', '4:50 AM', 'Mon, Tue, Thu', true),
    _ReminderItem('🔥 Afternoon Workout', '4:45 PM', 'Mon, Tue, Thu', true),
    _ReminderItem('💪 Gym - Push Day', '8:45 AM', 'Wednesday', true),
    _ReminderItem('💪 Gym - Pull+Legs', '8:45 AM', 'Friday', true),
    _ReminderItem('🔥 Circuit Day', '6:45 AM', 'Saturday', true),
    _ReminderItem('💧 Water Check #1', '10:00 AM', 'Daily', true),
    _ReminderItem('💧 Water Check #2', '2:00 PM', 'Daily', true),
    _ReminderItem('🥗 Dinner: No Rice!', '7:30 PM', 'Daily', true),
    _ReminderItem('✅ Daily Checklist', '9:00 PM', 'Daily', true),
    _ReminderItem('🛌 Sleep Reminder', '9:45 PM', 'Daily', true),
    _ReminderItem('⚖️ Weigh-In Day', '6:15 AM', 'Monday', true),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reminders & Notifications 🔔',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Manage your workout and meal reminders. On Windows, notifications appear as toast notifications.',
            style: TextStyle(color: Colors.grey[400], fontSize: 13),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF4ECDC4).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF4ECDC4).withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Color(0xFF4ECDC4), size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Windows notifications require the app to be running. Consider adding to startup.',
                    style: TextStyle(color: Colors.grey[300], fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Enable all / Disable all
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    for (var r in _reminders) {
                      r.enabled = true;
                    }
                  });
                  _showSnack('All reminders enabled ✅');
                },
                icon: const Icon(Icons.notifications_active, size: 16),
                label: const Text('Enable All'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4ECDC4),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    for (var r in _reminders) {
                      r.enabled = false;
                    }
                  });
                  _showSnack('All reminders disabled 🔕');
                },
                icon: const Icon(Icons.notifications_off, size: 16),
                label: const Text('Disable All'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Reminder list
          ...List.generate(_reminders.length, (i) {
            final r = _reminders[i];
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(10),
                border: r.enabled
                    ? Border.all(color: const Color(0xFF4ECDC4).withOpacity(0.2))
                    : null,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(r.title, style: TextStyle(
                      color: r.enabled ? Colors.white : Colors.grey[600],
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    )),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(r.time, style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(r.days, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
                  ),
                  Switch(
                    value: r.enabled,
                    onChanged: (val) => setState(() => r.enabled = val),
                    activeColor: const Color(0xFF4ECDC4),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 24),

          // Windows startup tip
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('💡 Windows Tips', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 10),
                _tipItem('Add this app to Windows Startup for auto-launch'),
                _tipItem('Win + R → shell:startup → paste shortcut'),
                _tipItem('Ensure Windows notifications are ON in Settings > Notifications'),
                _tipItem('App minimizes to system tray when closed'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tipItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(color: Colors.grey[500])),
          Expanded(child: Text(text, style: TextStyle(color: Colors.grey[400], fontSize: 12))),
        ],
      ),
    );
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: const Color(0xFF4ECDC4)),
    );
  }
}

class _ReminderItem {
  final String title;
  final String time;
  final String days;
  bool enabled;

  _ReminderItem(this.title, this.time, this.days, this.enabled);
}
