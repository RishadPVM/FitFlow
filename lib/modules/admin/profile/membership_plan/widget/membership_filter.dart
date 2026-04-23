import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../controller/membership_plan_controller.dart';

Widget membershipSearchAndFilter(MembershipPlanController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) => controller.searchQuery.value = value,
              style: AppTextStyles.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Search plans...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                ),
                fillColor: AppColors.surfaceLight,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Obx(
              () => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: controller.selectedDurationFilter.value,
                  dropdownColor: AppColors.surfaceLight,
                  icon: const Icon(
                    Icons.filter_list,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  style: AppTextStyles.bodyMedium,
                  items: ['All', '1 Month', '3 Months', 'Yearly'].map((
                    String value,
                  ) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectedDurationFilter.value = value;
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }