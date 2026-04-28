import 'package:fitflow/modules/user/workout/workout_home/widgets/week_rhythm_card.dart';
import 'package:fitflow/modules/user/workout/workout_home/workout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/app_loader.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class WeekRhythmPage extends GetView<WorkoutController> {
  const WeekRhythmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Week Rhythm', style: AppTextStyles.h3),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.textPrimary,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: AppLoader());
        }

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          itemCount: controller.workoutSession.length,
          itemBuilder: (context, index) {
            final day = controller.workoutSession[index];
            final isToday = day == controller.todayWorkout.value;
            return WeekRhythmCard(
              workout: day,
              isEditTap: true,
              isToday: isToday,
            );
          },
        );
      }),
    );
  }
}
