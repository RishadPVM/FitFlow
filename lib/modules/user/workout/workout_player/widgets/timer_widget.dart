import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class TimerWidget extends StatelessWidget {
  final int seconds;
  final String label;

  const TimerWidget({super.key, required this.seconds, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            seconds > 0 ? '$seconds' : '0',
            style: AppTextStyles.h1.copyWith(
              color: AppColors.primary,
              fontSize: 64,
            ),
          ),
        ],
      ),
    );
  }
}
