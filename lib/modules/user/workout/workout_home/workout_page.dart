import 'dart:ui';

import 'package:fitflow/common/widgets/app_loader.dart';
import 'package:fitflow/modules/user/workout/workout_player/workout_player_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routes/app_routes.dart';
import '../../history/widgets/mini_progress_preview.dart';
import '../goals/goals_flow_page.dart';
import 'widgets/section_header.dart';
import 'widgets/workout_card.dart';
import 'widgets/workout_today_card.dart';
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
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.15),
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
                  color: AppColors.primaryBlue.withValues(alpha: 0.1),
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
                      const MiniProgressPreview(),
                      const SizedBox(height: 32),
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
      ],
    );
  }

  Widget _buildMainWorkout() {
    if (controller.todayWorkout.value == null) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TodayWorkoutCard(
          workout: controller.todayWorkout.value!,
          onStart: () => Get.to(() => const WorkoutPlayerPage()),
        ),
      ],
    );
  }

  Widget _buildWeekRhythm() {
    if (controller.todayWorkout.value == null) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Week Rhythm',
          actionText: 'See all',
          onActionTap: () => Get.toNamed(AppRoutes.weekRhythm),
        ),
        ...controller.getThreeDayWorkout().asMap().entries.map((entry) {
          final isToday = entry.value == controller.todayWorkout.value;
          return WorkoutDayCard(
            workout: entry.value,
            isToday: isToday,
            isEditTap: false,
          );
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
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.05),
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
                colors: [
                  AppColors.primary,
                  AppColors.primary.withValues(alpha: 0.7),
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
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
                  color: AppColors.primary.withValues(alpha: 0.2),
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
