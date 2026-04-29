
import 'package:fitflow/core/theme/app_colors.dart';
import 'package:fitflow/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:fitflow/modules/user/workout/workout_player/workout_player_controller.dart';
import 'package:get/get.dart';

class WorkoutPlayerSummary extends StatelessWidget {
  final WorkoutPlayerController controller;
  const WorkoutPlayerSummary({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        // Premium Background Glow
        Positioned(
          top: -100,
          right: -50,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.15),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
              child: const SizedBox(),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [AppColors.primaryBlue, AppColors.primary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.4),
                          blurRadius: 40,
                          spreadRadius: 10,
                        )
                      ],
                    ),
                    child: const Icon(
                      Icons.emoji_events_rounded,
                      color: AppColors.background,
                      size: 80,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                Text(
                  'Workout\nCompleted 🎉',
                  style: AppTextStyles.h1.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 48,
                    height: 1.1,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Incredible effort. You pushed your limits and got one step closer to your goals.',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                _buildSummaryStat(
                  icon: Icons.timer_outlined,
                  title: 'Total Duration',
                  value: controller.formattedWorkoutTime,
                ),
                const SizedBox(height: 16),
                _buildSummaryStat(
                  icon: Icons.local_fire_department_outlined,
                  title: 'Calories Burned',
                  value: '${controller.session.value?.totalTime != null ? (controller.session.value!.totalTime / 60 * 8).round() : 0} kcal',
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 72,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textPrimary,
                      foregroundColor: AppColors.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 10,
                      shadowColor: Colors.black.withValues(alpha: 0.5),
                    ),
                    onPressed: () {
                      Get.back(); // Return to dashboard
                    },
                    child: Text(
                      'BACK TO HOME',
                      style: AppTextStyles.buttonText.copyWith(
                        color: AppColors.background,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
 
  }


  
  Widget _buildSummaryStat({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
            ),
            child: Icon(icon, color: AppColors.primary, size: 28),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            value,
            style: AppTextStyles.h2.copyWith(
              color: AppColors.textPrimary,
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }
}


