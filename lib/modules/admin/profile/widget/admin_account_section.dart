import 'package:fitflow/modules/admin/profile/controller/admin_profile_controller.dart';
import 'package:fitflow/modules/admin/profile/finance/finance_page.dart';
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
        onTap: () {},
      ),
      const Divider(height: 1),
      buildProfileListTile(
        icon: Icons.receipt_long_rounded,
        title: 'View Transactions',
        subtitle: 'All in/out financial records',
        onTap: () => Get.to(() => const FinancePage()),
      ),
    ],
  );
}
