import 'package:fitflow/core/theme/app_colors.dart';
import 'package:fitflow/modules/admin/profile/controller/admin_profile_controller.dart';
import 'package:fitflow/modules/admin/profile/finance/finance_page.dart';
import 'package:fitflow/modules/admin/profile/membership_plan/membership_plan.dart';
import 'package:fitflow/modules/admin/profile/widget/shared_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildAdminAccountManagementSection(
  BuildContext context,
  AdminProfileController controller,
) {
  return buildProfileSection(
    title: 'Account Management',
    children: [
      buildProfileListTile(
        icon: Icons.card_membership_rounded,
        title: 'Membership Plans',
        subtitle: 'Manage your membership plans',
        // color: AppColors.primaryBlue,
        onTap: () => Get.to(() => const MembershipPlanPage()),
      ),
      const Divider(height: 1, color: AppColors.divider),
      buildProfileListTile(
        icon: Icons.receipt_long_rounded,
        title: 'View Transactions',
        subtitle: 'All in/out financial records',
        // color: AppColors.primary,
        onTap: () => Get.to(() => const FinancePage()),
      ),
    ],
  );
}
