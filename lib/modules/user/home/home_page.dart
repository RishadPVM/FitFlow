import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../common/widgets/app_loader.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/card_widget.dart';
import 'home_controller.dart';

class UserHomePage extends GetView<UserHomeController> {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName, style: AppTextStyles.h2),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: AppLoader());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome, Alex!',
                style: AppTextStyles.h2,
              ),
              const SizedBox(height: 8),
              Text(
                'Ready to start your fitness journey?',
                style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              
              // Call to Action
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryBlue.withValues(alpha: 0.8),
                      AppColors.primaryBlue,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      'Join a Gym Today',
                      style: AppTextStyles.h2.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Get access to personalized workouts, diet plans, and expert trainers.',
                      style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    AppButton(
                      text: 'Find Gyms Near Me',
                      onPressed: () {
                      },
                      // backgroundColor: Colors.white,
                      // textColor: AppColors.primaryBlue,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              Text('Locked Features', style: AppTextStyles.h3),
              const SizedBox(height: 16),
              
              const CardWidget(
                title: AppStrings.todayWorkout,
                content: 'Unlock to view plans',
                icon: Icons.fitness_center_rounded,
                color: AppColors.textSecondary,
                isLocked: true,
              ),
              const SizedBox(height: 16),
              const CardWidget(
                title: AppStrings.dietPlan,
                content: 'Unlock to view nutrition',
                icon: Icons.restaurant_rounded,
                color: AppColors.textSecondary,
                isLocked: true,
              ),
            ],
          ),
        );
      }),
    );
  }
}
