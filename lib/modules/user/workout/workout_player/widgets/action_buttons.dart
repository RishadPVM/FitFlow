import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class ActionButtons extends StatelessWidget {
  final bool isWorkoutActive;
  final bool isResting;
  final VoidCallback onStart;
  final VoidCallback onCompleteSet;
  final VoidCallback onSkipRest;

  const ActionButtons({
    super.key,
    required this.isWorkoutActive,
    required this.isResting,
    required this.onStart,
    required this.onCompleteSet,
    required this.onSkipRest,
  });

  @override
  Widget build(BuildContext context) {
    if (!isWorkoutActive) {
      return _buildMainButton(
        label: 'START WORKOUT',
        icon: Icons.play_arrow_rounded,
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryBlue],
        ),
        shadowColor: AppColors.primary,
        onTap: onStart,
      );
    }

    if (isResting) {
      return Row(
        children: [
          Expanded(
            child: _buildOutlineButton(label: 'SKIP REST', onTap: onSkipRest),
          ),
        ],
      );
    }

    return _buildMainButton(
      label: 'COMPLETE SET',
      icon: Icons.check_circle_outline_rounded,
      gradient: LinearGradient(
        // colors: [AppColors.primaryBlue, AppColors.primary],
        colors: [
          AppColors.primary,
          AppColors.primary.withValues(alpha: 0.8),
          // AppColors.primary.withValues(alpha: 0.6),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shadowColor: AppColors.primary,
      onTap: onCompleteSet,
    );
  }

  Widget _buildMainButton({
    required String label,
    required IconData icon,
    required LinearGradient gradient,
    required Color shadowColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 72,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.background, size: 32),
            const SizedBox(width: 12),
            Text(
              label,
              style: AppTextStyles.buttonText.copyWith(
                color: AppColors.background,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutlineButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 72,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.surfaceLight.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.divider),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTextStyles.buttonText.copyWith(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
