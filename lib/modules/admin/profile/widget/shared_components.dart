import 'package:flutter/material.dart';
import 'package:fitflow/core/theme/app_colors.dart';
import 'package:fitflow/core/theme/app_text_styles.dart';

Widget buildProfileCard({required Widget child}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.surfaceLight,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.02),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: child,
  );
}

Widget buildProfileSection({required String title, required List<Widget> children}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 8),
        child: Text(title, style: AppTextStyles.h3),
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
  return ListTile(
    leading: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: (color ?? AppColors.textPrimary).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color ?? AppColors.textPrimary, size: 20),
    ),
    title: Text(title, style: AppTextStyles.bodyMedium.copyWith(color: color ?? AppColors.textPrimary, fontWeight: FontWeight.bold)),
    subtitle: subtitle != null ? Text(subtitle, style: AppTextStyles.caption) : null,
    trailing: trailing ?? const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
    onTap: onTap,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
  );
}
