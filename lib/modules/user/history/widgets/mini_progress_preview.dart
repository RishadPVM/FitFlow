import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../history_controller.dart';
import '../history_page.dart';

class MiniProgressPreview extends StatelessWidget {
  const MiniProgressPreview({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<HistoryController>()) {
      Get.put(HistoryController());
    }
    
    final controller = Get.find<HistoryController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary),
            ),
            TextButton(
              onPressed: () => Get.to(() => const HistoryPage()),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'See All',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => Get.to(() => const HistoryPage()),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.divider.withValues(alpha:0.5)),
            ),
            child: Obx(() {
              final lastWorkout = controller.historyList.isNotEmpty 
                  ? controller.historyList.last 
                  : null;

              return Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.primary.withValues(alpha:0.7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha:0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.local_fire_department_rounded, color: AppColors.background, size: 20),
                        Text(
                          '${controller.streak.value}',
                          style: AppTextStyles.h3.copyWith(color: AppColors.background, height: 1.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Streak',
                          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 4),
                        if (lastWorkout != null) ...[
                          Text(
                            'Last: ${lastWorkout.name}',
                            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${lastWorkout.calories} kcal • ${lastWorkout.duration ~/ 60}m',
                            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                          ),
                        ] else ...[
                          Text(
                            'No workouts yet',
                            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
