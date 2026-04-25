import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../goals_controller.dart';
import '../widgets/step_header.dart';

class InjuryStep extends GetView<GoalsController> {
  const InjuryStep({super.key});

  @override
  Widget build(BuildContext context) {
    final bodyParts = [
      'None',
      'Shoulder',
      'Lower Back',
      'Knee',
      'Wrist',
      'Ankle',
      'Hip',
      'Neck',
      'Elbow',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StepHeader(
            title: 'Any injuries or concerns?',
            subtitle: 'We will modify exercises to keep you safe.',
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: bodyParts.length,
              itemBuilder: (context, index) {
                final part = bodyParts[index];
                return Obx(() {
                  final isSelected = controller.injuries.contains(part);
                  return GestureDetector(
                    onTap: () => controller.toggleInjury(part),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary.withValues(alpha:0.1) : AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.divider,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        part,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: isSelected ? AppColors.primary : AppColors.textPrimary,
                        ),
                      ),
                    ),
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
