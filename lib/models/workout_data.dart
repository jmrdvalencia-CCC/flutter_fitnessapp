import '../models/workout_model.dart';

class WorkoutData {
  static List<DailyPlan> getWeeklyPlan() {
    return [
      // MONDAY (Onsite)
      DailyPlan(
        weekday: 1,
        workouts: [
          WorkoutPlan(
            title: '🏃 Fasted Morning Cardio',
            time: '5:00 AM - 5:30 AM',
            location: 'Home - Calamba',
            type: 'cardio',
            durationMinutes: 30,
            estimatedCalories: 200,
            exercises: [
              '20-30 min brisk walk or jump rope',
              'Do BEFORE breakfast',
              'Black coffee + water only',
            ],
          ),
          WorkoutPlan(
            title: '🔥 Interval Sprints + Circuit',
            time: '5:00 PM - 7:00 PM',
            location: 'Makati (Ayala Triangle / Legazpi Park)',
            type: 'cardio',
            durationMinutes: 120,
            estimatedCalories: 700,
            exercises: [
              '5:00-5:10 — Dynamic warm-up',
              '5:10-5:50 — Sprints: 30s sprint / 60s walk x15',
              '5:50-6:30 — Circuit (3 rounds):',
              '  → 15 Push-ups',
              '  → 20 Squats',
              '  → 10 Burpees',
              '  → 20 Lunges (alternating)',
              '  → 30 sec Plank',
              '6:30-6:50 — Steady-state jog',
              '6:50-7:00 — Cool down + stretch',
            ],
          ),
        ],
        meals: _onsiteMeals(),
      ),
      // TUESDAY (Onsite)
      DailyPlan(
        weekday: 2,
        workouts: [
          WorkoutPlan(
            title: '🏃 Fasted Morning Cardio',
            time: '5:00 AM - 5:30 AM',
            location: 'Home - Calamba',
            type: 'cardio',
            durationMinutes: 30,
            estimatedCalories: 200,
            exercises: [
              '20-30 min brisk walk or jump rope',
              'Do BEFORE breakfast',
              'Black coffee + water only',
            ],
          ),
          WorkoutPlan(
            title: '🔥 Interval Sprints + Circuit',
            time: '5:00 PM - 7:00 PM',
            location: 'Makati (Ayala Triangle / Legazpi Park)',
            type: 'cardio',
            durationMinutes: 120,
            estimatedCalories: 700,
            exercises: [
              '5:00-5:10 — Dynamic warm-up',
              '5:10-5:50 — Sprints: 30s sprint / 60s walk x15',
              '5:50-6:30 — Circuit (3 rounds):',
              '  → 15 Push-ups',
              '  → 20 Squats',
              '  → 10 Burpees',
              '  → 20 Lunges (alternating)',
              '  → 30 sec Plank',
              '6:30-6:50 — Steady-state jog',
              '6:50-7:00 — Cool down + stretch',
            ],
          ),
        ],
        meals: _onsiteMeals(),
      ),
      // WEDNESDAY (WFH - Gym)
      DailyPlan(
        weekday: 3,
        workouts: [
          WorkoutPlan(
            title: '💪 Push + Abs + HIIT',
            time: '9:00 AM - 10:30 AM',
            location: 'Anytime Fitness',
            type: 'strength',
            durationMinutes: 90,
            estimatedCalories: 500,
            exercises: [
              'Treadmill incline walk (15%) — 10 min',
              'Barbell Bench Press — 4x10',
              'Incline Dumbbell Press — 3x12',
              'DB Shoulder Press (standing) — 4x10',
              'Lateral Raises — 3x15',
              'Tricep Pushdowns — 3x12',
              'Dips (assisted) — 3x10',
              'ABS: Hanging Leg Raises — 3x12',
              'ABS: Cable Crunches — 3x15',
              'ABS: Mountain Climbers — 3x30s',
              'Finisher: Stairmaster — 20 min',
            ],
          ),
        ],
        meals: _wfhMeals(),
      ),
      // THURSDAY (Onsite)
      DailyPlan(
        weekday: 4,
        workouts: [
          WorkoutPlan(
            title: '🏃 Fasted Morning Cardio',
            time: '5:00 AM - 5:30 AM',
            location: 'Home - Calamba',
            type: 'cardio',
            durationMinutes: 30,
            estimatedCalories: 200,
            exercises: [
              '20-30 min brisk walk or jump rope',
              'Do BEFORE breakfast',
              'Black coffee + water only',
            ],
          ),
          WorkoutPlan(
            title: '🔥 Interval Sprints + Circuit',
            time: '5:00 PM - 7:00 PM',
            location: 'Makati (Ayala Triangle / Legazpi Park)',
            type: 'cardio',
            durationMinutes: 120,
            estimatedCalories: 700,
            exercises: [
              '5:00-5:10 — Dynamic warm-up',
              '5:10-5:50 — Sprints: 30s sprint / 60s walk x15',
              '5:50-6:30 — Circuit (3 rounds):',
              '  → 15 Push-ups',
              '  → 20 Squats',
              '  → 10 Burpees',
              '  → 20 Lunges (alternating)',
              '  → 30 sec Plank',
              '6:30-6:50 — Steady-state jog',
              '6:50-7:00 — Cool down + stretch',
            ],
          ),
        ],
        meals: _onsiteMeals(),
      ),
      // FRIDAY (WFH - Gym)
      DailyPlan(
        weekday: 5,
        workouts: [
          WorkoutPlan(
            title: '💪 Pull + Legs + HIIT',
            time: '9:00 AM - 10:30 AM',
            location: 'Anytime Fitness',
            type: 'strength',
            durationMinutes: 90,
            estimatedCalories: 550,
            exercises: [
              'Rowing machine warm-up — 5 min',
              'Barbell Squats — 4x10',
              'Romanian Deadlifts — 4x10',
              'Leg Press — 3x12',
              'Walking Lunges (weighted) — 3x12 each',
              'Lat Pulldown (wide) — 4x10',
              'Seated Cable Rows — 3x12',
              'Face Pulls — 3x15',
              'Bicep Curls — 3x12',
              'ABS: Plank — 3x45-60s',
              'ABS: Russian Twists — 3x20',
              'ABS: Leg Raises — 3x15',
              'HIIT Bike: 30s sprint / 30s rest x10',
            ],
          ),
        ],
        meals: _wfhMeals(),
      ),
      // SATURDAY (Gym)
      DailyPlan(
        weekday: 6,
        workouts: [
          WorkoutPlan(
            title: '🔥 Full Body Fat Burn Circuit',
            time: '7:00 AM - 8:15 AM',
            location: 'Anytime Fitness',
            type: 'circuit',
            durationMinutes: 75,
            estimatedCalories: 600,
            exercises: [
              'CIRCUIT (4 rounds, 90s rest):',
              '  → Kettlebell Swings — 20',
              '  → Box Jumps/Step-ups — 12',
              '  → Dumbbell Thrusters — 12',
              '  → Pull-ups (assisted) — 8-10',
              '  → Battle Ropes — 30 sec',
              '  → Burpees — 10',
              'Stairmaster — 20 min',
              'Crunches — 3x20',
              'Side Plank — 3x30s each side',
            ],
          ),
        ],
        meals: _wfhMeals(),
      ),
      // SUNDAY (Recovery)
      DailyPlan(
        weekday: 7,
        workouts: [
          WorkoutPlan(
            title: '🚶 Active Recovery',
            time: '7:00 AM - 7:45 AM',
            location: 'Calamba',
            type: 'recovery',
            durationMinutes: 45,
            estimatedCalories: 150,
            exercises: [
              '30-45 min walk around Calamba',
              'Foam rolling / stretching',
              '15 min full body stretch',
              'Focus on sleep and hydration',
            ],
          ),
        ],
        meals: _wfhMeals(),
      ),
    ];
  }

