class WorkoutPlan {
  final String title;
  final String time;
  final String location;
  final List<String> exercises;
  final String type; // cardio, strength, circuit, recovery
  final int durationMinutes;
  final int estimatedCalories;

  WorkoutPlan({
    required this.title,
    required this.time,
    required this.location,
    required this.exercises,
    required this.type,
    required this.durationMinutes,
    required this.estimatedCalories,
  });
}

class DailyPlan {
  final int weekday; // 1=Mon, 7=Sun
  final List<WorkoutPlan> workouts;
  final List<MealPlan> meals;

  DailyPlan({
    required this.weekday,
    required this.workouts,
    required this.meals,
  });
}

class MealPlan {
  final String name;
  final String time;
  final String description;
  final int calories;
  final int proteinGrams;
  final int costPesos;

  MealPlan({
    required this.name,
    required this.time,
    required this.description,
    required this.calories,
    required this.proteinGrams,
    required this.costPesos,
  });
}

class WeightEntry {
  final DateTime date;
  final double weight;

  WeightEntry({required this.date, required this.weight});

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'weight': weight,
      };

  factory WeightEntry.fromJson(Map<String, dynamic> json) => WeightEntry(
        date: DateTime.parse(json['date']),
        weight: json['weight'].toDouble(),
      );
}

class DailyChecklist {
  final DateTime date;
  bool fastedCardio;
  bool proteinGoal;
  bool noRiceDinner;
  bool waterGoal;
  bool mainWorkout;
  bool noJunkFood;
  bool sleepBy10;

  DailyChecklist({
    required this.date,
    this.fastedCardio = false,
    this.proteinGoal = false,
    this.noRiceDinner = false,
    this.waterGoal = false,
    this.mainWorkout = false,
    this.noJunkFood = false,
    this.sleepBy10 = false,
  });

  int get completedCount {
    int count = 0;
    if (fastedCardio) count++;
    if (proteinGoal) count++;
    if (noRiceDinner) count++;
    if (waterGoal) count++;
    if (mainWorkout) count++;
    if (noJunkFood) count++;
    if (sleepBy10) count++;
    return count;
  }

  double get completionRate => completedCount / 7.0;

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'fastedCardio': fastedCardio,
        'proteinGoal': proteinGoal,
        'noRiceDinner': noRiceDinner,
        'waterGoal': waterGoal,
        'mainWorkout': mainWorkout,
        'noJunkFood': noJunkFood,
        'sleepBy10': sleepBy10,
      };

  factory DailyChecklist.fromJson(Map<String, dynamic> json) => DailyChecklist(
        date: DateTime.parse(json['date']),
        fastedCardio: json['fastedCardio'] ?? false,
        proteinGoal: json['proteinGoal'] ?? false,
        noRiceDinner: json['noRiceDinner'] ?? false,
        waterGoal: json['waterGoal'] ?? false,
        mainWorkout: json['mainWorkout'] ?? false,
        noJunkFood: json['noJunkFood'] ?? false,
        sleepBy10: json['sleepBy10'] ?? false,
      );
}
