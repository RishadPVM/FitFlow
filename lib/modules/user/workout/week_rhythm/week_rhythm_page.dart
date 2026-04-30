import 'dart:ui';

import 'package:fitflow/modules/user/workout/workout_home/widgets/workout_card.dart';
import 'package:fitflow/modules/user/workout/workout_home/workout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/app_loader.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routes/app_routes.dart';
import 'controller/week_list_animation_controller.dart';

class WeekRhythmPage extends GetView<WorkoutController> {
  const WeekRhythmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
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

        return Stack(
          children: [
            Positioned(
              // top: 0,
              bottom: 0,
              right: -150,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.10),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: const SizedBox(),
                ),
              ),
            ),

            Column(
              children: [
                // SizedBox(height: 20),
                // Container(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 16.0,
                //     vertical: 16.0,
                //   ),
                //   child: Row(
                //     children: [
                //       IconButton(
                //         icon: const Icon(
                //           Icons.arrow_back_ios_new_rounded,
                //           color: AppColors.textPrimary,
                //           size: 20,
                //         ),
                //         onPressed: () => Get.back(),
                //       ),

                //       Expanded(
                //         child: Center(
                //           child: Text('Week Rhythm', style: AppTextStyles.h3),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                _buildProgramInfoCard(),
                Expanded(
                  child: GetBuilder<WeekListAnimationController>(
                    init: WeekListAnimationController(),
                    builder: (animController) {
                      return ListWheelScrollView.useDelegate(
                        controller: animController.scrollController,
                        itemExtent:
                            130, // Fits the WorkoutDayCard height + padding
                        perspective: 0.003,
                        diameterRatio: 1.8,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged:
                            animController.onSelectedItemChanged,
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: controller.workoutSession.length,
                          builder: (context, index) {
                            final day = controller.workoutSession[index];
                            final isToday =
                                day == controller.todayWorkout.value;

                            return Obx(() {
                              final isCenter =
                                  index == animController.selectedIndex.value;

                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 300),
                                  opacity: isCenter ? 1.0 : 0.4,
                                  child: AnimatedScale(
                                    duration: const Duration(milliseconds: 300),
                                    scale: isCenter ? 1.0 : 0.85,
                                    child: Container(
                                      decoration: isCenter && !isToday
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.primary
                                                      .withValues(alpha: 0.15),
                                                  blurRadius: 30,
                                                  spreadRadius: -10,
                                                ),
                                              ],
                                            )
                                          : null,
                                      child: WorkoutDayCard(
                                        workout: day,
                                        isEditTap: true,
                                        isToday: isToday,
                                        onEdit: () async {
                                          final result = await Get.toNamed(
                                            AppRoutes.editWorkout,
                                            arguments: day,
                                          );

                                          if (result != null) {
                                            final editIndex = controller
                                                .workoutSession
                                                .indexOf(day);
                                            if (editIndex != -1) {
                                              controller
                                                      .workoutSession[editIndex] =
                                                  result;
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  Widget _buildProgramInfoCard() {
    int totalDuration = controller.workoutSession.fold<int>(
      0,
      (sum, d) => sum + d.exercises.map((e) => e.duration).reduce((a, b) => a + b),
    );

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.surfaceLight, AppColors.surface],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'WEEKLY RHYTHM',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.repeat_rounded,
                      color: AppColors.primary,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Repeats',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(
                icon: Icons.fitness_center_rounded,
                value: '3',
                label: 'Completed',
              ),
              _buildStatItem(
                icon: Icons.timer_rounded,
                value: '$totalDuration',
                label: 'Minutes',
              ),
              _buildStatItem(
                icon: Icons.local_fire_department_rounded,
                value: 'High',
                label: 'Intensity',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 16),
            const SizedBox(width: 6),
            Text(
              value,
              style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
