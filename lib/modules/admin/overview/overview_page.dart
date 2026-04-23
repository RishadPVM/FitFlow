import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../common/widgets/app_loader.dart';
import 'controller/overview_controller.dart';
import 'widget/stat_card.dart';
import 'widget/analytics_chart.dart';
import 'widget/activity_widget.dart';

class OverviewPage extends GetView<OverviewController> {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.refreshData,
          color: AppColors.primary,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back, Admin',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Dashboard Overview',
                        style: AppTextStyles.h1.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Obx(() {
                if (controller.error.isNotEmpty && controller.totalUsers.value == 0) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(
                        controller.error.value,
                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
                      ),
                    ),
                  );
                }

                if (controller.isLoading.value && controller.totalUsers.value == 0) {
                  return const SliverFillRemaining(
                    child: Center(child: AppLoader()),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // STATS GRID
                      Row(
                        children: [
                          Expanded(
                            child: StatCard(
                              title: 'Total Users',
                              value: controller.totalUsers.value.toString(),
                              icon: Icons.people_alt_rounded,
                              accentColor: AppColors.primaryBlue,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: StatCard(
                              title: 'Active Users',
                              value: controller.activeUsers.value.toString(),
                              icon: Icons.check_circle_outline_rounded,
                              accentColor: AppColors.secondaryGreen,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: StatCard(
                              title: 'Live Now',
                              value: controller.workingUsers.value.toString(),
                              icon: Icons.bolt_rounded,
                              accentColor: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: StatCard(
                              title: 'Pending Fees',
                              value: '\$${controller.pendingAmount.value.toStringAsFixed(0)}',
                              subtitle: '${controller.pendingUsersCount.value} users',
                              icon: Icons.warning_amber_rounded,
                              accentColor: AppColors.error,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // ANALYTICS SECTION
                      if (controller.userGrowthData.isNotEmpty) ...[
                        AnalyticsChart(
                          labels: controller.userGrowthData.map((e) => e.label).toList(),
                          values: controller.userGrowthData.map((e) => e.value).toList(),
                        ),
                        const SizedBox(height: 32),
                      ],

                      // LIVE ACTIVITY SECTION
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Live Activity',
                            style: AppTextStyles.h3.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'View All',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      if (controller.liveActivityList.isEmpty)
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              'No recent activity',
                              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                            ),
                          ),
                        )
                      else
                        ...controller.liveActivityList.map((log) {
                          return LiveActivityWidget(
                            userName: log.userName,
                            action: log.action,
                            time: log.time,
                            isEntry: log.isEntry,
                          );
                        }),
                        
                      const SizedBox(height: 100), // Bottom padding
                    ]),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
