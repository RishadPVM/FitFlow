import 'package:fitflow/common/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../goals/goals_flow_page.dart';
import 'workout_controller.dart';
import 'widgets/workout_card.dart';
import 'widgets/week_rhythm_card.dart';
import 'widgets/action_tile.dart';
import 'widgets/section_header.dart';

class WorkoutPage extends GetView<WorkoutController> {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // If not initialized, initialize
    if (!Get.isRegistered<WorkoutController>()) {
      Get.put(WorkoutController());
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return AppLoader();
          }

          if (!controller.onboardingDone.value) {
            return const GoalsFlowPage();
          }

          return RefreshIndicator(
            color: AppColors.primary,
            backgroundColor: AppColors.surface,
            onRefresh: controller.loadLocalData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildQuickActions(),
                  const SizedBox(height: 24),
                  _buildTabs(),
                  const SizedBox(height: 24),
                  _buildMainWorkout(),
                  const SizedBox(height: 32),
                  _buildWeekRhythm(),
                  const SizedBox(height: 32),
                  _buildLockedFeature(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Workout',
          style: AppTextStyles.h1.copyWith(color: AppColors.textPrimary),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.divider),
          ),
          child: IconButton(
            icon: const Icon(Icons.add, color: AppColors.primary),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: ActionTile(
            title: 'Empty Workout',
            icon: Icons.play_arrow_rounded,
            isPrimary: true,
            onTap: () {},
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ActionTile(
            title: 'New Routine',
            icon: Icons.note_add_outlined,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _buildTab('This Week', 0, controller.selectedTab.value),
            _buildTab('Routines', 1, controller.selectedTab.value),
          ],
        ),
      );
    });
  }

  Widget _buildTab(String title, int index, int selectedIndex) {
    final isSelected = index == selectedIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setTab(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.surfaceLight : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainWorkout() {
    if (controller.todayWorkout.value == null) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Today\'s Plan'),
        WorkoutCard(
          workout: controller.todayWorkout.value!,
          onStart: controller.markWorkoutComplete,
        ),
      ],
    );
  }

  Widget _buildWeekRhythm() {
    if (controller.workoutPlan.value == null) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Week Rhythm',
          actionText: 'View All',
          onActionTap: () {},
        ),
        ...controller.workoutPlan.value!.days.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final workoutDay = entry.value;
          return WeekRhythmCard(
            weekNumber: index,
            workoutDay: workoutDay,
          );
        }),
      ],
    );
  }

  Widget _buildLockedFeature() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surfaceLight,
            AppColors.surface,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.star_rounded, color: AppColors.primary, size: 32),
          ),
          const SizedBox(height: 16),
          Text(
            'Unlock Advanced Analytics',
            style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Get detailed insights into your muscle recovery and volume progression.',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: () {},
              child: Text(
                'Upgrade Now',
                style: AppTextStyles.buttonText.copyWith(color: AppColors.background),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
