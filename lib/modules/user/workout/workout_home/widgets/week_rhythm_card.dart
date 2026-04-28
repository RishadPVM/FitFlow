import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../models/workout_day_model.dart';

class WeekRhythmCard extends StatelessWidget {
  final WorkoutPlanModel workout;
  final bool isRestDay;
  final bool isToday;
  final VoidCallback? onEdit;
  final VoidCallback? onPlay;
  final bool isEditTap;
  const WeekRhythmCard({
    super.key,
    required this.workout,
    this.isRestDay = false,
    this.isToday = false,
    this.onEdit,
    this.onPlay,
    this.isEditTap = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isToday
              ? AppColors.primary
              : AppColors.cardShadow.withValues(alpha: 0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: isToday
                ? AppColors.primary.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Week Number Badge
          Container(
            width: 65,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.surfaceLight, AppColors.background],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.divider),
            ),
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       workout.day.toUpperCase().substring(0, 3),
            //       style: AppTextStyles.bodyMedium.copyWith(
            //         color: AppColors.textSecondary,
            //         fontSize: 10,
            //         fontWeight: FontWeight.bold,
            //         letterSpacing: 1,
            //       ),
            //     ),
            //     Text(
            //       workout.day.toUpperCase().substring(0, 3),
            //       style: AppTextStyles.h2.copyWith(
            //         color: AppColors.textPrimary,
            //       ),
            //     ),
            //   ],
            // ),
            child: Center(
              child: Text(
                workout.day.name.toUpperCase().substring(0, 3),
                style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Workout Info
          if (!isRestDay) ...[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workout.title,
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${workout.duration} Min',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.fitness_center_rounded,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${workout.sets} Sets',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.stacked_bar_chart,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${workout.exercises.length} Ex',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ] else ...[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rest Day",
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Active recovery is essential',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Action Button
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isEditTap
                  ? Icons.edit
                  : isRestDay
                  ? Icons.timer_off_rounded
                  : Icons.play_arrow_rounded,
              color: AppColors.primary,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
