import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/workout_plan_model.dart';
import 'models/workout_day_model.dart';

class WorkoutController extends GetxController {
  final isLoading = true.obs;
  final workoutPlan = Rxn<WorkoutPlan>();
  final selectedTab = 0.obs;
  final todayWorkout = Rxn<WorkoutDay>();
  final onboardingDone = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadLocalData();
  }

  Future<void> loadLocalData() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    
    onboardingDone.value = prefs.getBool('onboarding_done') ?? false;
    
    // If not done, redirect to goals flow could happen from the view
    if (onboardingDone.value) {
      final String? savedPlanStr = prefs.getString('workout_plan');
      if (savedPlanStr != null) {
        try {
          final Map<String, dynamic> planJson = jsonDecode(savedPlanStr);
          workoutPlan.value = WorkoutPlan.fromJson(planJson);
          _setTodayWorkout();
        } catch (e) {
          await generateWorkoutPlan();
        }
      } else {
        await generateWorkoutPlan();
      }
    }

    isLoading.value = false;
  }

  Future<void> generateWorkoutPlan() async {
    final prefs = await SharedPreferences.getInstance();
    final String goal = prefs.getString('user_goal') ?? 'General Fitness';
    final int days = prefs.getInt('days_per_week') ?? 3;
    final int duration = prefs.getInt('session_minutes') ?? 45;

    List<WorkoutDay> generatedDays = [];

    if (goal == 'Build Muscle') {
      generatedDays.add(WorkoutDay(title: 'Push Day', exercisesCount: 6, duration: duration, calories: 350, type: 'Upper Body'));
      generatedDays.add(WorkoutDay(title: 'Pull Day', exercisesCount: 6, duration: duration, calories: 340, type: 'Upper Body'));
      generatedDays.add(WorkoutDay(title: 'Leg Day', exercisesCount: 5, duration: duration, calories: 400, type: 'Lower Body'));
      if (days > 3) generatedDays.add(WorkoutDay(title: 'Full Body', exercisesCount: 8, duration: duration, calories: 450, type: 'Full Body'));
      if (days > 4) generatedDays.add(WorkoutDay(title: 'Active Recovery', exercisesCount: 3, duration: 20, calories: 150, type: 'Recovery'));
    } else if (goal == 'Lose Weight') {
      for (int i = 0; i < days; i++) {
        if (i % 2 == 0) {
          generatedDays.add(WorkoutDay(title: 'HIIT Circuit', exercisesCount: 8, duration: duration, calories: 450, type: 'Cardio'));
        } else {
          generatedDays.add(WorkoutDay(title: 'Light Strength', exercisesCount: 5, duration: duration, calories: 300, type: 'Full Body'));
        }
      }
    } else {
      for (int i = 0; i < days; i++) {
        generatedDays.add(WorkoutDay(title: 'Balanced Routine', exercisesCount: 6, duration: duration, calories: 300, type: 'Full Body'));
      }
    }

    if (generatedDays.isEmpty) {
        generatedDays.add(WorkoutDay(title: 'Balanced Routine', exercisesCount: 6, duration: duration, calories: 300, type: 'Full Body'));
    }

    final newPlan = WorkoutPlan(days: generatedDays.take(days).toList());
    workoutPlan.value = newPlan;
    _setTodayWorkout();
    
    await savePlan(newPlan);
  }

  void _setTodayWorkout() {
    if (workoutPlan.value != null && workoutPlan.value!.days.isNotEmpty) {
      todayWorkout.value = workoutPlan.value!.days.first;
    }
  }

  Future<void> savePlan(WorkoutPlan plan) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('workout_plan', jsonEncode(plan.toJson()));
  }

  void markWorkoutComplete() {
    Get.snackbar('Great Job!', 'Workout marked as complete.',
        snackPosition: SnackPosition.BOTTOM);
  }

  void setTab(int index) {
    selectedTab.value = index;
  }
}
