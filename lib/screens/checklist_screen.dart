import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../services/storage_service.dart';

class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: ChecklistScreenContent());
  }
}

class ChecklistScreenContent extends StatefulWidget {
  const ChecklistScreenContent({super.key});

  @override
  State<ChecklistScreenContent> createState() => _ChecklistScreenContentState();
}

class _ChecklistScreenContentState extends State<ChecklistScreenContent> {
  late DailyChecklist _checklist;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadChecklist();
  }

  Future<void> _loadChecklist() async {
    final checklist = await StorageService.getTodayChecklist();
    setState(() {
      _checklist = checklist;
      _loading = false;
    });
  }

  Future<void> _saveChecklist() async {
    await StorageService.saveChecklist(_checklist);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());

    final isOnsite = [1, 2, 4].contains(DateTime.now().weekday);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daily Checklist ✅',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Complete all tasks to maintain your streak!',
            style: TextStyle(color: Colors.grey[400], fontSize: 13),
          ),
          const SizedBox(height: 16),

          // Progress circle
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: _checklist.completionRate,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey[800],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _checklist.completionRate == 1.0
                          ? const Color(0xFF4ECDC4)
                          : const Color(0xFFFF6B35),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '${_checklist.completedCount}/7',
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text('completed', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          if (_checklist.completionRate == 1.0)
            Container(
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF4ECDC4).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF4ECDC4).withOpacity(0.5)),
              ),
              child: const Row(
                children: [
                  Text('🎉', style: TextStyle(fontSize: 24)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Perfect day! All tasks completed. Keep it up!',
                      style: TextStyle(color: Color(0xFF4ECDC4), fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),

          _buildCheckItem(
            '🏃 Fasted Morning Cardio',
            isOnsite
                ? 'Did you do 20-30 min walk/jump rope before breakfast?'
                : 'Optional today (WFH day) - check if done',
            _checklist.fastedCardio,
            (val) => setState(() {
              _checklist.fastedCardio = val;
              _saveChecklist();
            }),
          ),
          _buildCheckItem(
            '🥩 Protein Goal (120g+)',
            'Did you hit at least 120g protein today?',
            _checklist.proteinGoal,
            (val) => setState(() {
              _checklist.proteinGoal = val;
              _saveChecklist();
            }),
          ),
          _buildCheckItem(
            '🚫 No Rice at Dinner',
            'Did you skip rice at dinner tonight?',
            _checklist.noRiceDinner,
            (val) => setState(() {
              _checklist.noRiceDinner = val;
              _saveChecklist();
            }),
          ),
          _buildCheckItem(
            '💧 Water Goal (3L+)',
            'Did you drink at least 3 liters of water?',
            _checklist.waterGoal,
            (val) => setState(() {
              _checklist.waterGoal = val;
              _saveChecklist();
            }),
          ),
          _buildCheckItem(
            '💪 Main Workout Completed',
            'Did you complete your scheduled workout?',
            _checklist.mainWorkout,
            (val) => setState(() {
              _checklist.mainWorkout = val;
              _saveChecklist();
            }),
          ),
          _buildCheckItem(
            '🚫 No Junk Food',
            'No fried food, softdrinks, milk tea, or street food?',
            _checklist.noJunkFood,
            (val) => setState(() {
              _checklist.noJunkFood = val;
              _saveChecklist();
            }),
          ),
          _buildCheckItem(
            '🛌 Sleep by 10 PM',
            'Will you be in bed by 10:00 PM tonight?',
            _checklist.sleepBy10,
            (val) => setState(() {
              _checklist.sleepBy10 = val;
              _saveChecklist();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: value ? const Color(0xFF4ECDC4).withOpacity(0.08) : const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
        border: value ? Border.all(color: const Color(0xFF4ECDC4).withOpacity(0.3)) : null,
      ),
      child: CheckboxListTile(
        value: value,
        onChanged: (v) => onChanged(v ?? false),
        title: Text(
          title,
          style: TextStyle(
            color: value ? const Color(0xFF4ECDC4) : Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            decoration: value ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
        activeColor: const Color(0xFF4ECDC4),
        checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
    );
  }
}
