import 'package:fitflow/core/theme/app_colors.dart';
import 'package:fitflow/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/admin_profile_controller.dart';
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
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
                child: const Icon(
                  Icons.storefront_outlined,
                  size: 40,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        controller.gymName.value,
                        style: AppTextStyles.h3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Obx(
                      () => Text(
                        '${controller.userName.value} (Owner)',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Obx(
                      () => Text(
                        'Open: ${controller.workingHours.value}',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.edit_outlined,
                  color: AppColors.primaryBlue,
                ),
                onPressed: () {},
                tooltip: 'Edit Profile',
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.phone_outlined,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Obx(
                () =>
                    Text(controller.phone.value, style: AppTextStyles.caption),
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.email_outlined,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Obx(
                () => Expanded(
                  child: Text(
                    controller.userEmail.value,
                    style: AppTextStyles.caption,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Obx(
                () => Expanded(
                  child: Text(
                    controller.address.value,
                    style: AppTextStyles.caption,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'About Gym',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Obx(
            () => Text(controller.aboutGym.value, style: AppTextStyles.caption),
          ),
        ],
      ),
    ),
  );
}
