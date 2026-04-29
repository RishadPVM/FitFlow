import 'package:fitflow/modules/user/workout/workout_home/workout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeekListAnimationController extends GetxController {
  late FixedExtentScrollController scrollController;
  final RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final workoutController = Get.find<WorkoutController>();

    int initialIndex = workoutController.workoutSession.indexOf(
      workoutController.todayWorkout.value,
    );
    if (initialIndex == -1) initialIndex = 0;

    selectedIndex.value = initialIndex;

    scrollController = FixedExtentScrollController(initialItem: initialIndex);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void onSelectedItemChanged(int index) {
    selectedIndex.value = index;
  }
}
