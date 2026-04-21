import 'package:fitflow/core/theme/app_colors.dart';
import 'package:fitflow/core/theme/app_text_styles.dart';
import 'package:fitflow/models/trainer_model.dart';
import 'package:fitflow/modules/admin/users/trainers/controller/trainers_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showEditTrainerUI(
  BuildContext context,
  TrainerModel trainer,
  AdminTrainerController controller,
) {
  String selectedPlan = trainer.specialization;
  String selectedStatus = trainer.status;

  Widget formContent = Container(
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Edit Trainer', style: AppTextStyles.h3),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Specialization', style: AppTextStyles.caption),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: selectedPlan,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: AppColors.surfaceLight,
                    ),
                    dropdownColor: AppColors.surfaceLight,
                    items: controller.trainerSpecialization.map((plan) {
                      return DropdownMenuItem(value: plan, child: Text(plan));
                    }).toList(),
                    onChanged: (val) => selectedPlan = val!,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Status', style: AppTextStyles.caption),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: selectedStatus,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: AppColors.surfaceLight,
                    ),
                    dropdownColor: AppColors.surfaceLight,
                    items: controller.trainerStatus.map((status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                    onChanged: (val) => selectedStatus = val!,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              controller.updateTrainer(
                trainer.copyWith(
                  specialization: selectedPlan,
                  status: selectedStatus,
                ),
              );
            },
            child: Text(
              'Update Trainer',
              style: AppTextStyles.buttonText.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );

  Get.bottomSheet(
    Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(child: formContent),
    ),
    isScrollControlled: true,
  );
}
