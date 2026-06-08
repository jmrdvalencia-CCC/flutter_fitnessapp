import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/workout_data.dart';
import '../models/workout_model.dart';
import '../services/storage_service.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: TodayScreenContent());
  }
}

class TodayScreenContent extends StatefulWidget {
  const TodayScreenContent({super.key});

  @override
  State<TodayScreenContent> createState() => _TodayScreenContentState();
}

class _TodayScreenContentState extends State<TodayScreenContent> {
  late DailyPlan _todayPlan;
  int _streak = 0;
  double _currentWeight = 78.0;
  final DateTime _targetDate = DateTime(2025, 8, 29);

  @override
  void initState() {
    super.initState();
    final weekday = DateTime.now().weekday;
    final plans = WorkoutData.getWeeklyPlan();
    _todayPlan = plans.firstWhere((p) => p.weekday == weekday);
    _loadData();
  }

  Future<void> _loadData() async {
    final streak = await StorageService.getStreakDays();
    final entries = await StorageService.getWeightEntries();
    setState(() {
      _streak = streak;
      if (entries.isNotEmpty) {
        _currentWeight = entries.last.weight;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysLeft = _targetDate.difference(now).inDays;
    final dayName = DateFormat('EEEE').format(now);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good ${_getGreeting()}! 💪',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    '$dayName, ${DateFormat('MMM d').format(now)}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B35).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '🔥 $_streak day streak',
                  style: const TextStyle(color: Color(0xFFFF6B35), fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Stats Cards
          Row(
            children: [
              _buildStatCard('Current', '${_currentWeight.toStringAsFixed(1)} kg', Icons.monitor_weight, const Color(0xFF4ECDC4)),
              const SizedBox(width: 12),
              _buildStatCard('Target', '65-68 kg', Icons.flag, const Color(0xFFFF6B35)),
              const SizedBox(width: 12),
              _buildStatCard('Days Left', '$daysLeft', Icons.timer, const Color(0xFFE040FB)),
            ],
          ),
          const SizedBox(height: 12),

          // Progress bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Weight Loss Progress', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    Text(
                      '${(78.0 - _currentWeight).toStringAsFixed(1)} / 12 kg lost',
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: ((78.0 - _currentWeight) / 12.0).clamp(0.0, 1.0),
                    minHeight: 10,
                    backgroundColor: Colors.grey[800],
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4ECDC4)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Today's Workouts
          const Text(
            "TODAY'S WORKOUTS",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2),
          ),
          const SizedBox(height: 12),
          ..._todayPlan.workouts.map((w) => _buildWorkoutCard(w)),

          const SizedBox(height: 24),
          // Today's Meals
          const Text(
            "TODAY'S MEALS",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2),
          ),
          const SizedBox(height: 12),
          ..._todayPlan.meals.map((m) => _buildMealCard(m)),

          const SizedBox(height: 16),
          // Total nutrition
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF4ECDC4).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF4ECDC4).withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNutrientInfo('Calories', '${_todayPlan.meals.fold(0, (sum, m) => sum + m.calories)}', 'kcal'),
                _buildNutrientInfo('Protein', '${_todayPlan.meals.fold(0, (sum, m) => sum + m.proteinGrams)}', 'g'),
                _buildNutrientInfo('Cost', '₱${_todayPlan.meals.fold(0, (sum, m) => sum + m.costPesos)}', ''),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 6),
            Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
            Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(WorkoutPlan workout) {
    final typeColors = {
      'cardio': const Color(0xFFFF6B35),
      'strength': const Color(0xFF4ECDC4),
      'circuit': const Color(0xFFE040FB),
      'recovery': const Color(0xFF66BB6A),
    };
    final color = typeColors[workout.type] ?? Colors.blue;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: color, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(workout.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                child: Text('${workout.estimatedCalories} cal', style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text('${workout.time} • ${workout.location}', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
          const SizedBox(height: 8),
          ...workout.exercises.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(e, style: TextStyle(color: Colors.grey[300], fontSize: 12)),
              )),
        ],
      ),
    );
  }

  Widget _buildMealCard(MealPlan meal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(meal.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 3),
                Text(meal.description, style: TextStyle(color: Colors.grey[400], fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${meal.calories} cal', style: const TextStyle(color: Color(0xFF4ECDC4), fontSize: 12, fontWeight: FontWeight.w600)),
              Text('${meal.proteinGrams}g protein', style: TextStyle(color: Colors.grey[500], fontSize: 10)),
              Text('₱${meal.costPesos}', style: TextStyle(color: Colors.grey[500], fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientInfo(String label, String value, String unit) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 11)),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              TextSpan(text: ' $unit', style: TextStyle(color: Colors.grey[400], fontSize: 11)),
            ],
          ),
        ),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Morning';
    if (hour < 17) return 'Afternoon';
    return 'Evening';
  }
}
