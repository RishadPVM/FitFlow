import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'workout_player_controller.dart';
import 'widgets/exercise_card.dart';
import 'widgets/progress_bar.dart';
import 'widgets/timer_widget.dart';
import 'widgets/control_buttons.dart';

class WorkoutPlayerPage extends GetView<WorkoutPlayerController> {
  const WorkoutPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<WorkoutPlayerController>()) {
      Get.put(WorkoutPlayerController());
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Glows
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                child: const SizedBox(),
              ),
            ),
          ),

          SafeArea(
            child: Obx(() {
              if (controller.isFinished.value) {
                return _buildSummaryScreen();
              }

              final exercise = controller.currentExercise;
              if (exercise == null) return const SizedBox();

              return Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          WorkoutProgressBar(
                            currentIndex: controller.currentExerciseIndex.value,
                            totalCount:
                                controller.session.value?.exercises.length ?? 1,
                            progress: controller.progress,
                          ),
                          const SizedBox(height: 40),

                          if (controller.isResting.value)
                            TimerWidget(
                              seconds: controller.restTimeSeconds.value,
                              label: 'REST TIME',
                            )
                          else
                            ExerciseCard(exercise: exercise),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: ControlButtons(
                      isResting: controller.isResting.value,
                      onPrevious: controller.previousExercise,
                      onSkip: controller.isResting.value
                          ? controller.skipRest
                          : controller.skipExercise,
                      onComplete: controller.completeExercise,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.divider),
              ),
              child: const Icon(
                Icons.close_rounded,
                color: AppColors.textPrimary,
                size: 24,
              ),
            ),
          ),
          Obx(
            () => Text(
              controller.formattedWorkoutTime,
              style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary),
            ),
          ),
          const SizedBox(width: 40), // Balance the flex
        ],
      ),
    );
  }

  Widget _buildSummaryScreen() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.emoji_events_rounded,
              color: AppColors.primary,
              size: 80,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Workout Complete!',
            style: AppTextStyles.h1.copyWith(
              color: AppColors.textPrimary,
              fontSize: 32,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Great job crushing today\'s routine.',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          _buildSummaryStat(
            icon: Icons.timer_outlined,
            title: 'Total Time',
            value: controller.formattedWorkoutTime,
          ),
          const SizedBox(height: 16),
          _buildSummaryStat(
            icon: Icons.local_fire_department_outlined,
            title: 'Calories Burned',
            value: '350 kcal', // In a real app, calculate this
          ),
          const SizedBox(height: 16),
          _buildSummaryStat(
            icon: Icons.fitness_center_rounded,
            title: 'Exercises Completed',
            value: '${controller.session.value?.completedExercises ?? 0}',
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              onPressed: () {
                Get.back(); // Return to dashboard
              },
              child: Text(
                'Finish Workout',
                style: AppTextStyles.buttonText.copyWith(
                  color: AppColors.background,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStat({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
