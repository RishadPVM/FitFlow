import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitflow/core/theme/app_colors.dart';
import 'package:fitflow/core/theme/app_text_styles.dart';
import '../controller/admin_profile_controller.dart';
import '../../finance/finance_page.dart';
import 'shared_components.dart';

Widget buildAdminFinanceSection(BuildContext context, AdminProfileController controller) {
  return buildProfileSection(
    title: 'Finance Overview',
    children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildFinanceSummaryCard('Total Revenue', controller.totalRevenue.value, Icons.account_balance_wallet_rounded, AppColors.secondaryGreen)),
                const SizedBox(width: 12),
                Expanded(child: _buildFinanceSummaryCard('Monthly', controller.monthlyEarnings.value, Icons.trending_up_rounded, AppColors.primaryBlue)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildFinanceSummaryCard('Pending', controller.pendingPayments.value, Icons.pending_actions_rounded, Colors.orange)),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () {}, // Add Expense
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.divider, style: BorderStyle.solid),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add_rounded, color: AppColors.primaryBlue, size: 28),
                          const SizedBox(height: 4),
                          Text('Add Expense', style: AppTextStyles.caption.copyWith(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      const Divider(height: 1),
      buildProfileListTile(
        icon: Icons.receipt_long_rounded,
        title: 'View Transactions List',
        subtitle: 'All in/out financial records',
        onTap: () => Get.to(() => const FinancePage()),
      ),
    ],
  );
}

Widget _buildFinanceSummaryCard(String title, String value, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.divider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Text(title, style: AppTextStyles.caption),
          ],
        ),
        const SizedBox(height: 8),
        Text(value, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    ),
  );
}
