import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class ExercisePreview extends StatelessWidget {
  final String imageUrl;
  final String muscle;

  const ExercisePreview({
    super.key,
    required this.imageUrl,
    required this.muscle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.surface,
              child: Icon(
                Icons.fitness_center_rounded,
                size: 100,
                color: AppColors.textSecondary.withValues(alpha: 0.3),
              ),
            );
          },
        ),
        // Gradient overlay to blend into the background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.background.withValues(alpha: 0.4),
                Colors.transparent,
                AppColors.background,
              ],
              stops: const [0.0, 0.4, 1.0],
            ),
          ),
        ),
        // Muscle Highlight floating at the top-right
        Positioned(
          top: MediaQuery.of(context).padding.top + 16,
          right: 24,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primaryBlue.withValues(alpha: 0.3),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  muscle.toUpperCase(),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
