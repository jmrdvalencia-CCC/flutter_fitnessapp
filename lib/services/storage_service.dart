import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/workout_model.dart';

class StorageService {
  static const _weightKey = 'weight_entries';
  static const _checklistKey = 'checklist_entries';

  // Weight entries
  static Future<List<WeightEntry>> getWeightEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_weightKey);
    if (data == null) return [];
    final list = jsonDecode(data) as List;
    return list.map((e) => WeightEntry.fromJson(e)).toList();
  }

  static Future<void> addWeightEntry(WeightEntry entry) async {
    final entries = await getWeightEntries();
    entries.add(entry);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_weightKey, jsonEncode(entries.map((e) => e.toJson()).toList()));
  }

  static Future<void> deleteWeightEntry(int index) async {
    final entries = await getWeightEntries();
    if (index < entries.length) {
      entries.removeAt(index);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_weightKey, jsonEncode(entries.map((e) => e.toJson()).toList()));
    }
  }

  // Daily checklist
  static Future<DailyChecklist> getTodayChecklist() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_checklistKey);
    if (data == null) return DailyChecklist(date: DateTime.now());

    final list = jsonDecode(data) as List;
    final today = DateTime.now();
    for (final item in list) {
      final checklist = DailyChecklist.fromJson(item);
      if (checklist.date.year == today.year &&
          checklist.date.month == today.month &&
          checklist.date.day == today.day) {
        return checklist;
      }
    }
    return DailyChecklist(date: today);
  }

  static Future<void> saveChecklist(DailyChecklist checklist) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_checklistKey);
    List<dynamic> list = data != null ? jsonDecode(data) as List : [];

    // Remove existing entry for the same day
    list.removeWhere((item) {
      final existing = DailyChecklist.fromJson(item);
      return existing.date.year == checklist.date.year &&
          existing.date.month == checklist.date.month &&
          existing.date.day == checklist.date.day;
    });

    list.add(checklist.toJson());
    await prefs.setString(_checklistKey, jsonEncode(list));
  }

  static Future<List<DailyChecklist>> getAllChecklists() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_checklistKey);
    if (data == null) return [];
    final list = jsonDecode(data) as List;
    return list.map((e) => DailyChecklist.fromJson(e)).toList();
  }

  static Future<int> getStreakDays() async {
    final checklists = await getAllChecklists();
    if (checklists.isEmpty) return 0;

    checklists.sort((a, b) => b.date.compareTo(a.date));
    int streak = 0;
    final today = DateTime.now();

    for (int i = 0; i < checklists.length; i++) {
      final expected = today.subtract(Duration(days: i));
      final entry = checklists[i];
      if (entry.date.year == expected.year &&
          entry.date.month == expected.month &&
          entry.date.day == expected.day &&
          entry.completionRate >= 0.5) {
        streak++;
      } else {
        break;
      }
    }
    return streak;
  }
}
