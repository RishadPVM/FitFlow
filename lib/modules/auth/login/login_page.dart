import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_textfield.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(() => Text(
                controller.currentRole.value == 'user'
                    ? AppStrings.signIn
                    : (controller.currentRole.value == 'admin' ? AppStrings.adminLogin : AppStrings.trainerLogin),
                style: AppTextStyles.h1,
              )),
              const SizedBox(height: 8),
              Text(
                AppStrings.welcomeBack,
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 48),
              if (controller.currentRole.value != 'user') ...[
                const AppTextField(
                  hintText: AppStrings.emailHint,
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                const AppTextField(
                  hintText: AppStrings.passwordHint,
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                ),
                const SizedBox(height: 24),
              ],
              Obx(() => AppButton(
                text: controller.currentRole.value == 'user' ? AppStrings.signInWithGoogle : AppStrings.signIn,
                isLoading: controller.isLoading.value,
                onPressed: controller.signIn,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
