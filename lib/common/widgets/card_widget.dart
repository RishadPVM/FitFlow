import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color color;
  final bool isLocked;

  const CardWidget({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    required this.color,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: AppTextStyles.bodyMedium),
                    if (isLocked)
                      const Icon(Icons.lock_rounded, color: AppColors.textSecondary, size: 16),
                  ],
                ),
                const SizedBox(height: 4),
                Text(content, style: AppTextStyles.h3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
