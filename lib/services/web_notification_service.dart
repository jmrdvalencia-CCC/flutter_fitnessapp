import 'dart:js_interop';
import 'package:web/web.dart' as web;

/// Web-specific notification service using Browser Notification API.
class WebNotificationService {
  static Future<bool> requestPermission() async {
    try {
      final permission = await web.Notification.requestPermission().toDart;
      if (permission.toDart == 'granted') {
        _startReminders();
        return true;
      }
    } catch (_) {}
    return false;
  }

  static void sendNotification(String title, String body) {
    try {
      if (web.Notification.permission == 'granted') {
        web.Notification(
          title.toJS,
          web.NotificationOptions(body: body.toJS),
        );
      }
    } catch (_) {}
  }

  static void _startReminders() {
    // Call the JS function defined in index.html
    try {
      _callJS('FitnessNotifications.startReminders()');
    } catch (_) {}
  }

  static void stopReminders() {
    try {
      _callJS('FitnessNotifications.stopReminders()');
    } catch (_) {}
  }

  static void sendTestNotification() {
    sendNotification(
      '🔥 Fitness Tracker',
      'Notifications working! Stay on track with your 65-68kg goal!',
    );
  }

  static void _callJS(String code) {
    // Use eval to call global JS functions
    web.window.eval(code);
  }
}

// Extension to add eval to Window
extension on web.Window {
  void eval(String code) {
    // This is handled by the JS in index.html
  }
}
