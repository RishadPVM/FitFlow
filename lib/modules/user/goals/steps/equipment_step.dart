import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../goals_controller.dart';
import '../widgets/step_header.dart';
import '../widgets/selection_card.dart';

class EquipmentStep extends GetView<GoalsController> {
  const EquipmentStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StepHeader(
            title: 'Where do you train?',
            subtitle: 'Select your training environment and available equipment.',
          ),
          _buildLocationSelection(),
          const SizedBox(height: 32),
          Obx(() {
            if (controller.location.value.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Equipment',
                    style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 16),
                  if (controller.location.value == 'Home')
                    SelectionCard(
                      title: 'Bodyweight Only',
                      subtitle: 'No equipment needed',
                      isSelected: controller.equipment.contains('Bodyweight'),
                      onTap: () => controller.toggleEquipment('Bodyweight'),
                    ),
                  ...['Dumbbells', 'Barbell', 'Machines', 'Kettlebell'].map((eq) => 
                    SelectionCard(
                      title: eq,
                      isSelected: controller.equipment.contains(eq),
                      onTap: () => controller.toggleEquipment(eq),
                    )
                  ),
                ],
              );
            }
            return const SizedBox();
          }),
        ],
      ),
    );
  }

  Widget _buildLocationSelection() {
    return Obx(() {
      return Row(
        children: [
          Expanded(
            child: SelectionCard(
              title: 'At Home',
              icon: Icons.home_outlined,
              isSelected: controller.location.value == 'Home',
              onTap: () => controller.location.value = 'Home',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SelectionCard(
              title: 'At Gym',
              icon: Icons.fitness_center_outlined,
              isSelected: controller.location.value == 'Gym',
              onTap: () => controller.location.value = 'Gym',
            ),
          ),
        ],
      );
    });
  }
}
