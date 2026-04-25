import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../goals_controller.dart';
import '../widgets/step_header.dart';

class ScheduleStep extends GetView<GoalsController> {
  const ScheduleStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StepHeader(
            title: 'Workout Schedule',
            subtitle: 'How much time can you commit?',
          ),
          _buildDaysSelector(),
          const SizedBox(height: 32),
          _buildTimeSlider(),
          const SizedBox(height: 32),
          _buildPreferences(),
        ],
      ),
    );
  }

  Widget _buildDaysSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Days per week', style: AppTextStyles.h3),
        const SizedBox(height: 16),
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(5, (index) {
            final days = index + 2;
            final isSelected = controller.daysPerWeek.value == days;
            return GestureDetector(
              onTap: () => controller.daysPerWeek.value = days,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.primary : AppColors.surface,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.divider,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$days',
                  style: AppTextStyles.h3.copyWith(
                    color: isSelected ? AppColors.background : AppColors.textPrimary,
                  ),
                ),
              ),
            );
          }),
        )),
      ],
    );
  }

  Widget _buildTimeSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Session length', style: AppTextStyles.h3),
            Obx(() => Text(
              '${controller.sessionMinutes.value} min',
              style: AppTextStyles.h3.copyWith(color: AppColors.primary),
            )),
          ],
        ),
        const SizedBox(height: 16),
        Obx(() => Slider(
          value: controller.sessionMinutes.value.toDouble(),
          min: 15,
          max: 90,
          divisions: 5,
          activeColor: AppColors.primary,
          inactiveColor: AppColors.surfaceLight,
          onChanged: (value) => controller.sessionMinutes.value = value.toInt(),
        )),
      ],
    );
  }

  Widget _buildPreferences() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Session preferences', style: AppTextStyles.h3),
        const SizedBox(height: 16),
        _buildToggle('Include Warmup', controller.includeWarmup),
        const SizedBox(height: 12),
        _buildToggle('Include Cooldown', controller.includeCooldown),
        const SizedBox(height: 12),
        _buildToggle('Include Cardio', controller.includeCardio),
      ],
    );
  }

  Widget _buildToggle(String label, RxBool value) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTextStyles.bodyLarge),
            Switch(
              value: value.value,
              activeColor: AppColors.primary,
              onChanged: (v) => value.value = v,
            ),
          ],
        ),
      );
    });
  }
}
