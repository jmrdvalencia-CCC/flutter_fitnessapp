import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../models/workout_model.dart';
import '../models/workout_data.dart';
import '../services/storage_service.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: ProgressScreenContent());
  }
}

class ProgressScreenContent extends StatefulWidget {
  const ProgressScreenContent({super.key});

  @override
  State<ProgressScreenContent> createState() => _ProgressScreenContentState();
}

class _ProgressScreenContentState extends State<ProgressScreenContent> {
  List<WeightEntry> _entries = [];
  final _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final entries = await StorageService.getWeightEntries();
    setState(() => _entries = entries);
  }

  Future<void> _addWeight() async {
    final weight = double.tryParse(_weightController.text);
    if (weight == null || weight < 40 || weight > 150) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid weight (40-150 kg)')),
      );
      return;
    }
    await StorageService.addWeightEntry(WeightEntry(date: DateTime.now(), weight: weight));
    _weightController.clear();
    await _loadEntries();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logged: ${weight.toStringAsFixed(1)} kg ✅'),
          backgroundColor: const Color(0xFF4ECDC4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final startDate = DateTime(2025, 6, 9);
    final currentWeek = ((DateTime.now().difference(startDate).inDays) / 7).ceil().clamp(0, 12);
    final targetThisWeek = WorkoutData.getTargetWeight(currentWeek);
    final currentWeight = _entries.isNotEmpty ? _entries.last.weight : 78.0;
    final totalLost = 78.0 - currentWeight;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Progress Tracker 📊',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text('Week $currentWeek of 12', style: TextStyle(color: Colors.grey[400])),
          const SizedBox(height: 20),

          Row(
            children: [
              _statBox('Total Lost', '${totalLost.toStringAsFixed(1)} kg', const Color(0xFF4ECDC4)),
              const SizedBox(width: 10),
              _statBox('This Week Target', '${targetThisWeek.toStringAsFixed(1)} kg', const Color(0xFFFF6B35)),
              const SizedBox(width: 10),
              _statBox(
                'Status',
                currentWeight <= targetThisWeek ? 'On Track ✅' : 'Behind ⚠️',
                currentWeight <= targetThisWeek ? const Color(0xFF4ECDC4) : Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Add weight
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _weightController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter weight (kg)',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      prefixIcon: const Icon(Icons.monitor_weight, color: Color(0xFF4ECDC4)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey[700]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF4ECDC4)),
                      ),
                    ),
                    onSubmitted: (_) => _addWeight(),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _addWeight,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B35),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Log', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Chart
          if (_entries.length >= 2) ...[
            const Text('Weight Trend', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
            const SizedBox(height: 12),
            Container(
              height: 220,
              padding: const EdgeInsets.fromLTRB(0, 16, 16, 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 2,
                    getDrawingHorizontalLine: (value) => FlLine(color: Colors.grey[800]!, strokeWidth: 0.5),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 2,
                        getTitlesWidget: (val, meta) => Text(
                          '${val.toInt()}',
                          style: TextStyle(color: Colors.grey[500], fontSize: 10),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (val, meta) {
                          final idx = val.toInt();
                          if (idx >= 0 && idx < _entries.length && idx % 2 == 0) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                DateFormat('M/d').format(_entries[idx].date),
                                style: TextStyle(color: Colors.grey[500], fontSize: 9),
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  minY: 63,
                  maxY: 80,
                  lineBarsData: [
                    LineChartBarData(
                      spots: _entries.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.weight)).toList(),
                      isCurved: true,
                      color: const Color(0xFF4ECDC4),
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(show: true, color: const Color(0xFF4ECDC4).withOpacity(0.1)),
                    ),
                    LineChartBarData(
                      spots: [const FlSpot(0, 78), FlSpot((_entries.length - 1).toDouble().clamp(1, 100), 66)],
                      isCurved: false,
                      color: const Color(0xFFFF6B35).withOpacity(0.5),
                      barWidth: 1.5,
                      dashArray: [8, 4],
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],

          if (_entries.length < 2)
            Container(
              height: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.show_chart, color: Colors.grey[600], size: 40),
                  const SizedBox(height: 8),
                  Text('Log at least 2 weights to see the chart', style: TextStyle(color: Colors.grey[500])),
                ],
              ),
            ),

          const SizedBox(height: 24),
          if (_entries.isNotEmpty) ...[
            const Text('Weight History', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
            const SizedBox(height: 12),
            ..._entries.reversed.take(10).map((e) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A2E),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat('MMM d, yyyy (EEE)').format(e.date), style: TextStyle(color: Colors.grey[300])),
                      Text(
                        '${e.weight.toStringAsFixed(1)} kg',
                        style: const TextStyle(color: Color(0xFF4ECDC4), fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                )),
          ],
        ],
      ),
    );
  }

  Widget _statBox(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 10), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }
}
