import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/workout_history_model.dart';

class HistoryController extends GetxController {
  final historyList = <WorkoutHistoryModel>[].obs;
  
  final totalWorkouts = 0.obs;
  final totalCalories = 0.obs;
  final totalDuration = 0.obs;
  final streak = 0.obs;
  
  final selectedMonth = DateTime.now().obs;
  final selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? historyJson = prefs.getString('workout_history');
    
    if (historyJson != null) {
      try {
        final List<dynamic> decodedList = jsonDecode(historyJson);
        historyList.value = decodedList.map((e) => WorkoutHistoryModel.fromJson(e)).toList();
      } catch (e) {
        historyList.value = [];
      }
    }
    
    calculateStats();
    calculateStreak();
  }

  Future<void> saveWorkout(WorkoutHistoryModel workout) async {
    historyList.add(workout);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('workout_history', jsonEncode(historyList.map((e) => e.toJson()).toList()));
    
    calculateStats();
    calculateStreak();
  }

  void calculateStats() {
    totalWorkouts.value = historyList.length;
    
    int cals = 0;
    int duration = 0;
    for (var w in historyList) {
      cals += w.calories;
      duration += w.duration;
    }
    
    totalCalories.value = cals;
    totalDuration.value = duration;
  }

  void calculateStreak() {
    if (historyList.isEmpty) {
      streak.value = 0;
      return;
    }

    final sorted = historyList.toList()..sort((a, b) => b.date.compareTo(a.date));
    
    final uniqueDates = sorted.map((e) => DateTime(e.date.year, e.date.month, e.date.day)).toSet().toList();
    
    int currentStreak = 0;
    DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime yesterday = today.subtract(const Duration(days: 1));
    
    if (uniqueDates.isEmpty) {
      streak.value = 0;
      return;
    }

    if (uniqueDates.first.isAtSameMomentAs(today)) {
      currentStreak = 1;
      DateTime checkDate = yesterday;
      for (int i = 1; i < uniqueDates.length; i++) {
        if (uniqueDates[i].isAtSameMomentAs(checkDate)) {
          currentStreak++;
          checkDate = checkDate.subtract(const Duration(days: 1));
        } else {
          break;
        }
      }
    } else if (uniqueDates.first.isAtSameMomentAs(yesterday)) {
      currentStreak = 1;
      DateTime checkDate = yesterday.subtract(const Duration(days: 1));
      for (int i = 1; i < uniqueDates.length; i++) {
        if (uniqueDates[i].isAtSameMomentAs(checkDate)) {
          currentStreak++;
          checkDate = checkDate.subtract(const Duration(days: 1));
        } else {
          break;
        }
      }
    }
    
    streak.value = currentStreak;
  }

  Map<DateTime, List<WorkoutHistoryModel>> groupByDate() {
    Map<DateTime, List<WorkoutHistoryModel>> map = {};
    for (var w in historyList) {
      DateTime d = DateTime(w.date.year, w.date.month, w.date.day);
      if (map[d] == null) {
        map[d] = [];
      }
      map[d]!.add(w);
    }
    return map;
  }

  List<WorkoutHistoryModel> getWorkoutsByDate(DateTime date) {
    DateTime target = DateTime(date.year, date.month, date.day);
    return historyList.where((w) {
      DateTime d = DateTime(w.date.year, w.date.month, w.date.day);
      return d.isAtSameMomentAs(target);
    }).toList();
  }

  void onDateSelected(DateTime date) {
    selectedDate.value = date;
  }

  void onMonthChanged(DateTime month) {
    selectedMonth.value = month;
  }
}
