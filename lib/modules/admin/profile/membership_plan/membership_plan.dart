import 'package:fitflow/modules/admin/profile/membership_plan/widget/membership_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'controller/membership_plan_controller.dart';
import 'widget/create_plan_bottom_sheet.dart';
import 'widget/membership_plan_card.dart';

class MembershipPlanPage extends StatelessWidget {
  const MembershipPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject Controller
    final controller = Get.put(MembershipPlanController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text('Membership Plans', style: AppTextStyles.h2),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: AppColors.surfaceLight,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: AppColors.divider),
                ),
              ),
              icon: const Icon(Icons.add),
              onPressed: () => CreatePlanBottomSheet.show(),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          membershipSearchAndFilter(controller),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              if (controller.filteredPlans.isEmpty) {
                return _buildEmptyState();
              }
              return ListView.builder(
                itemCount: controller.filteredPlans.length,
                padding: const EdgeInsets.only(bottom: 100),
                itemBuilder: (context, index) {
                  final plan = controller.filteredPlans[index];
                  return MembershipPlanCard(
                    plan: plan,
                    onEdit: () => CreatePlanBottomSheet.show(plan: plan),
                    onDelete: () =>
                        _showDeleteConfirmation(context, controller, plan.id),
                    onToggleStatus: (_) => controller.togglePlanStatus(plan.id),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 80,
            color: AppColors.textSecondary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No Plans Found',
            style: AppTextStyles.h3.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters.',
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    MembershipPlanController controller,
    String planId,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Delete Plan', style: AppTextStyles.h3),
        content: Text(
          'Are you sure you want to delete this membership plan? This action cannot be undone.',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.deletePlan(planId);
              Get.back();
              Get.snackbar(
                'Deleted',
                'Plan deleted successfully.',
                backgroundColor: AppColors.error.withValues(alpha: 0.9),
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: Text('Delete', style: AppTextStyles.buttonText),
          ),
        ],
      ),
    );
  }
}
