import 'package:fitflow/models/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../models/workout_day_model.dart';

class EditWorkoutController extends GetxController {
  late WorkoutPlanModel originalWorkout;

  final titleController = TextEditingController();

  final exercises = <ExerciseModel>[].obs;

  final isRestDay = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is WorkoutPlanModel) {
      originalWorkout = Get.arguments as WorkoutPlanModel;
    } else {
      // Fallback just in case
      originalWorkout = WorkoutPlanModel(
        title: 'Unknown',
        day: WeekDay.monday,
        exercises: [],
      );
    }
    _initializeData();
  }

  void _initializeData() {
    titleController.text = originalWorkout.title;
    isRestDay.value = originalWorkout.title.toLowerCase().contains('rest');
    for (var ex in originalWorkout.exercises) {
      exercises.add(ex);
    }
  }


  void addSelectedExercise(ExerciseModel exercise) {
    exercises.add(exercise);
  }

  void removeExercise(int index) {
    if (index >= 0 && index < exercises.length) {
      // exercises[index].;
      exercises.removeAt(index);
    }
  }

  void toggleRestDay(bool value) {
    isRestDay.value = value;
  }

  void reorderExercises(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = exercises.removeAt(oldIndex);
    exercises.insert(newIndex, item);
  }

  void saveChanges() {
    final newWorkout = WorkoutPlanModel(
      title: isRestDay.value ? 'Rest Day' : titleController.text,
      day: originalWorkout.day,
      exercises: isRestDay.value ? [] : exercises,
      // id: originalWorkout.id,
      // imageUrl: originalWorkout.imageUrl,
    );

    // Depending on architecture, either update a global state, call an API service, 
    // or just return to previous screen with the updated data.
    Get.back(result: newWorkout);
  }

  @override
  void onClose() {
    titleController.dispose();
    super.onClose();
  }
}
