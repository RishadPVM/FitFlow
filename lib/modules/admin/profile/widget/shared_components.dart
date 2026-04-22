import 'package:flutter/material.dart';
import 'package:fitflow/core/theme/app_colors.dart';
import 'package:fitflow/core/theme/app_text_styles.dart';

Widget buildProfileCard({required Widget child}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.divider),
    ),
    child: child,
  );
}

Widget buildProfileSection({required String title, required List<Widget> children}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 12),
        child: Text(title, style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.bold)),
      ),
      buildProfileCard(
        child: Column(
          children: children,
        ),
      ),
    ],
  );
}

Widget buildProfileListTile({
  required IconData icon, 
  required String title, 
  String? subtitle, 
  Color? color,
  Widget? trailing,
  VoidCallback? onTap,
}) {
  final iconColor = color ?? AppColors.textPrimary;
  
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title, 
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: iconColor, 
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTextStyles.caption),
                ]
              ],
            ),
          ),
          if (trailing != null) 
            trailing 
          else 
            const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary, size: 20),
        ],
      ),
    ),
  );
}
