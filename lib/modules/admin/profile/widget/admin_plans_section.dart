import 'package:flutter/material.dart';
import 'package:fitflow/core/theme/app_colors.dart';
import 'package:fitflow/core/theme/app_text_styles.dart';
import 'shared_components.dart';

Widget buildAdminMembershipSection() {
  return buildProfileSection(
    title: 'Membership Plans',
    children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildPlanCard(
              name: 'Pro Tier',
              price: '\$50/mo',
              duration: 'Monthly',
              isActive: true,
              benefits: ['24/7 Access', 'Free Group Classes', '1 PT Session/mo'],
            ),
            const SizedBox(height: 12),
            _buildPlanCard(
              name: 'Elite Annual',
              price: '\$450/yr',
              duration: 'Yearly',
              isActive: true,
              benefits: ['All Pro Benefits', 'Unlimited Guest Passes', 'Locker Included'],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_circle_outline_rounded, size: 20),
                label: const Text('Create New Plan'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryBlue,
                  side: const BorderSide(color: AppColors.primaryBlue),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildPlanCard({
  required String name,
  required String price,
  required String duration,
  required bool isActive,
  required List<String> benefits,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.divider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                Text('$price • $duration', style: AppTextStyles.caption.copyWith(color: AppColors.primaryBlue)),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: (isActive ? AppColors.success : AppColors.textSecondary).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                isActive ? 'Active' : 'Inactive',
                style: AppTextStyles.caption.copyWith(color: isActive ? AppColors.success : AppColors.textSecondary, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...benefits.map((benefit) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              const Icon(Icons.check_circle_outline_rounded, size: 14, color: AppColors.success),
              const SizedBox(width: 8),
              Text(benefit, style: AppTextStyles.caption),
            ],
          ),
        )),
      ],
    ),
  );
}
