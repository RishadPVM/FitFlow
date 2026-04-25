import 'dart:ui';

import 'package:fitflow/common/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../goals/goals_flow_page.dart';
import 'widgets/action_tile.dart';
import 'widgets/section_header.dart';
import 'widgets/week_rhythm_card.dart';
import 'widgets/workout_card.dart';
import 'workout_controller.dart';

class WorkoutPage extends GetView<WorkoutController> {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<WorkoutController>()) {
      Get.put(WorkoutController());
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const AppLoader();
        }

        if (!controller.onboardingDone.value) {
          return const GoalsFlowPage();
        }

        return Stack(
          children: [
            // Premium background glow effects
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(0.15),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: const SizedBox(),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: -100,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryBlue.withOpacity(0.1),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: const SizedBox(),
                ),
              ),
            ),

            // Main Content
            SafeArea(
              child: RefreshIndicator(
                color: AppColors.primary,
                backgroundColor: AppColors.surface,
                onRefresh: controller.loadLocalData,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 32),
                      _buildMainWorkout(),
                      const SizedBox(height: 32),
                      _buildQuickActions(),
                      const SizedBox(height: 32),
                      _buildTabs(),
                      const SizedBox(height: 24),
                      _buildWeekRhythm(),
                      const SizedBox(height: 40),
                      _buildLockedFeature(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ready to train?',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Your Dashboard',
              style: AppTextStyles.h1.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.divider),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(
              Icons.add_rounded,
              color: AppColors.primary,
              size: 24,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildMainWorkout() {
    if (controller.todayWorkout.value == null) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WorkoutCard(
          workout: controller.todayWorkout.value!,
          onStart: controller.markWorkoutComplete,
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
            icon: Icons.dashboard_customize_outlined,
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
          color: AppColors.surface.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            _buildTab('This Week', 0, controller.selectedTab.value),
            _buildTab('My Routines', 1, controller.selectedTab.value),
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.surfaceLight : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeekRhythm() {
    if (controller.workoutPlan.value == null) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Week Rhythm',
          actionText: 'See all',
          onActionTap: () {},
        ),
        ...controller.workoutPlan.value!.days.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final workoutDay = entry.value;
          return WeekRhythmCard(weekNumber: index, workoutDay: workoutDay);
        }),
      ],
    );
  }

  Widget _buildLockedFeature() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E1E1E), // AppColors.surface
            Color(0xFF2A2A2A), // AppColors.surfaceLight
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(
              Icons.auto_graph_rounded,
              color: AppColors.background,
              size: 32,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Unlock Advanced Analytics',
            style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Get detailed insights into your muscle recovery, volume progression, and PR predictions.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                onPressed: () {},
                child: Text(
                  'Upgrade to Pro',
                  style: AppTextStyles.buttonText.copyWith(
                    color: AppColors.background,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
