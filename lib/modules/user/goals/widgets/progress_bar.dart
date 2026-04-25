import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../goals_controller.dart';

class GoalsProgressBar extends GetView<GoalsController> {
  const GoalsProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final totalSteps = 7;
      final currentProgress = (controller.currentStep.value + 1) / totalSteps;
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step ${controller.currentStep.value + 1} of $totalSteps',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${(currentProgress * 100).toInt()}%',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: currentProgress,
              backgroundColor: AppColors.surfaceLight,
              color: AppColors.primary,
              minHeight: 8,
            ),
          ),
        ],
      );
    });
  }
}
