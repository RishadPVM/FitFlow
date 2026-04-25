import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../goals_controller.dart';
import '../widgets/step_header.dart';
import '../widgets/selection_card.dart';

class FitnessLevelStep extends GetView<GoalsController> {
  const FitnessLevelStep({super.key});

  @override
  Widget build(BuildContext context) {
    final levels = [
      {
        'title': 'Beginner',
        'subtitle': 'New to training or returning after a long break',
        'icon': Icons.battery_1_bar_outlined,
      },
      {
        'title': 'Intermediate',
        'subtitle': 'Consistent training for 6+ months',
        'icon': Icons.battery_4_bar_outlined,
      },
      {
        'title': 'Advanced',
        'subtitle': 'Training consistently for years',
        'icon': Icons.battery_full_outlined,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StepHeader(
            title: 'What is your fitness level?',
            subtitle: 'Be honest so we can match your intensity.',
          ),
          Expanded(
            child: ListView.builder(
              itemCount: levels.length,
              itemBuilder: (context, index) {
                final level = levels[index];
                return Obx(() {
                  final isSelected = controller.fitnessLevel.value == level['title'];
                  return SelectionCard(
                    title: level['title'] as String,
                    subtitle: level['subtitle'] as String,
                    icon: level['icon'] as IconData,
                    isSelected: isSelected,
                    onTap: () {
                      controller.fitnessLevel.value = level['title'] as String;
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
