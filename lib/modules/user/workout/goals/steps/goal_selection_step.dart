import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../goals_controller.dart';
import '../widgets/step_header.dart';
import '../widgets/selection_card.dart';

class GoalSelectionStep extends GetView<GoalsController> {
  const GoalSelectionStep({super.key});

  @override
  Widget build(BuildContext context) {
    final goals = [
      {
        'title': 'Lose Weight',
        'subtitle': 'Burn fat and lean out',
        'icon': Icons.monitor_weight_outlined,
      },
      {
        'title': 'Build Muscle',
        'subtitle': 'Increase mass and strength',
        'icon': Icons.fitness_center_outlined,
      },
      {
        'title': 'Gentle Recovery',
        'subtitle': 'Rehab and light movement',
        'icon': Icons.healing_outlined,
      },
      {
        'title': 'General Fitness',
        'subtitle': 'Stay healthy and active',
        'icon': Icons.favorite_border_outlined,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StepHeader(
            title: 'What is your main goal?',
            subtitle: 'This helps us tailor your perfect program.',
          ),
          Expanded(
            child: ListView.builder(
              itemCount: goals.length,
              itemBuilder: (context, index) {
                final goal = goals[index];
                return Obx(() {
                  final isSelected = controller.goalType.value == goal['title'];
                  return SelectionCard(
                    title: goal['title'] as String,
                    subtitle: goal['subtitle'] as String,
                    icon: goal['icon'] as IconData,
                    isSelected: isSelected,
                    onTap: () {
                      controller.goalType.value = goal['title'] as String;
                    },
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
