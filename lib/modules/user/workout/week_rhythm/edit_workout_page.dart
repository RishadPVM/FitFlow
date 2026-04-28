import 'package:fitflow/common/widgets/app_button.dart';
import 'package:fitflow/modules/user/workout/workout_home/widgets/workout_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/app_textfield.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'controller/edit_workout_controller.dart';

class EditWorkoutPage extends GetView<EditWorkoutController> {
  const EditWorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHighlightCard(),
                    const SizedBox(height: 32),
                    _buildFormSection(),
                  ],
                ),
              ),
            ),
            _buildBottomAction(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.textPrimary,
              size: 20,
            ),
            onPressed: () => Get.back(),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Edit Workout', style: AppTextStyles.h3),
                const SizedBox(height: 2),
                Text(
                  'Customize your session',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightCard() {
    return WorkoutDayCard(
      workout: controller.originalWorkout,
      isToday: true,
      isEditTap: false,
      removeActionButton: true,
    );
  }

  Widget _buildFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Workout Details', style: AppTextStyles.h3),
            Row(
              children: [
                Text(
                  'Rest Day',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 8),
                Obx(
                  () => Switch(
                    value: controller.isRestDay.value,
                    onChanged: controller.toggleRestDay,
                    activeThumbColor: AppColors.primary,
                    activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
                    inactiveThumbColor: AppColors.textSecondary,
                    inactiveTrackColor: AppColors.surfaceLight,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Obx(() {
          if (controller.isRestDay.value) {
            return _buildRestDayIllustration();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextFieldWithLabel(
                'Workout Title',
                AppTextField(
                  hintText: 'e.g. Push A',
                  controller: controller.titleController,
                  prefixIcon: Icons.fitness_center_rounded,
                ),
              ),
              const SizedBox(height: 32),
              Text('Exercises', style: AppTextStyles.h3),
              const SizedBox(height: 16),
              _buildExercisesList(),
              const SizedBox(height: 16),
              AppButton(
                text: '+ Add Exercise',
                onPressed: () {
                  controller.addExercise();
                },
                isSecondary: true,
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildRestDayIllustration() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Icon(
            Icons.battery_charging_full_rounded,
            size: 64,
            color: AppColors.primaryBlue,
          ),
          const SizedBox(height: 16),
          Text(
            'Recovery is Key',
            style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 8),
          Text(
            'Take this time to rest and let your muscles rebuild for your next session.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldWithLabel(String label, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildExercisesList() {
    return Obx(
      () => Theme(
        data: Theme.of(Get.context!).copyWith(
          canvasColor:
              Colors.transparent, // Prevents white background during drag
        ),
        child: ReorderableListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.exercises.length,
          onReorder: controller.reorderExercises,
          proxyDecorator:
              (Widget child, int index, Animation<double> animation) {
                return Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryBlue.withValues(alpha: 0.2),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: child,
                  ),
                );
              },
          itemBuilder: (context, index) {
            // Using the TextEditingController's hashCode as a key
            return _buildExerciseItem(
              index,
              key: ValueKey(controller.exercises[index].hashCode),
            );
          },
        ),
      ),
    );
  }

  Widget _buildExerciseItem(int index, {required Key key}) {
    return Container(
      key: key,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: Icon(
              Icons.drag_indicator_rounded,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ),
          Expanded(
            child: Focus(
              onFocusChange: (hasFocus) {
                // Focus glow handled implicitly by theme, but we can wrap in a builder if needed
              },
              child: TextField(
                controller: controller.exercises[index],
                style: AppTextStyles.bodyLarge,
                decoration: InputDecoration(
                  hintText: 'Exercise name',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  hintStyle: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.close_rounded,
              color: AppColors.error,
              size: 20,
            ),
            onPressed: () => controller.removeExercise(index),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: AppColors.background,
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: AppButton(
        text: 'Save Changes',

        onPressed: () {
          controller.saveChanges();
        },
      ),
    );
  }
}
