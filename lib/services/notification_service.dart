import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _plugin.initialize(settings);
  }

  static Future<void> requestPermissions() async {
    await _plugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  static Future<void> scheduleAllReminders() async {
    await _plugin.cancelAll();

    // Fasted Cardio - Mon, Tue, Thu at 4:50 AM
    for (final day in [DateTime.monday, DateTime.tuesday, DateTime.thursday]) {
      await _scheduleWeekly(
        id: day * 10,
        title: '🏃 Fasted Cardio Time!',
        body: 'Get up! 20-30 min brisk walk before breakfast. Burn fat now!',
        hour: 4,
        minute: 50,
        weekday: day,
      );
    }

    // Afternoon workout - Mon, Tue, Thu at 4:45 PM
    for (final day in [DateTime.monday, DateTime.tuesday, DateTime.thursday]) {
      await _scheduleWeekly(
        id: day * 10 + 1,
        title: '🔥 Workout Time in 15 min!',
        body: 'Interval Sprints + Bodyweight Circuit. Location: Makati area. LFG! 💪',
        hour: 16,
        minute: 45,
        weekday: day,
      );
    }

    // Gym reminder - Wed at 8:45 AM
    await _scheduleWeekly(
      id: 31,
      title: '💪 Gym Time: Push + Abs + HIIT',
      body: 'Head to Anytime Fitness. Push day today! Progressive overload!',
      hour: 8,
      minute: 45,
      weekday: DateTime.wednesday,
    );

    // Gym reminder - Fri at 8:45 AM
    await _scheduleWeekly(
      id: 51,
      title: '💪 Gym Time: Pull + Legs + HIIT',
      body: 'Head to Anytime Fitness. Legs & Pull today! Don\'t skip legs!',
      hour: 8,
      minute: 45,
      weekday: DateTime.friday,
    );

    // Gym reminder - Sat at 6:45 AM
    await _scheduleWeekly(
      id: 61,
      title: '🔥 Full Body Circuit Day!',
      body: 'Saturday burn! 4 rounds of fat-torching circuit. Let\'s go!',
      hour: 6,
      minute: 45,
      weekday: DateTime.saturday,
    );

    // Dinner reminder - Every day at 7:30 PM
    for (int day = 1; day <= 7; day++) {
      await _scheduleWeekly(
        id: 100 + day,
        title: '🥗 Dinner Reminder: NO RICE!',
        body: 'High protein dinner only. Tuna/eggs/tokwa + veggies. Zero rice tonight!',
        hour: 19,
        minute: 30,
        weekday: day,
      );
    }

    // Water reminder - Every day at 10 AM, 2 PM, 5 PM
    for (int day = 1; day <= 7; day++) {
      await _scheduleWeekly(
        id: 200 + day,
        title: '💧 Water Check!',
        body: 'Have you been drinking water? Target: 3L today!',
        hour: 10,
        minute: 0,
        weekday: day,
      );
      await _scheduleWeekly(
        id: 210 + day,
        title: '💧 Water Check!',
        body: 'Hydration check! Keep sipping. No softdrinks, no milk tea!',
        hour: 14,
        minute: 0,
        weekday: day,
      );
    }

    // Sleep reminder - Every day at 9:45 PM
    for (int day = 1; day <= 7; day++) {
      await _scheduleWeekly(
        id: 300 + day,
        title: '🛌 Sleep in 15 minutes!',
        body: 'Prepare for bed. Sleep by 10 PM = better recovery + fat loss.',
        hour: 21,
        minute: 45,
        weekday: day,
      );
    }

    // Monday weigh-in at 6:15 AM
    await _scheduleWeekly(
      id: 400,
      title: '⚖️ WEIGH-IN DAY!',
      body: 'Step on the scale now! After bathroom, before eating. Log your weight!',
      hour: 6,
      minute: 15,
      weekday: DateTime.monday,
    );

    // Daily checklist reminder at 9 PM
    for (int day = 1; day <= 7; day++) {
      await _scheduleWeekly(
        id: 500 + day,
        title: '✅ Daily Checklist',
        body: 'Did you complete all 7 tasks today? Open the app and check!',
        hour: 21,
        minute: 0,
        weekday: day,
      );
    }
  }

  static Future<void> _scheduleWeekly({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
    required int weekday,
  }) async {
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfWeekday(weekday, hour, minute),
      const NotificationDetails(
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
        android: AndroidNotificationDetails(
          'fitness_reminders',
          'Fitness Reminders',
          channelDescription: 'Workout and meal reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  static tz.TZDateTime _nextInstanceOfWeekday(int weekday, int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    while (scheduled.weekday != weekday) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 7));
    }

    return scheduled;
  }

  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
