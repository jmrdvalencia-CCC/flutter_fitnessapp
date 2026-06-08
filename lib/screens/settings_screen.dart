import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings ⚙️',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 24),

            // Notifications
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Notifications', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    value: _notificationsEnabled,
                    onChanged: (val) async {
                      setState(() => _notificationsEnabled = val);
                      if (val) {
                        await NotificationService.requestPermissions();
                        await NotificationService.scheduleAllReminders();
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('✅ All reminders scheduled!'), backgroundColor: Color(0xFF4ECDC4)),
                          );
                        }
                      } else {
                        await NotificationService.cancelAll();
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('🔕 Notifications disabled')),
                          );
                        }
                      }
                    },
                    title: const Text('Enable Reminders', style: TextStyle(color: Colors.white)),
                    subtitle: Text('Workout, meal, water & sleep reminders', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                    activeColor: const Color(0xFF4ECDC4),
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Scheduled notifications info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Scheduled Reminders', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  _reminderInfo('🏃 Fasted Cardio', '4:50 AM', 'Mon, Tue, Thu'),
                  _reminderInfo('🔥 Afternoon Workout', '4:45 PM', 'Mon, Tue, Thu'),
                  _reminderInfo('💪 Gym (Push)', '8:45 AM', 'Wednesday'),
                  _reminderInfo('💪 Gym (Pull+Legs)', '8:45 AM', 'Friday'),
                  _reminderInfo('🔥 Circuit', '6:45 AM', 'Saturday'),
                  _reminderInfo('💧 Water Check', '10 AM & 2 PM', 'Daily'),
                  _reminderInfo('🥗 Dinner: No Rice!', '7:30 PM', 'Daily'),
                  _reminderInfo('✅ Daily Checklist', '9:00 PM', 'Daily'),
                  _reminderInfo('🛌 Sleep Reminder', '9:45 PM', 'Daily'),
                  _reminderInfo('⚖️ Weigh-In', '6:15 AM', 'Monday'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // About
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Plan Details', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  _infoRow('Start Weight', '78 kg'),
                  _infoRow('Target Weight', '65-68 kg'),
                  _infoRow('Target Date', 'August 29, 2025'),
                  _infoRow('Duration', '12 weeks'),
                  _infoRow('Daily Calories', '1,300-1,500 kcal'),
                  _infoRow('Daily Protein', '120g+'),
                  _infoRow('Budget', '₱100-150/day'),
                  _infoRow('Gym', 'Anytime Fitness'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Reset button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showResetDialog(context),
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: const Text('Re-schedule All Notifications', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B35),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _reminderInfo(String title, String time, String days) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(title, style: TextStyle(color: Colors.grey[300], fontSize: 13))),
          Expanded(flex: 2, child: Text(time, style: TextStyle(color: Colors.grey[500], fontSize: 12))),
          Expanded(flex: 2, child: Text(days, style: TextStyle(color: Colors.grey[500], fontSize: 11))),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 13)),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        title: const Text('Re-schedule Notifications?', style: TextStyle(color: Colors.white)),
        content: const Text(
          'This will cancel all existing reminders and set them up again.',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await NotificationService.scheduleAllReminders();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('✅ All reminders re-scheduled!'), backgroundColor: Color(0xFF4ECDC4)),
                );
              }
            },
            child: const Text('Confirm', style: TextStyle(color: Color(0xFFFF6B35))),
          ),
        ],
      ),
    );
  }
}
