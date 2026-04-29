import 'dart:ui';

import 'package:fitflow/modules/user/workout/workout_player/widgets/summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'widgets/action_buttons.dart';
import 'widgets/exercise_preview.dart';
import 'widgets/timer_section.dart';
import 'widgets/workout_header.dart';
import 'widgets/workout_info_card.dart';
import 'workout_player_controller.dart';

class WorkoutPlayerPage extends GetView<WorkoutPlayerController> {
  const WorkoutPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<WorkoutPlayerController>()) {
      Get.put(WorkoutPlayerController());
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        if (controller.isFinished.value) {
          return WorkoutPlayerSummary(controller: controller);
        }

        final exercise = controller.currentExercise;
        if (exercise == null) return const SizedBox();

        return Stack(
          children: [
            // 1. Immersive Header Image Background
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.5,
              child: ExercisePreview(
                imageUrl: exercise.imageUrl,
                muscle: exercise.muscle,
              ),
            ),

            // 2. Foreground Content
            Positioned.fill(
              child: Column(
                children: [
                  _buildTopBar(context),
                  const Spacer(),

                  // 3. Dynamic Interactive Container
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 32.0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 40,
                          offset: const Offset(0, -10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WorkoutHeader(
                          workoutName: exercise.name,
                          currentSet: controller.currentSet.value,
                          totalSets: exercise.sets,
                          progress: controller.progress,
                        ),
                        const SizedBox(height: 32),
                        WorkoutInfoCard(
                          reps: exercise.reps,
                          totalSets: exercise.sets,
                          currentSet: controller.currentSet.value,
                        ),
                        const SizedBox(height: 32),
                        if (controller.isWorkoutActive.value)
                          TimerSection(
                            isResting: controller.isResting.value,
                            activeTime: controller.formattedActiveExerciseTime,
                            restTime: controller.formattedRestTime,
                          )
                        else
                          const SizedBox(
                            height: 120,
                          ), // Preserves layout space for Timer
                        const SizedBox(height: 32),
                        ActionButtons(
                          isWorkoutActive: controller.isWorkoutActive.value,
                          isResting: controller.isResting.value,
                          onStart: controller.startWorkout,
                          onCompleteSet: controller.completeSet,
                          onSkipRest: controller.skipRest,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surface.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.divider.withValues(alpha: 0.3),
                      ),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: AppColors.textPrimary,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.divider.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        color: AppColors.textPrimary,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Obx(
                        () => Text(
                          controller.formattedWorkoutTime,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
