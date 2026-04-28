import 'dart:developer';

import 'package:get/get.dart';

import '../../../../models/workout_day_model.dart';

class WorkoutController extends GetxController {
  final isLoading = true.obs;

  final todayWorkout = Rxn<WorkoutPlanModel>();
  final workoutSession = RxList<WorkoutPlanModel>();
  final onboardingDone = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadLocalData();
  }

  Future<void> loadLocalData() async {
    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 3));
    onboardingDone.value = false;

    // final prefs = await SharedPreferences.getInstance();
    // onboardingDone.value = prefs.getBool('onboarding_done') ?? false;

    //     if (onboardingDone.value) {
    //   final String? savedPlanStr = prefs.getString('workout_plan');
    //   if (savedPlanStr != null) {
    //     try {
    //       final Map<String, dynamic> planJson = jsonDecode(savedPlanStr);
    //       workoutPlan.value = WorkoutPlan.fromJson(planJson);
    //       _setTodayWorkout();
    //     } catch (e) {
    //       await generateWorkoutPlan();
    //     }
    //   } else {
    //     await generateWorkoutPlan();
    //   }
    // }

    try {
      workoutSession.value.addAll([
        WorkoutPlanModel(
          day: WeekDay.monday,
          duration: 20,
          sets: 17,
          exercises: ['Upper Chest + Delts + Triceps'],
          title: 'Push A',
        ),
        WorkoutPlanModel(
          day: WeekDay.tuesday,
          duration: 20,
          sets: 17,
          exercises: ['Upper Chest + Delts + Triceps'],
          title: 'Push A',
        ),
        WorkoutPlanModel(
          day: WeekDay.wednesday,
          duration: 20,
          sets: 17,
          exercises: ['Upper Chest + Delts + Triceps'],
          title: 'Push A',
        ),
        WorkoutPlanModel(
          day: WeekDay.thursday,
          duration: 20,
          sets: 17,
          exercises: ['Upper Chest + Delts + Triceps'],
          title: 'Push A',
        ),
        WorkoutPlanModel(
          day: WeekDay.friday,
          duration: 20,
          sets: 17,
          exercises: ['Upper Chest + Delts + Triceps'],
          title: 'Push A',
        ),
        WorkoutPlanModel(
          day: WeekDay.saturday,
          duration: 20,
          sets: 17,
          exercises: ['Upper Chest + Delts + Triceps'],
          title: 'Push A',
        ),
        WorkoutPlanModel(
          day: WeekDay.sunday,
          duration: 20,
          sets: 17,
          exercises: ['Upper Chest + Delts + Triceps'],
          title: 'Push A',
        ),
      ]);

      _setTodayWorkout();
    } catch (e) {
      log('error loading data from local storage: ${e.toString()}');
      // await generateWorkoutPlan();
    }

    isLoading.value = false;
  }

  // Future<void> generateWorkoutPlan() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String goal = prefs.getString('user_goal') ?? 'General Fitness';
  //   // final int days = prefs.getInt('days_per_week') ?? 3;
  //   // final int duration = prefs.getInt('session_minutes') ?? 45;

  //   List<WorkoutPlanModel> generatedDays = [];

  //   if (goal == 'Build Muscle') {
  //      generatedDays = [
  //     WorkoutPlanModel(day: WeekDay.monday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //     WorkoutPlanModel(day: WeekDay.tuesday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //     WorkoutPlanModel(day: WeekDay.wednesday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //     WorkoutPlanModel(day: WeekDay.thursday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //     WorkoutPlanModel(day: WeekDay.friday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //     WorkoutPlanModel(day: WeekDay.saturday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //     WorkoutPlanModel(day: WeekDay.sunday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //   ];
  //   } else if (goal == 'Lose Weight') {
  //       generatedDays = [
  //     WorkoutPlanModel(day: WeekDay.monday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //     WorkoutPlanModel(day: WeekDay.tuesday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //     WorkoutPlanModel(day: WeekDay.wednesday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //     WorkoutPlanModel(day: WeekDay.thursday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //     WorkoutPlanModel(day: WeekDay.friday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //     WorkoutPlanModel(day: WeekDay.saturday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //     WorkoutPlanModel(day: WeekDay.sunday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //   ];
  //   } else {
  //        generatedDays = [
  //     WorkoutPlanModel(day: WeekDay.monday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //     WorkoutPlanModel(day: WeekDay.tuesday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //     WorkoutPlanModel(day: WeekDay.wednesday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //     WorkoutPlanModel(day: WeekDay.thursday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //     WorkoutPlanModel(day: WeekDay.friday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //     WorkoutPlanModel(day: WeekDay.saturday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //     WorkoutPlanModel(day: WeekDay.sunday,duration: 20 ,sets: 17, exercises: ['Upper Chest + Delts + Triceps'],title: 'Push A',),
  //   ];

  //   }

  //   _setTodayWorkout();
  // }

  void _setTodayWorkout() {
    final daysOfWeek = [
      'MONDAY',
      'TUESDAY',
      'WEDNESDAY',
      'THURSDAY',
      'FRIDAY',
      'SATURDAY',
      'SUNDAY',
    ];

    final now = DateTime.now();
    final dayIndex = now.weekday - 1;

    todayWorkout.value = workoutSession.firstWhere(
      (day) => day.day.name.toLowerCase() == daysOfWeek[dayIndex].toLowerCase(),
    );
  }

  List<WorkoutPlanModel> getThreeDayWorkout() {
    if (workoutSession.isEmpty) return [];

    final now = DateTime.now();
    final todayIndex = now.weekday - 1;

    final yesterdayIndex = (todayIndex - 1) < 0 ? 6 : todayIndex - 1;
    final tomorrowIndex = (todayIndex + 1) > 6 ? 0 : todayIndex + 1;

    return [
      workoutSession[yesterdayIndex],
      workoutSession[todayIndex],
      workoutSession[tomorrowIndex],
    ];
  }
}
