import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/app_textfield.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../goals_controller.dart';
import '../widgets/step_header.dart';

class MetricsStep extends GetView<GoalsController> {
  const MetricsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StepHeader(
            title: 'Personal Metrics',
            subtitle: 'Used to calculate calories and workloads.',
          ),
          _buildGenderToggle(),
          const SizedBox(height: 24),
          _buildMetricInput('Age', 'years', TextInputType.number, (v) => controller.age.value = v),
          const SizedBox(height: 24),
          _buildMetricInput('Weight', 'kg / lbs', TextInputType.number, (v) => controller.weight.value = v),
          const SizedBox(height: 24),
          _buildMetricInput('Height', 'cm / ft,in', TextInputType.text, (v) => controller.height.value = v),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildGenderToggle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildGenderOption('Male', Icons.male)),
            const SizedBox(width: 16),
            Expanded(child: _buildGenderOption('Female', Icons.female)),
            const SizedBox(width: 16),
            Expanded(child: _buildGenderOption('Other', Icons.transgender)),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderOption(String title, IconData icon) {
    return Obx(() {
      final isSelected = controller.gender.value == title;
      return GestureDetector(
        onTap: () => controller.gender.value = title,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary.withValues(alpha:0.1) : AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.divider,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? AppColors.primary : AppColors.textSecondary),
              const SizedBox(height: 8),
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildMetricInput(String label, String hint, TextInputType type, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 8),
        AppTextField(
          hintText: hint,
          keyboardType: type,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
