import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';

/// Windows-specific notification service using PowerShell toast notifications.
/// This runs periodic timers while the app is active to show reminders.
class WindowsNotificationService {
  static Timer? _reminderTimer;
  static final Set<String> _firedToday = {};

  static void startBackgroundReminders() {
    _reminderTimer?.cancel();
    _reminderTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      _checkAndFire();
    });
  }

  static void stopBackgroundReminders() {
    _reminderTimer?.cancel();
    _reminderTimer = null;
  }

  static void _checkAndFire() {
    final now = DateTime.now();
    final weekday = now.weekday;
    final timeKey = '${now.hour}:${now.minute}';
    final dayKey = '${now.day}-$timeKey';

    if (_firedToday.contains(dayKey)) return;

    // Check each reminder
    for (final reminder in _getRemindersForNow(weekday, now.hour, now.minute)) {
      _firedToday.add(dayKey);
      _showWindowsToast(reminder.title, reminder.body);
    }

    // Reset fired list at midnight
    if (now.hour == 0 && now.minute == 0) {
      _firedToday.clear();
    }
  }

  static List<_Reminder> _getRemindersForNow(int weekday, int hour, int minute) {
    final reminders = <_Reminder>[];

    // Fasted Cardio - Mon(1), Tue(2), Thu(4) at 4:50
    if ([1, 2, 4].contains(weekday) && hour == 4 && minute == 50) {
      reminders.add(_Reminder('🏃 Fasted Cardio Time!', 'Get up! 20-30 min brisk walk before breakfast.'));
    }

    // Afternoon workout - Mon, Tue, Thu at 16:45
    if ([1, 2, 4].contains(weekday) && hour == 16 && minute == 45) {
      reminders.add(_Reminder('🔥 Workout in 15 min!', 'Interval Sprints + Circuit. Makati area. LFG! 💪'));
    }

    // Gym Wed at 8:45
    if (weekday == 3 && hour == 8 && minute == 45) {
      reminders.add(_Reminder('💪 Gym: Push + Abs + HIIT', 'Head to Anytime Fitness!'));
    }

    // Gym Fri at 8:45
    if (weekday == 5 && hour == 8 && minute == 45) {
      reminders.add(_Reminder('💪 Gym: Pull + Legs + HIIT', 'Head to Anytime Fitness!'));
    }

    // Gym Sat at 6:45
    if (weekday == 6 && hour == 6 && minute == 45) {
      reminders.add(_Reminder('🔥 Full Body Circuit Day!', 'Saturday burn session!'));
    }

    // Water checks at 10:00 and 14:00
    if (hour == 10 && minute == 0) {
      reminders.add(_Reminder('💧 Water Check!', 'Target: 3L today! Keep sipping.'));
    }
    if (hour == 14 && minute == 0) {
      reminders.add(_Reminder('💧 Water Check!', 'Hydration check! No softdrinks!'));
    }

    // Dinner at 19:30
    if (hour == 19 && minute == 30) {
      reminders.add(_Reminder('🥗 Dinner: NO RICE!', 'High protein only. Tuna/eggs/tokwa + veggies.'));
    }

    // Checklist at 21:00
    if (hour == 21 && minute == 0) {
      reminders.add(_Reminder('✅ Daily Checklist', 'Did you complete all 7 tasks? Open the app!'));
    }

    // Sleep at 21:45
    if (hour == 21 && minute == 45) {
      reminders.add(_Reminder('🛌 Sleep in 15 min!', 'Prepare for bed. Sleep = recovery + fat loss.'));
    }

    // Monday weigh-in at 6:15
    if (weekday == 1 && hour == 6 && minute == 15) {
      reminders.add(_Reminder('⚖️ WEIGH-IN DAY!', 'Step on scale now! After bathroom, before eating.'));
    }

    return reminders;
  }

  /// Show Windows toast notification using PowerShell
  static Future<void> _showWindowsToast(String title, String body) async {
    if (!Platform.isWindows) return;

    try {
      final script = '''
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > \$null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] > \$null

\$template = @"
<toast>
    <visual>
        <binding template="ToastGeneric">
            <text>$title</text>
            <text>$body</text>
        </binding>
    </visual>
    <audio src="ms-winsoundevent:Notification.Default"/>
</toast>
"@

\$xml = New-Object Windows.Data.Xml.Dom.XmlDocument
\$xml.LoadXml(\$template)
\$toast = [Windows.UI.Notifications.ToastNotification]::new(\$xml)
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("FitnessTracker").Show(\$toast)
''';

      await Process.run('powershell', ['-Command', script]);
    } catch (e) {
      debugPrint('Windows toast error: $e');
    }
  }

  /// Test notification
  static Future<void> sendTestNotification() async {
    await _showWindowsToast(
      '🔥 Fitness Tracker',
      'Notifications are working! Stay on track with your 65-68kg goal!',
    );
  }
}

class _Reminder {
  final String title;
  final String body;
  _Reminder(this.title, this.body);
}
