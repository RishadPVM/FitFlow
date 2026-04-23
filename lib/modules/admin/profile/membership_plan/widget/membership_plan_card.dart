import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../models/membership_plan_model.dart';

class MembershipPlanCard extends StatelessWidget {
  final MembershipPlanModel plan;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged<bool> onToggleStatus;

  const MembershipPlanCard({
    super.key,
    required this.plan,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: plan.isPopular ? AppColors.primaryBlue : AppColors.divider,
          width: plan.isPopular ? 1.5 : 1.0,
        ),
        boxShadow: [
          if (plan.isPopular)
            BoxShadow(
              color: AppColors.primaryBlue.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (plan.isPopular)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: const BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'MOST POPULAR',
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                _buildPriceAndDuration(),
                const SizedBox(height: 16),
                _buildFeaturesList(),
                const SizedBox(height: 16),
                const Divider(color: AppColors.divider, height: 1),
                const SizedBox(height: 16),
                _buildFooterStats(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            plan.name,
            style: AppTextStyles.h3,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: plan.isActive
                    ? AppColors.success.withValues(alpha: 0.1)
                    : AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: plan.isActive ? AppColors.success : AppColors.error,
                  width: 1,
                ),
              ),
              child: Text(
                plan.isActive ? 'Active' : 'Inactive',
                style: AppTextStyles.caption.copyWith(
                  color: plan.isActive ? AppColors.success : AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
              color: AppColors.surfaceLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) {
                if (value == 'edit') onEdit();
                if (value == 'delete') onDelete();
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      const Icon(Icons.edit, size: 18, color: AppColors.primaryBlue),
                      const SizedBox(width: 8),
                      Text('Edit Plan', style: AppTextStyles.bodyMedium),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      const Icon(Icons.delete, size: 18, color: AppColors.error),
                      const SizedBox(width: 8),
                      Text('Delete Plan', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceAndDuration() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '₹${plan.price.toStringAsFixed(0)}',
          style: AppTextStyles.h1.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(width: 4),
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            '/ ${_formatDuration(plan.durationInMonths)}',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: plan.features.take(3).map((feature) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Row(
            children: [
              const Icon(Icons.check_circle, size: 16, color: AppColors.secondaryGreen),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  feature,
                  style: AppTextStyles.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFooterStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.group, size: 16, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            Text(
              '${plan.activeMembers} Members',
              style: AppTextStyles.caption,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Visibility',
              style: AppTextStyles.caption,
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 24,
              child: Switch(
                value: plan.isActive,
                onChanged: onToggleStatus,
                activeThumbColor: AppColors.primaryBlue,
                activeTrackColor: AppColors.primaryBlue.withValues(alpha: 0.3),
                inactiveThumbColor: AppColors.textSecondary,
                inactiveTrackColor: AppColors.surfaceLight,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatDuration(int months) {
    if (months == 1) return 'Month';
    if (months == 12) return 'Year';
    return '$months Months';
  }
}
