import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class WorkoutInfoCard extends StatelessWidget {
  final int reps;
  final int totalSets;
  final int currentSet;

  const WorkoutInfoCard({
    super.key,
    required this.reps,
    required this.totalSets,
    required this.currentSet,
  });

  @override
  Widget build(BuildContext context) {
    int remainingSets = (totalSets - currentSet).clamp(0, totalSets);

    return Row(
      children: [
        Expanded(child: _buildGlassCard('REPS', '$reps', Icons.repeat_rounded)),
        const SizedBox(width: 16),
        Expanded(
          child: _buildGlassCard('SETS', '$totalSets', Icons.layers_rounded),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildGlassCard(
            'LEFT',
            '$remainingSets',
            Icons.hourglass_bottom_rounded,
            isHighlighted: remainingSets == 0,
          ),
        ),
      ],
    );
  }

  Widget _buildGlassCard(
    String label,
    String value,
    IconData icon, {
    bool isHighlighted = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighlighted
              ? AppColors.primary.withValues(alpha: 0.3)
              : AppColors.divider,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: isHighlighted ? AppColors.primary : AppColors.textSecondary,
            size: 24,
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTextStyles.h2.copyWith(
              color: isHighlighted ? AppColors.primary : AppColors.textPrimary,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
