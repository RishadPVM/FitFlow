import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../models/workout_day_model.dart';

class EditWorkoutController extends GetxController {
  late WorkoutPlanModel originalWorkout;

  final titleController = TextEditingController();

  final exercises = <TextEditingController>[].obs;
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
        duration: 45,
        sets: 10,
      );
    }
    _initializeData();
  }

  void _initializeData() {
    titleController.text = originalWorkout.title;
    isRestDay.value = originalWorkout.title.toLowerCase().contains('rest');
    for (var ex in originalWorkout.exercises) {
      exercises.add(TextEditingController(text: ex));
    }
  }


  void addExercise() {
    exercises.add(TextEditingController(text: ''));
  }

  void removeExercise(int index) {
    if (index >= 0 && index < exercises.length) {
      exercises[index].dispose();
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
      exercises: isRestDay.value ? [] : exercises.map((e) => e.text).toList(),
      duration: isRestDay.value ? 0 : originalWorkout.duration,
      sets: isRestDay.value ? 0 : originalWorkout.sets,
    );
    // Depending on architecture, either update a global state, call an API service, 
    // or just return to previous screen with the updated data.
    Get.back(result: newWorkout);
  }

  @override
  void onClose() {
    titleController.dispose();
    for (var controller in exercises) {
      controller.dispose();
    }
    super.onClose();
  }
}
