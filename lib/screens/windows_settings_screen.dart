import 'package:flutter/material.dart';

class WindowsSettingsContent extends StatelessWidget {
  const WindowsSettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings ⚙️',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 24),

          // Plan info
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Plan Details', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 16),
                _infoRow('Start Weight', '78 kg'),
                _infoRow('Target Weight', '65-68 kg'),
                _infoRow('Target Date', 'August 29, 2025'),
                _infoRow('Duration', '12 weeks'),
                _infoRow('Daily Calories', '1,300-1,500 kcal'),
                _infoRow('Daily Protein', '120g+'),
                _infoRow('Meal Budget', '₱100-150/day'),
                _infoRow('Gym', 'Anytime Fitness'),
                _infoRow('Platform', 'Windows Desktop'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Weekly Schedule
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Weekly Schedule', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 16),
                _scheduleRow('Monday', 'Onsite', 'Fasted Cardio + Run/Circuit'),
                _scheduleRow('Tuesday', 'Onsite', 'Fasted Cardio + Run/Circuit'),
                _scheduleRow('Wednesday', 'WFH', 'Gym: Push + Abs + HIIT'),
                _scheduleRow('Thursday', 'Onsite', 'Fasted Cardio + Run/Circuit'),
                _scheduleRow('Friday', 'WFH', 'Gym: Pull + Legs + HIIT'),
                _scheduleRow('Saturday', 'Free', 'Gym: Full Body Circuit'),
                _scheduleRow('Sunday', 'Free', 'Active Recovery'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Rules
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Non-Negotiable Rules 🚫', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 16),
                _ruleItem('❌ ZERO softdrinks, milk tea, juice, alcohol'),
                _ruleItem('❌ No fried food (chicken, fries, street food)'),
                _ruleItem('❌ No rice at dinner — EVERY DAY'),
                _ruleItem('✅ 3+ liters of water daily'),
                _ruleItem('✅ Sleep by 10:00 PM'),
                _ruleItem('✅ Weigh yourself every Monday AM'),
                _ruleItem('✅ Progress photos every 2 weeks'),
                _ruleItem('✅ Stand during commute when possible'),
                _ruleItem('✅ Fasted morning cardio on onsite days'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // App info
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('About', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                Text('Fitness Tracker v1.0.0', style: TextStyle(color: Colors.grey[400])),
                const SizedBox(height: 4),
                Text('Built with Flutter • Windows + iOS', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                const SizedBox(height: 4),
                Text('Data stored locally (SharedPreferences)', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 13)),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }

  static Widget _scheduleRow(String day, String type, String workout) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(day, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B35).withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(type, style: const TextStyle(color: Color(0xFFFF6B35), fontSize: 10, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(workout, style: TextStyle(color: Colors.grey[400], fontSize: 12))),
        ],
      ),
    );
  }

  static Widget _ruleItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: TextStyle(color: Colors.grey[300], fontSize: 13)),
    );
  }
}
