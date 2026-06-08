import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'screens/home_screen.dart';
import 'screens/web_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  runApp(const FitnessApp());
}

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.windows ||
         defaultTargetPlatform == TargetPlatform.macOS ||
         defaultTargetPlatform == TargetPlatform.linux);

    return MaterialApp(
      title: 'Fitness Tracker - 78kg → 65-68kg',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFFF6B35),
          secondary: const Color(0xFF4ECDC4),
          surface: const Color(0xFF1A1A2E),
          background: const Color(0xFF0F0F23),
        ),
        scaffoldBackgroundColor: const Color(0xFF0F0F23),
        useMaterial3: true,
      ),
      home: (kIsWeb || isDesktop) ? const WebHomeScreen() : const HomeScreen(),
    );
  }
}
