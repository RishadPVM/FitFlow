import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class RoleCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isPrimary;
  final bool isSelected;
  final VoidCallback onTap;
  final String ctaText;

  const RoleCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.isPrimary,
    required this.isSelected,
    required this.onTap,
    required this.ctaText,
  });

  @override
  Widget build(BuildContext context) {
    // Primary cards have a subtle glow/shadow and primary color accents when selected
    final cardColor = isSelected
        ? (isPrimary ? AppColors.surfaceLight : AppColors.surfaceLight)
        : AppColors.surface;
        
    final borderColor = isSelected
        ? AppColors.primary
        : AppColors.divider;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        margin: const EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(isPrimary ? 24 : 16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected && isPrimary
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.15),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  )
                ]
              : [
                  const BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.background,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? AppColors.primary : AppColors.textSecondary,
                    size: isPrimary ? 32 : 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: isPrimary ? AppTextStyles.h2 : AppTextStyles.h3,
                      ),
                      if (!isPrimary) ...[
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: AppTextStyles.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: AppColors.primary,
                    size: isPrimary ? 28 : 24,
                  ),
              ],
            ),
            if (isPrimary) ...[
              const SizedBox(height: 16),
              Text(
                description,
                style: AppTextStyles.bodyMedium.copyWith(height: 1.5),
              ),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    ctaText,
                    style: AppTextStyles.buttonText.copyWith(
                      color: isSelected ? AppColors.background : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
