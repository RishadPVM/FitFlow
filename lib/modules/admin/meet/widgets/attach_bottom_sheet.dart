import 'package:fitflow/core/theme/app_colors.dart';
import 'package:fitflow/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget attachBottomSheet() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.surfaceLight,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// drag handle
        Container(
          height: 4,
          width: 40,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: AppColors.textSecondary,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 16),

        /// options
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildOption(
              icon: Icons.camera_alt,
              label: "Camera",
              onTap: () {
                Get.back();
              },
            ),
            _buildOption(
              icon: Icons.photo,
              label: "Gallery",
              onTap: () {
                Get.back();
              },
            ),
            _buildOption(
              icon: Icons.insert_drive_file,
              label: "Document",
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildOption({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.textSecondary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.textPrimary, size: 24),
        ),
        const SizedBox(height: 8),
        Text(label, style: AppTextStyles.bodyMedium),
      ],
    ),
  );
}
