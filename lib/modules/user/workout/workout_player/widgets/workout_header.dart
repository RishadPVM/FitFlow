import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class WorkoutHeader extends StatelessWidget {
  final String workoutName;
  final int currentSet;
  final int totalSets;
  final double progress;

  const WorkoutHeader({
    super.key,
    required this.workoutName,
    required this.currentSet,
    required this.totalSets,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                workoutName,
                style: AppTextStyles.h1.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 36, // Larger and bolder
                  height: 1.1,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.2),
                    AppColors.primary.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
              ),
              child: Text(
                'SET $currentSet / $totalSets',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Premium Progress Bar
        Container(
          height: 8,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(4),
          ),
          child: AnimatedFractionallySizedBox(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            alignment: Alignment.centerLeft,
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryBlue, AppColors.primary],
                ),
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
