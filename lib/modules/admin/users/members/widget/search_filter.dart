import 'package:fitflow/core/theme/app_colors.dart';
import 'package:fitflow/core/theme/app_text_styles.dart';
import 'package:fitflow/modules/admin/users/members/controller/admin_members_controller.dart';
import 'package:flutter/material.dart';

Widget searchFilterBar(AdminMembersController controller) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.surfaceLight,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.02),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        _buildSearchInput(controller),
        const SizedBox(height: 12),
        _buildFiltersRow(controller),
      ],
    ),
  );
}

Widget _buildSearchInput(AdminMembersController controller) {
  return Container(
    height: 48,
    decoration: BoxDecoration(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.divider),
    ),
    child: TextField(
      onChanged: (val) => controller.searchQuery.value = val,
      style: AppTextStyles.bodyMedium,
      decoration: InputDecoration(
        hintText: 'Search by name, email...',
        hintStyle: AppTextStyles.caption.copyWith(
          color: AppColors.textSecondary.withValues(alpha: 0.6),
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.textSecondary,
          size: 20,
        ),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
    ),
  );
}

Widget _buildFiltersRow(AdminMembersController controller) {
  return Row(
    children: [
      _buildPremiumDropdown(
        icon: Icons.filter_list_rounded,
        value: controller.statusFilter.value,
        items: ['All', 'Active', 'Expired'],
        onChanged: (val) => controller.statusFilter.value = val!,
      ),
      const SizedBox(width: 8),
      _buildPremiumDropdown(
        icon: Icons.card_membership_rounded,
        value: controller.planFilter.value,
        items: ['All', 'Basic', 'Pro', 'Elite'],
        onChanged: (val) => controller.planFilter.value = val!,
      ),
      if (controller.searchQuery.value.isNotEmpty ||
          controller.statusFilter.value != 'All' ||
          controller.planFilter.value != 'All')
        IconButton(
          onPressed: () {
            controller.searchQuery.value = '';
            controller.statusFilter.value = 'All';
            controller.planFilter.value = 'All';
          },
          icon: const Icon(
            Icons.refresh_rounded,
            color: AppColors.error,
            size: 20,
          ),
          tooltip: 'Reset Filters',
        ),
    ],
  );
}

Widget _buildPremiumDropdown({
  required IconData icon,
  required String value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    height: 48,
    decoration: BoxDecoration(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.divider),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        DropdownButton<String>(
          value: value,
          underline: const SizedBox(),
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
          items: items.map((item) {
            bool isSelected = item == value;
            return DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.primaryBlue
                      : AppColors.textPrimary,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    ),
  );
}
