import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/app_button.dart';
import '../../../../../common/widgets/app_textfield.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../widget/shared_components.dart';
import '../controller/edit_profile_controller.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Edit Profile', style: AppTextStyles.h3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionLabel('Gym Details'),
            AppTextField(
              hintText: 'Gym Name',
              controller: controller.gymNameController,
              prefixIcon: Icons.storefront_outlined,
            ),
            const SizedBox(height: 16),
            AppTextField(
              hintText: 'About Gym',
              controller: controller.aboutGymController,
              prefixIcon: Icons.info_outline_rounded,
            ),
            const SizedBox(height: 32),
            _buildSectionLabel('Owner Details'),
            AppTextField(
              hintText: 'Owner Name',
              controller: controller.userNameController,
              prefixIcon: Icons.person_outline_rounded,
            ),
            const SizedBox(height: 16),
            AppTextField(
              hintText: 'Email Address',
              controller: controller.emailController,
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            AppTextField(
              hintText: 'Phone Number',
              controller: controller.phoneController,
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 32),
            _buildSectionLabel('Location & Hours'),
            AppTextField(
              hintText: 'Address',
              controller: controller.addressController,
              prefixIcon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 16),
            
            // 24/7 Toggle
            Obx(
              () => Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.divider),
                ),
                child: buildProfileListTile(
                  icon: Icons.all_inclusive_rounded,
                  title: 'Open 24/7',
                  color: AppColors.primary,
                  onTap: () => controller.is24Hours.value = !controller.is24Hours.value,
                  trailing: Switch(
                    value: controller.is24Hours.value,
                    onChanged: (val) => controller.is24Hours.value = val,
                    activeThumbColor: AppColors.background,
                    activeTrackColor: AppColors.primary,
                    inactiveThumbColor: AppColors.textSecondary,
                    inactiveTrackColor: AppColors.surfaceLight,
                  ),
                ),
              ),
            ),
            
            // Time Pickers
            Obx(() {
              if (controller.is24Hours.value) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.pickTime(context, true),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Open Time', style: AppTextStyles.caption),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.access_time_rounded, size: 16, color: AppColors.primaryBlue),
                                  const SizedBox(width: 8),
                                  Text(
                                    controller.formatTimeOfDay(controller.openTime.value),
                                    style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.pickTime(context, false),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Close Time', style: AppTextStyles.caption),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.access_time_rounded, size: 16, color: AppColors.primaryBlue),
                                  const SizedBox(width: 8),
                                  Text(
                                    controller.formatTimeOfDay(controller.closeTime.value),
                                    style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 48),
            AppButton(
              text: 'Save Changes',
              onPressed: controller.saveProfile,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.primaryBlue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
