import 'dart:ui';

import 'package:fitflow/modules/role_selection/role_selection_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

Widget primaryRoleCard(UserRole role) {
  final controller = Get.find<RoleSelectionController>();
  return Obx(() {
    final isSelected = controller.highlightedRole.value == role.name;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: isSelected ? 0.9 : 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? AppColors.primary
              : Colors.white.withValues(alpha: 0.1),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: InkWell(
            onTap: () => controller.selectRole(role.name),
            borderRadius: BorderRadius.circular(24),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Icon
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.2)
                          : Colors.white.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person_rounded,
                      color: isSelected ? AppColors.primary : Colors.white70,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Text details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "I'm a user",
                          style: AppTextStyles.h2.copyWith(
                            color: isSelected
                                ? AppColors.textPrimary
                                : Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "i am ready to be fit",
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  });
}

Widget secondaryRoleCard(UserRole role) {
  final controller = Get.find<RoleSelectionController>();
  return Obx(() {
    final isSelected = controller.highlightedRole.value == role.name;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: isSelected ? 0.9 : 0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : Colors.white.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: InkWell(
          onTap: () => controller.selectRole(role.name),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: Text(
              role.name,
              textAlign: TextAlign.center,
              style: AppTextStyles.h3.copyWith(
                color: isSelected ? AppColors.textPrimary : Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  });
}