  static List<MealPlan> _onsiteMeals() => [
        MealPlan(
          name: '🍳 Post-Cardio Breakfast',
          time: '6:00 AM',
          description: '3 boiled eggs (2 whole + 1 white) + black coffee',
          calories: 220,
          proteinGrams: 18,
          costPesos: 20,
        ),
        MealPlan(
          name: '🍗 Lunch',
          time: '12:00 PM',
          description: 'Grilled chicken + 1 cup rice + soup/veggies (carinderia)',
          calories: 550,
          proteinGrams: 35,
          costPesos: 60,
        ),
        MealPlan(
          name: '🍌 Pre-Workout',
          time: '4:30 PM',
          description: '1 banana',
          calories: 100,
          proteinGrams: 1,
          costPesos: 10,
        ),
        MealPlan(
          name: '🥗 Dinner (NO RICE)',
          time: '8:00 PM',
          description: 'Canned tuna + sautéed veggies, NO RICE',
          calories: 300,
          proteinGrams: 30,
          costPesos: 40,
        ),
      ];

  static List<MealPlan> _wfhMeals() => [
        MealPlan(
          name: '🍳 Breakfast',
          time: '7:00 AM',
          description: 'Oatmeal + 2 boiled eggs + black coffee',
          calories: 350,
          proteinGrams: 20,
          costPesos: 25,
        ),
        MealPlan(
          name: '🍗 Lunch',
          time: '12:00 PM',
          description: 'Chicken breast (grilled, 150g) + half cup rice + veggies',
          calories: 450,
          proteinGrams: 40,
          costPesos: 65,
        ),
        MealPlan(
          name: '🍌 Pre-Workout',
          time: '2:00 PM',
          description: 'Banana + 1 tbsp peanut butter',
          calories: 200,
          proteinGrams: 5,
          costPesos: 15,
        ),
        MealPlan(
          name: '🥗 Dinner (NO RICE)',
          time: '7:00 PM',
          description: 'Monggo soup + fish, NO RICE',
          calories: 250,
          proteinGrams: 20,
          costPesos: 35,
        ),
      ];

  static double getTargetWeight(int weekNumber) {
    const targets = [78.0, 76.5, 75.5, 74.5, 73.5, 72.5, 71.5, 70.5, 69.5, 68.5, 67.5, 66.5, 65.5];
    if (weekNumber >= targets.length) return 65.0;
    return targets[weekNumber];
  }
}
