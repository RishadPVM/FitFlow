import 'package:fitflow/modules/admin/users/trainers/widget/empty_state.dart';
import 'package:fitflow/modules/admin/users/trainers/widget/search_filtter.dart';
import 'package:fitflow/modules/admin/users/trainers/widget/trainer_form.dart';
import 'package:fitflow/modules/admin/users/trainers/widget/trainers_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/app_loader.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'controller/trainers_controller.dart';

class TrainersPage extends GetView<TrainersController> {
  const TrainersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: AppLoader());
      }

      return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Trainers', style: AppTextStyles.h3),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${controller.totalTrainersCount} Total trainers',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () => _showAddTrainerUI(context, controller),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.person_add_rounded, size: 20),
                  label: Text(
                    'Add Trainer',
                    style: AppTextStyles.buttonText.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            searchFilterBar(controller),
            const SizedBox(height: 24),
            if (controller.filteredTrainers.length !=
                controller.totalTrainersCount)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Showing ${controller.filteredTrainersCount} results',
                  style: AppTextStyles.caption.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            Expanded(
              child: controller.filteredTrainers.isEmpty
                  ? trainersEmptyState(controller)
                  : trainersListView(controller),
            ),
          ],
        ),
      );
    });
  }

  void _showAddTrainerUI(BuildContext context, TrainersController controller) {
    showTrainerForm(context, null, controller);
  }
}
