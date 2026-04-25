import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../history_controller.dart';

class ProgressHeader extends GetView<HistoryController> {
  const ProgressHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeroCard(),
        const SizedBox(height: 16),
        _buildStatsGrid(),
      ],
    );
  }

  Widget _buildHeroCard() {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.primary.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.local_fire_department_rounded, color: AppColors.background, size: 28),
                const SizedBox(width: 8),
                Text(
                  'Current Streak',
                  style: AppTextStyles.bodyLarge.copyWith(color: AppColors.background.withOpacity(0.9)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '${controller.streak.value}',
              style: AppTextStyles.h1.copyWith(
                color: AppColors.background,
                fontSize: 64,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Keep it going! 🔥',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.background.withOpacity(0.9)),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildStatsGrid() {
    return Obx(() {
      final avgDuration = controller.totalWorkouts.value > 0 
          ? (controller.totalDuration.value ~/ controller.totalWorkouts.value) 
          : 0;

      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.25,
        children: [
          _buildGridItem(
            title: 'Total Workouts',
            value: '${controller.totalWorkouts.value}',
            icon: Icons.fitness_center_rounded,
          ),
          _buildGridItem(
            title: 'Total Time',
            value: '${controller.totalDuration.value ~/ 60}m',
            icon: Icons.timer_outlined,
          ),
          _buildGridItem(
            title: 'Calories Burned',
            value: '${controller.totalCalories.value}',
            icon: Icons.electric_bolt_rounded,
          ),
          _buildGridItem(
            title: 'Avg Duration',
            value: '${avgDuration ~/ 60}m ${avgDuration % 60}s',
            icon: Icons.analytics_outlined,
          ),
        ],
      );
    });
  }

  Widget _buildGridItem({required String title, required String value, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const Spacer(),
          Text(
            value,
            style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary, fontSize: 22),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
