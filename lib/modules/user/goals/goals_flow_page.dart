import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/app_button.dart';
import '../../../core/theme/app_colors.dart';
import 'goals_controller.dart';
import 'steps/equipment_step.dart';
import 'steps/fitness_level_step.dart';
import 'steps/goal_selection_step.dart';
import 'steps/injury_step.dart';
import 'steps/metrics_step.dart';
import 'steps/schedule_step.dart';
import 'steps/summary_step.dart';
import 'widgets/progress_bar.dart';

class GoalsFlowPage extends GetView<GoalsController> {
  const GoalsFlowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.background,
              AppColors.surface.withOpacity(0.5),
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: GoalsProgressBar(),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Obx(() {
                  switch (controller.currentStep.value) {
                    case 0:
                      return const GoalSelectionStep();
                    case 1:
                      return const FitnessLevelStep();
                    case 2:
                      return const MetricsStep();
                    case 3:
                      return const EquipmentStep();
                    case 4:
                      return const ScheduleStep();
                    case 5:
                      return const InjuryStep();
                    case 6:
                      return const SummaryStep();
                    default:
                      return const SizedBox();
                  }
                }),
              ),
              _buildBottomNavigation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Obx(() {
        final isLastStep = controller.currentStep.value == 6;
        return Row(
          children: [
            if (controller.currentStep.value > 0)
              Expanded(
                flex: 1,
                child: AppButton(
                  text: 'Back',
                  onPressed: controller.prevStep,
                  isSecondary: true,
                ),
              ),
            if (controller.currentStep.value > 0) const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: AppButton(
                text: isLastStep ? 'Generate Plan' : 'Next',
                onPressed: isLastStep
                    ? controller.generatePlan
                    : controller.nextStep,
              ),
            ),
          ],
        );
      }),
    );
  }
}
