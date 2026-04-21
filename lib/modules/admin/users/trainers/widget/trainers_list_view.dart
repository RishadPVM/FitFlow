import 'package:fitflow/core/theme/app_colors.dart';
import 'package:fitflow/core/theme/app_text_styles.dart';
import 'package:fitflow/model/trainer_model.dart';
import 'package:fitflow/modules/admin/users/trainers/controller/trainers_controller.dart';
import 'package:fitflow/modules/admin/users/trainers/widget/edit_trainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget trainersListView(AdminTrainerController controller) {
  return ListView.builder(
    itemCount: controller.filteredTrainers.length,
    padding: const EdgeInsets.only(bottom: 24),
    itemBuilder: (context, index) {
      final trainer = controller.filteredTrainers[index];
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      trainer.name[0].toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trainer.name,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(trainer.email, style: AppTextStyles.caption),
                    ],
                  ),
                ),
                _buildStatusChip(trainer.status),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(height: 1, thickness: 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: Text(
                        trainer.specialization.toUpperCase(),
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${trainer.rating}',
                          style: AppTextStyles.caption.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildCircleAction(
                      icon: Icons.edit_rounded,
                      color: AppColors.primaryBlue,
                      onTap: () =>
                          showEditTrainerUI(Get.context!, trainer, controller),
                    ),
                    const SizedBox(width: 8),
                    _buildCircleAction(
                      icon: Icons.delete_outline_rounded,
                      color: AppColors.error,
                      onTap: () => _showDeleteConfirmation(trainer, controller),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildCircleAction({
  required IconData icon,
  required Color color,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20),
    ),
  );
}

void _showDeleteConfirmation(
  TrainerModel trainer,
  AdminTrainerController controller,
) {
  Get.dialog(
    AlertDialog(
      backgroundColor: AppColors.background,
      title: const Text('Delete Trainer'),
      content: Text(
        'Are you sure you want to remove ${trainer.name}? This action cannot be undone.',
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
        TextButton(
          onPressed: () {
            controller.deleteTrainer(trainer.id);
            Get.back();
          },
          child: const Text('Delete', style: TextStyle(color: AppColors.error)),
        ),
      ],
    ),
  );
}

Widget _buildStatusChip(String status) {
  Color color = status == 'Active' ? AppColors.success : AppColors.error;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Text(
      status,
      style: AppTextStyles.caption.copyWith(
        color: color,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
