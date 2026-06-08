import 'package:flutter/material.dart';
import '../models/workout_data.dart';
import '../models/workout_model.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: PlanScreenContent());
  }
}

class PlanScreenContent extends StatelessWidget {
  const PlanScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = WorkoutData.getWeeklyPlan();
    final dayNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final dayTags = ['Onsite', 'Onsite', 'WFH/Gym', 'Onsite', 'WFH/Gym', 'Gym', 'Rest'];
    final today = DateTime.now().weekday;

    return DefaultTabController(
      length: 7,
      initialIndex: today - 1,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                const Text(
                  'Weekly Plan 📋',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
          TabBar(
            isScrollable: true,
            labelColor: const Color(0xFFFF6B35),
            unselectedLabelColor: Colors.grey,
            indicatorColor: const Color(0xFFFF6B35),
            labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            tabs: List.generate(7, (i) => Tab(text: dayNames[i].substring(0, 3))),
          ),
          Expanded(
            child: TabBarView(
              children: List.generate(7, (i) {
                final plan = plans[i];
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            dayNames[i],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF6B35).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              dayTags[i],
                              style: const TextStyle(color: Color(0xFFFF6B35), fontSize: 11, fontWeight: FontWeight.w600),
                            ),
                          ),
                          if (i + 1 == today) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4ECDC4).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text('TODAY', style: TextStyle(color: Color(0xFF4ECDC4), fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B35).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.local_fire_department, color: Color(0xFFFF6B35), size: 18),
                            const SizedBox(width: 6),
                            Text(
                              'Est. burn: ${plan.workouts.fold(0, (sum, w) => sum + w.estimatedCalories)} cal',
                              style: const TextStyle(color: Color(0xFFFF6B35), fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 16),
                            const Icon(Icons.timer, color: Colors.grey, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${plan.workouts.fold(0, (sum, w) => sum + w.durationMinutes)} min',
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('WORKOUTS', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
                      const SizedBox(height: 10),
                      ...plan.workouts.map((w) => _workoutDetailCard(w)),
                      const SizedBox(height: 20),
                      const Text('MEALS', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
                      const SizedBox(height: 10),
                      ...plan.meals.map((m) => _mealDetailCard(m)),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _workoutDetailCard(WorkoutPlan w) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(w.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 4),
          Text('${w.time} • ${w.location}', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
          const SizedBox(height: 4),
          Text('${w.durationMinutes} min • ~${w.estimatedCalories} cal burn', style: const TextStyle(color: Color(0xFF4ECDC4), fontSize: 12)),
          const Divider(color: Colors.grey, height: 20),
          ...w.exercises.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: Colors.grey[500])),
                    Expanded(child: Text(e, style: TextStyle(color: Colors.grey[300], fontSize: 13))),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _mealDetailCard(MealPlan m) {
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
                Text(m.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 2),
                Text('${m.time} — ${m.description}', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${m.calories} cal', style: const TextStyle(color: Color(0xFF4ECDC4), fontSize: 11, fontWeight: FontWeight.w600)),
              Text('${m.proteinGrams}g P • ₱${m.costPesos}', style: TextStyle(color: Colors.grey[500], fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}
