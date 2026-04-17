import 'package:fitflow/core/theme/app_colors.dart';
import 'package:fitflow/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

Widget buildPremiumMetricCard({
  required String title,
  required String value,
  required IconData icon,
  required Color accentColor,
  required List<Color> gradientColors,
  bool isWide = false,
}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: gradientColors,
      ),
      border: Border.all(
        color: accentColor.withValues(alpha: 0.3),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: accentColor.withValues(alpha: 0.05),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: accentColor,
                size: 24,
              ),
            ),
            if (!isWide)
              Icon(
                Icons.arrow_outward_rounded,
                color: AppColors.textSecondary.withValues(alpha: 0.5),
                size: 20,
              ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.h1.copyWith(
            fontSize: isWide ? 36 : 28,
            fontWeight: FontWeight.bold,
            letterSpacing: -1,
          ),
        ),
      ],
    ),
  );
}
