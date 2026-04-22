import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../common/widgets/app_loader.dart';
import '../../../../common/widgets/app_button.dart';
import 'finance_controller.dart';

class FinancePage extends GetView<FinanceController> {
  const FinancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finance & Payments', style: AppTextStyles.h2),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: AppLoader());
        }

      return LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 800;
          return Padding(
            padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
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
                        Text('Financial Management', style: isMobile ? AppTextStyles.h3 : AppTextStyles.h2),
                        const SizedBox(height: 4),
                        Text(
                          'Overview of gym revenue and transactions',
                          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                    AppButton(
                      text: isMobile ? 'Export' : 'Export Report',
                      width: isMobile ? 100 : 150,
                      onPressed: () {
                        // Mock export
                        Get.snackbar('Export', 'Financial report downloading...', snackPosition: SnackPosition.BOTTOM);
                      },
                    ),
                  ],
                ),
                SizedBox(height: isMobile ? 20 : 32),
                _buildStatsCards(isMobile),
                SizedBox(height: isMobile ? 20 : 32),
                _buildManagementBar(isMobile),
                const SizedBox(height: 24),
                if (controller.filteredTransactions.length != controller.totalTransactionsCount)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Showing ${controller.filteredTransactionsCount} transactions',
                      style: AppTextStyles.caption.copyWith(fontStyle: FontStyle.italic),
                    ),
                  ),
                Expanded(
                  child: controller.filteredTransactions.isEmpty
                      ? _buildEmptyState()
                      : isMobile
                          ? _buildMobileView()
                          : _buildDesktopView(context),
                ),
              ],
            ),
          );
        },
      );
    }),
    );
  }

  Widget _buildStatsCards(bool isMobile) {
    return isMobile
        ? Column(
            children: [
              _buildStatCard('Total Revenue', '\$${controller.totalRevenue.value.toStringAsFixed(2)}', Icons.account_balance_wallet_rounded, AppColors.success),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildStatCard('Outstanding', '\$${controller.outstandingPayments.value.toStringAsFixed(2)}', Icons.payment_rounded, AppColors.error)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildStatCard('Active Plans', '${controller.activeMemberships.value}', Icons.card_membership_rounded, AppColors.primaryBlue)),
                ],
              ),
            ],
          )
        : Row(
            children: [
              Expanded(child: _buildStatCard('Total Revenue', '\$${controller.totalRevenue.value.toStringAsFixed(2)}', Icons.account_balance_wallet_rounded, AppColors.success)),
              const SizedBox(width: 24),
              Expanded(child: _buildStatCard('Outstanding', '\$${controller.outstandingPayments.value.toStringAsFixed(2)}', Icons.payment_rounded, AppColors.error)),
              const SizedBox(width: 24),
              Expanded(child: _buildStatCard('Active Plans', '${controller.activeMemberships.value}', Icons.card_membership_rounded, AppColors.primaryBlue)),
            ],
          );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                Text(value, style: AppTextStyles.h3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManagementBar(bool isMobile) {
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
      child: isMobile
          ? Column(
              children: [
                _buildSearchInput(),
                const SizedBox(height: 12),
                _buildFiltersRow(),
              ],
            )
          : Row(
              children: [
                Expanded(child: _buildSearchInput()),
                const SizedBox(width: 16),
                _buildFiltersRow(),
              ],
            ),
    );
  }

  Widget _buildSearchInput() {
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
          hintText: 'Search by TXN or Member...',
          hintStyle: AppTextStyles.caption.copyWith(color: AppColors.textSecondary.withValues(alpha: 0.6)),
          prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textSecondary, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildFiltersRow() {
    return Row(
      children: [
        _buildPremiumDropdown(
          icon: Icons.filter_list_rounded,
          value: controller.statusFilter.value,
          items: ['All', 'Paid', 'Pending', 'Overdue'],
          onChanged: (val) => controller.statusFilter.value = val!,
        ),
        if (controller.searchQuery.value.isNotEmpty || controller.statusFilter.value != 'All')
          IconButton(
            onPressed: () {
              controller.searchQuery.value = '';
              controller.statusFilter.value = 'All';
            },
            icon: const Icon(Icons.refresh_rounded, color: AppColors.error, size: 20),
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
            style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
            items: items.map((item) {
              bool isSelected = item == value;
              return DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(color: isSelected ? AppColors.primaryBlue : AppColors.textPrimary),
                ),
              );
            }).toList(),
            onChanged: onChanged,
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
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.receipt_long_rounded, size: 64, color: AppColors.textSecondary.withValues(alpha: 0.3)),
          ),
          const SizedBox(height: 24),
          Text('No transactions found', style: AppTextStyles.h3),
          const SizedBox(height: 8),
          Text(
            'We couldn\'t find any records matching your current filters.',
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
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMobileView() {
    return ListView.builder(
      itemCount: controller.filteredTransactions.length,
      padding: const EdgeInsets.only(bottom: 24),
      itemBuilder: (context, index) {
        final txn = controller.filteredTransactions[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(txn.id, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                  _buildStatusChip(txn.status),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(height: 1, thickness: 1),
              ),
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        txn.memberName[0].toUpperCase(),
                        style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(txn.memberName, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                        Text(txn.planName, style: AppTextStyles.caption),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('\$${txn.amount.toStringAsFixed(2)}', style: AppTextStyles.h3),
                      Text(DateFormat('MMM dd, yyyy').format(txn.date), style: AppTextStyles.caption),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDesktopView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 320),
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(AppColors.background.withValues(alpha: 0.5)),
                headingTextStyle: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                dataTextStyle: AppTextStyles.bodyMedium,
                dividerThickness: 1,
                columnSpacing: 40,
                horizontalMargin: 24,
                columns: const [
                  DataColumn(label: Text('TXN ID')),
                  DataColumn(label: Text('MEMBER')),
                  DataColumn(label: Text('PLAN')),
                  DataColumn(label: Text('DATE')),
                  DataColumn(label: Text('AMOUNT')),
                  DataColumn(label: Text('STATUS')),
                  DataColumn(label: Text('ACTIONS')),
                ],
                rows: controller.filteredTransactions.map((txn) {
                  return DataRow(
                    cells: [
                      DataCell(Text(txn.id, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textSecondary))),
                      DataCell(
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
                              child: Text(txn.memberName[0], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                            ),
                            const SizedBox(width: 10),
                            Text(txn.memberName, style: const TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      DataCell(Text(txn.planName)),
                      DataCell(Text(DateFormat('MMM dd, yyyy').format(txn.date))),
                      DataCell(Text('\$${txn.amount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(_buildStatusChip(txn.status)),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.receipt_rounded, color: AppColors.primaryBlue, size: 20),
                            tooltip: 'View Invoice',
                            onPressed: () {
                              Get.snackbar('Invoice', 'Opening invoice for ${txn.id}');
                            },
                          ),
                        ],
                      )),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Paid':
        color = AppColors.success;
        break;
      case 'Pending':
        color = Colors.orange;
        break;
      case 'Overdue':
        color = AppColors.error;
        break;
      default:
        color = AppColors.textSecondary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        status,
        style: AppTextStyles.caption.copyWith(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
