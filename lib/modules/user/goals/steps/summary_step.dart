import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../goals_controller.dart';
import '../widgets/step_header.dart';

class SummaryStep extends GetView<GoalsController> {
  const SummaryStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StepHeader(
            title: 'Your Profile is Ready',
            subtitle: 'Review your details before generating the plan.',
          ),
          _buildSummaryCard(
            title: 'Goal & Level',
            icon: Icons.flag_outlined,
            content: '${controller.goalType.value}\n${controller.fitnessLevel.value} Level',
          ),
          const SizedBox(height: 16),
          _buildSummaryCard(
            title: 'Personal Metrics',
            icon: Icons.person_outline,
            content: '${controller.gender.value}, ${controller.age.value} yrs\n${controller.height.value}, ${controller.weight.value}',
          ),
          const SizedBox(height: 16),
          _buildSummaryCard(
            title: 'Training & Equipment',
            icon: Icons.fitness_center_outlined,
            content: 'At ${controller.location.value}\nEq: ${controller.equipment.isEmpty ? 'None' : controller.equipment.join(', ')}',
          ),
          const SizedBox(height: 16),
          _buildSummaryCard(
            title: 'Schedule',
            icon: Icons.calendar_today_outlined,
            content: '${controller.daysPerWeek.value} days/wk, ${controller.sessionMinutes.value} min/session',
          ),
          const SizedBox(height: 16),
          _buildSummaryCard(
            title: 'Health Concerns',
            icon: Icons.health_and_safety_outlined,
            content: controller.injuries.join(', '),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required IconData icon,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.h3),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: AppColors.textSecondary, size: 20),
            onPressed: () {
              // Optionally handle edits here, or simply direct user to use the Back button
              Get.snackbar('Edit', 'Use the Back button to change your answers.');
            },
          ),
        ],
      ),
    );
  }
}
