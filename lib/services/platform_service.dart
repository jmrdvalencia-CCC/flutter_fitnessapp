import 'package:flutter/foundation.dart' show kIsWeb;

/// Platform helper that works across web, mobile, and desktop.
class PlatformService {
  static bool get isDesktop => !kIsWeb && _checkDesktop();
  static bool get isMobile => !kIsWeb && !_checkDesktop();

  static bool _checkDesktop() {
    // On web this won't be called. On native, we check via TargetPlatform.
    return false; // Overridden by platform_native.dart
  }

  static Future<void> initializeNotifications() async {
    if (kIsWeb) return;
  }
}
