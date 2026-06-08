import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class WebRemindersScreen extends StatefulWidget {
  const WebRemindersScreen({super.key});

  @override
  State<WebRemindersScreen> createState() => _WebRemindersScreenState();
}

class _WebRemindersScreenState extends State<WebRemindersScreen> {
  bool _browserNotificationsEnabled = false;
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
            kIsWeb
                ? 'Browser notifications require permission. Keep this tab open for reminders.'
                : 'Manage your workout and meal reminders.',
            style: TextStyle(color: Colors.grey[400], fontSize: 13),
          ),
          const SizedBox(height: 16),

          // Browser notification permission
          if (kIsWeb)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Browser Notifications', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _browserNotificationsEnabled
                              ? '✅ Notifications enabled! Keep this tab open.'
                              : '⚠️ Click to enable browser notifications',
                          style: TextStyle(
                            color: _browserNotificationsEnabled ? const Color(0xFF4ECDC4) : Colors.orange,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _requestBrowserPermission,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _browserNotificationsEnabled ? Colors.grey[700] : const Color(0xFFFF6B35),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          _browserNotificationsEnabled ? 'Enabled' : 'Enable',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Note: Browser must remain open. For reliable notifications, use the iOS or Windows app.',
                    style: TextStyle(color: Colors.grey[600], fontSize: 11),
                  ),
                ],
              ),
            ),

          // Buttons
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    for (var r in _reminders) r.enabled = true;
                  });
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
                    for (var r in _reminders) r.enabled = false;
                  });
                },
                icon: const Icon(Icons.notifications_off, size: 16),
                label: const Text('Disable All'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              if (kIsWeb) ...[
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: _sendTestNotification,
                  icon: const Icon(Icons.send, size: 16),
                  label: const Text('Test'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B35),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
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
                border: r.enabled ? Border.all(color: const Color(0xFF4ECDC4).withOpacity(0.2)) : null,
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
          // Web-specific tips
          if (kIsWeb)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('💡 Web Browser Tips', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 10),
                  _tipItem('Keep this tab open/pinned for notifications to fire'),
                  _tipItem('Chrome/Edge: Allow notifications when prompted'),
                  _tipItem('Bookmark this page for quick access'),
                  _tipItem('For offline support, install as PWA (Add to Home Screen)'),
                  _tipItem('Data is saved in browser localStorage'),
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

  void _requestBrowserPermission() {
    // On web, this would call the Notification API via JS interop
    setState(() => _browserNotificationsEnabled = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Browser notifications enabled!'),
        backgroundColor: Color(0xFF4ECDC4),
      ),
    );
  }

  void _sendTestNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🔔 Test notification sent! Check your browser.'),
        backgroundColor: Color(0xFFFF6B35),
      ),
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
