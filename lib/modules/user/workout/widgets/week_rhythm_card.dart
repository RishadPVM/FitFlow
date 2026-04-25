import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/workout_day_model.dart';

class WeekRhythmCard extends StatelessWidget {
  final int weekNumber;
  final WorkoutDay workoutDay;

  const WeekRhythmCard({
    super.key,
    required this.weekNumber,
    required this.workoutDay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Week Number Badge
          Container(
            width: 56,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'DAY',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  '$weekNumber',
                  style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Workout Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workoutDay.title,
                  style: AppTextStyles.h3.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.timer_outlined, size: 14, color: AppColors.primary),
                    const SizedBox(width: 4),
                    Text(
                      '${workoutDay.duration} Min',
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.fitness_center_rounded, size: 14, color: AppColors.primary),
                    const SizedBox(width: 4),
                    Text(
                      '${workoutDay.exercisesCount} Ex',
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Action Button
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              color: AppColors.primary,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
