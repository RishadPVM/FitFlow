import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ControlButtons extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onSkip;
  final VoidCallback onComplete;
  final bool isResting;

  const ControlButtons({
    super.key,
    required this.onPrevious,
    required this.onSkip,
    required this.onComplete,
    this.isResting = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSecondaryButton(
          icon: Icons.skip_previous_rounded,
          onTap: onPrevious,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildPrimaryButton(),
        ),
        const SizedBox(width: 16),
        _buildSecondaryButton(
          icon: Icons.skip_next_rounded,
          onTap: onSkip,
        ),
      ],
    );
  }

  Widget _buildPrimaryButton() {
    return GestureDetector(
      onTap: isResting ? onSkip : onComplete,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: isResting ? AppColors.surfaceLight : AppColors.primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isResting
              ? null
              : [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha:0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ],
        ),
        alignment: Alignment.center,
        child: Text(
          isResting ? 'Skip Rest' : 'Complete Set',
          style: AppTextStyles.buttonText.copyWith(
            color: isResting ? AppColors.textPrimary : AppColors.background,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.divider),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: AppColors.textPrimary, size: 28),
      ),
    );
  }
}
