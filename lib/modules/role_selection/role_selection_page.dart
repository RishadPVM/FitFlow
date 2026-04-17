import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_text_styles.dart';
import '../../common/widgets/app_button.dart';
import 'role_selection_controller.dart';

class RoleSelectionPage extends GetView<RoleSelectionController> {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Text(
                AppStrings.appName,
                style: AppTextStyles.h1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.selectRole,
                style: AppTextStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              AppButton(
                text: AppStrings.roleUser,
                onPressed: () => controller.selectRole('user'),
              ),
              const SizedBox(height: 16),
              AppButton(
                text: AppStrings.roleAdmin,
                onPressed: () => controller.selectRole('admin'),
                isSecondary: true,
              ),
              const SizedBox(height: 16),
              AppButton(
                text: AppStrings.roleTrainer,
                onPressed: () => controller.selectRole('trainer'),
                isSecondary: true,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
