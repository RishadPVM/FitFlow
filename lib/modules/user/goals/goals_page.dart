import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_textfield.dart';
import 'goals_controller.dart';

class GoalsPage extends GetView<GoalsController> {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Goals', style: AppTextStyles.h2),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('What do you want to achieve?', style: AppTextStyles.h3),
            const SizedBox(height: 16),
            Obx(() => Row(
              children: [
                Expanded(child: _buildGoalOption('Weight Loss')),
                const SizedBox(width: 16),
                Expanded(child: _buildGoalOption('Muscle Gain')),
              ],
            )),
            const SizedBox(height: 32),
            
            Text('Current Stats', style: AppTextStyles.h3),
            const SizedBox(height: 16),
            const AppTextField(
              hintText: 'Current Weight (kg)',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.monitor_weight_rounded,
            ),
            const SizedBox(height: 16),
            const AppTextField(
              hintText: 'Target Weight (kg)',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.flag_rounded,
            ),
            
            const SizedBox(height: 48),
            AppButton(
              text: 'Save Goals',
              onPressed: () {},
            ),
            
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline_rounded, color: AppColors.primaryBlue),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Join a gym to get a personalized plan to reach your goals faster.',
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryBlue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalOption(String title) {
    bool isSelected = controller.selectedGoal.value == title;
    return GestureDetector(
      onTap: () => controller.setGoal(title),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : AppColors.divider,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.bodyLarge.copyWith(
              color: isSelected ? Colors.white : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
