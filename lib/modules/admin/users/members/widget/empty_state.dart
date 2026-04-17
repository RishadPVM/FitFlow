import 'package:fitflow/common/widgets/app_button.dart';
import 'package:fitflow/core/theme/app_colors.dart';
import 'package:fitflow/core/theme/app_text_styles.dart';
import 'package:fitflow/modules/admin/users/members/controller/admin_members_controller.dart';
import 'package:flutter/material.dart';

Widget membersEmptyState(AdminMembersController controller) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.group_off_rounded,
            size: 64,
            color: AppColors.textSecondary.withValues(alpha: 0.3),
          ),
        ),
        const SizedBox(height: 24),
        Text('No matching members', style: AppTextStyles.h3),
        const SizedBox(height: 8),
        Text(
          'We couldn\'t find any members matching your current filters.',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium,
        ),
        const SizedBox(height: 24),
        AppButton(
          text: 'Clear All Filters',
          width: 200,
          onPressed: () {
            controller.searchQuery.value = '';
            controller.statusFilter.value = 'All';
            controller.planFilter.value = 'All';
          },
        ),
      ],
    ),
  );
}
