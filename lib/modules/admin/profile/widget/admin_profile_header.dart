import 'package:fitflow/core/theme/app_colors.dart';
import 'package:fitflow/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/admin_profile_controller.dart';
import '../edit_profile/edit_profile_page.dart';
import 'shared_components.dart';

Widget buildAdminProfileHeader(AdminProfileController controller) {
  return buildProfileCard(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryBlue.withValues(alpha: 0.5),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withValues(alpha: 0.15),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.storefront_outlined,
                    size: 36,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        controller.gymName.value,
                        style: AppTextStyles.h2.copyWith(fontSize: 22),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildBadge(
                          icon: Icons.shield_rounded,
                          text: 'Owner',
                          color: AppColors.primaryBlue,
                        ),
                        Obx(
                          () => _buildBadge(
                            icon: Icons.access_time_rounded,
                            text: controller.workingHours.value,
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
                  padding: const EdgeInsets.all(12),
                ),
                icon: const Icon(
                  Icons.edit_rounded,
                  color: AppColors.primaryBlue,
                  size: 20,
                ),
                onPressed: () => Get.to(() => const EditProfilePage()),
                tooltip: 'Edit Profile',
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: 20),
          _buildContactRow(Icons.phone_outlined, controller.phone),
          const SizedBox(height: 12),
          _buildContactRow(Icons.email_outlined, controller.userEmail),
          const SizedBox(height: 12),
          _buildContactRow(Icons.location_on_outlined, controller.address),
          const SizedBox(height: 24),
          Text(
            'About Gym',
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Obx(
            () => Text(
              controller.aboutGym.value,
              style: AppTextStyles.bodyMedium.copyWith(height: 1.5),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildBadge({
  required IconData icon,
  required String text,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(100),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTextStyles.caption.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _buildContactRow(IconData icon, RxString rxValue) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, size: 18, color: AppColors.textSecondary),
      const SizedBox(width: 12),
      Expanded(
        child: Obx(() => Text(rxValue.value, style: AppTextStyles.bodyMedium)),
      ),
    ],
  );
}
