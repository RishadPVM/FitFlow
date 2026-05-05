import 'package:fitflow/core/constants/app_image.dart';
import 'package:fitflow/core/theme/app_colors.dart';
import 'package:fitflow/modules/role_selection/role_selection_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_textfield.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_text_styles.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  String _getIllustrationPath(String role) {
    if (role == UserRole.user.name) return AppImages.loginUser;
    if (role == UserRole.admin.name) return AppImages.loginGym;
    return AppImages.loginTrainer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Obx(
              () => Image.asset(
                _getIllustrationPath(controller.currentRole.value),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Dark Gradient Overlay for readability (matching role_selection)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.background.withValues(alpha: 0.5),
                    AppColors.background.withValues(alpha: 0.6),
                    AppColors.background,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
               
                const SizedBox(height: 16),

                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          controller.currentRole.value == UserRole.user.name
                              ? AppStrings.signIn
                              : (controller.currentRole.value ==
                                        UserRole.admin.name
                                    ? AppStrings.adminLogin
                                    : AppStrings.trainerLogin),
                          style: AppTextStyles.h1.copyWith(
                            color: AppColors.primary,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppStrings.welcomeBack,
                        style: AppTextStyles.h2.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Please enter your details to continue",
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Form Area
                Expanded(
                  flex: controller.currentRole.value == UserRole.user.name
                      ? 2
                      : 8,
                  child: SingleChildScrollView(
                    clipBehavior: Clip.none,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Dynamic Login Section based on Role
                        Obx(() {
                          if (controller.currentRole.value ==
                              UserRole.user.name) {
                            // Premium User Login Section
                            return Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.03),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.08),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.1,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.bolt_rounded,
                                      color: AppColors.primary,
                                      size: 40,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    "Your Fitness Journey",
                                    style: AppTextStyles.h2.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Sync workouts, track progress, and connect seamlessly with your gym.",
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 32),

                                  // Primary Google Sign In (Using AppButton)
                                  AppButton(
                                    text: "Continue with Google",
                                    isLoading: controller.isLoading.value,
                                    onPressed: controller.signIn,
                                  ),
                                  const SizedBox(height: 16),

                                  // Secondary Apple Sign In
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: () {}, // Dummy action for UI
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        side: BorderSide(
                                          color: Colors.white.withValues(
                                            alpha: 0.2,
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.apple,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            "Continue with Apple",
                                            style: AppTextStyles.bodyLarge
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            // Professional (Admin/Trainer) Login Section
                            final isTrainer =
                                controller.currentRole.value ==
                                UserRole.trainer.name;

                            return Container(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  // Icon and text context
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.1,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      isTrainer
                                          ? Icons.timer_outlined
                                          : Icons.business_center_outlined,
                                      color: AppColors.primary,
                                      size: 32,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    isTrainer
                                        ? "Trainer Portal"
                                        : "Gym Management",
                                    style: AppTextStyles.h2.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    isTrainer
                                        ? "Access your clients, schedules, and smart programming tools."
                                        : "Control operations, insights, and member lifecycle securely.",
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 32),

                                  // Inputs
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
                                  const SizedBox(height: 16),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Forgot Password?",
                                        style: AppTextStyles.bodyMedium
                                            .copyWith(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),

                                  // Sign in Button
                                  AppButton(
                                    text: "Sign In Securely",
                                    isLoading: controller.isLoading.value,
                                    onPressed: controller.signIn,
                                  ),
                                ],
                              ),
                            );
                          }
                        }),

                        const SizedBox(height: 32),

                        // Bottom link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Sign Up",
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
